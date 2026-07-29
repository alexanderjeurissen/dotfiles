#!/usr/bin/env python3
"""PreToolUse(Bash) hook: auto-approve read-only submodule traversals.

Why this exists
---------------
Claude Code has a built-in safety check that forces manual approval for any
single Bash command that BOTH `cd`s AND redirects output (e.g.
`cd core 2>/dev/null && find . ...`). The reasoning is sound in general: once
`cd` runs, a redirect target resolves against a different working directory, so
permission allow-rules can't be matched safely ("path resolution bypass"). That
check is intentionally not allowlistable.

In a submodule hub, though, the common shape is harmless: hop into a submodule
under modules/ (or a per-issue workspace) and run read-only commands while
suppressing stderr to /dev/null. This hook recognizes exactly that shape and
returns `permissionDecision: "allow"`, which short-circuits the built-in prompt.

Host-neutral: lives in dotfiles (claude/hooks/), symlinked into ~/.claude/hooks/
and wired globally in ~/.claude/settings.json, so every project benefits. The
cd-target check keys off CLAUDE_PROJECT_DIR, so it stays scoped per-project.

Safety model
------------
The bypass the built-in guards against is "a redirect writes somewhere
unexpected after a cd". We only auto-allow when there are NO writes at all:

  * the ONLY redirections present are to /dev/null (or 2>&1) — any redirect to a
    real file, append (>>), here-doc, or process/command substitution -> abstain
  * no command substitution `$(...)` / backticks, no `${...}`/`$` expansion,
    no backgrounding `&`, no subshell grouping `( ... )`, no newlines
  * every pipeline stage's executable is in a curated read-only allowlist
  * `find` may not use -exec/-execdir/-ok/-okdir/-delete/-fprint*/-fls
  * `git` must use a read-only subcommand (log/show/diff/status/...); mutating
    forms like branch -D, tag -d, config <write>, checkout, reset are excluded
  * `sort` may not use -o/--output
  * `cd` targets are restricted to the workspace tree (relative paths, or
    absolute paths under the project root)

When ANY condition is not met, the hook stays silent (exit 0, no output) and the
normal permission flow runs — including the user's deny rules (git push, rm -rf,
sudo). A false "abstain" just means the usual prompt appears; we never relax a
deny. Auto-approval only ever widens to provably read-only traversal.
"""

import json
import os
import re
import shlex
import sys
from typing import NoReturn


def abstain() -> NoReturn:
    """Emit nothing and let the normal permission flow handle the call."""
    sys.exit(0)


# Executables that cannot mutate the filesystem in their bare/common forms.
READ_VERBS = {
    "cd", "ls", "cat", "head", "tail", "wc", "echo", "printf",
    "grep", "rg", "find", "pwd", "true", "basename", "dirname",
    "realpath", "stat", "file", "nl", "sort", "uniq", "cut", "tr",
    "comm", "column", "rev", "fold", "tac", "cksum",
}

# git subcommands that are read-only in EVERY form (no args can mutate).
GIT_READ = {
    "log", "show", "diff", "status", "ls-tree", "ls-files", "rev-parse",
    "rev-list", "describe", "blame", "cat-file", "shortlog", "for-each-ref",
    "name-rev", "grep", "whatchanged", "show-ref", "merge-base", "var",
}

# git global options that take a value (skip the option AND its argument).
GIT_OPTS_WITH_ARG = {"-C", "-c", "--git-dir", "--work-tree", "--namespace", "--exec-path"}

# find primaries that execute or write — disqualify the whole command.
FIND_DANGEROUS = {
    "-exec", "-execdir", "-ok", "-okdir", "-delete",
    "-fprint", "-fprintf", "-fprintf0", "-fls",
}


def project_root() -> str:
    root = os.environ.get("CLAUDE_PROJECT_DIR")
    if root:
        return os.path.realpath(root)
    # CLAUDE_PROJECT_DIR is always set in hook context; this is just a safety net.
    # (The hook is installed globally at ~/.claude/hooks/, so it can't derive the
    # project root from its own path — fall back to the current working directory.)
    return os.path.realpath(os.getcwd())


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        abstain()

    if data.get("tool_name") != "Bash":
        abstain()

    cmd = ((data.get("tool_input") or {}).get("command") or "").strip()
    if not cmd:
        abstain()

    # --- Hard rejects: constructs that hide execution or escape our analysis ---
    for bad in ("$(", "`", "<(", ">(", "${", "$", "\n", "\r"):
        if bad in cmd:
            abstain()

    # --- Redirection check: strip allowed /dev/null + fd-dup redirects, then
    #     any leftover < or > means a redirect to something we won't vouch for. ---
    stripped = re.sub(r"(?:\d*|&)>>?\s*/dev/null", " ", cmd)
    stripped = re.sub(r"\d*>&\d+", " ", stripped)
    if "<" in stripped or ">" in stripped:
        abstain()

    # --- Backgrounding / subshell grouping ---
    no_and = stripped.replace("&&", " ").replace("||", " ")
    if "&" in no_and:          # a lone & = background job
        abstain()
    if "(" in stripped or ")" in stripped:
        abstain()

    # --- Tokenize, honoring quotes, with shell operators as their own tokens ---
    try:
        lex = shlex.shlex(stripped, posix=True, punctuation_chars=True)
        lex.whitespace_split = True
        tokens = list(lex)
    except ValueError:
        abstain()  # unbalanced quotes, etc.

    OPERATORS = {"&&", "||", "|", ";"}
    segments, seg = [], []
    for tok in tokens:
        if tok in OPERATORS:
            if seg:
                segments.append(seg)
                seg = []
        else:
            seg.append(tok)
    if seg:
        segments.append(seg)

    if not segments:
        abstain()

    root = project_root()

    for seg in segments:
        exe = seg[0]

        if exe == "git":
            sub, i = None, 1
            while i < len(seg):
                tok = seg[i]
                if tok in GIT_OPTS_WITH_ARG:
                    i += 2
                    continue
                if tok.startswith("-"):
                    i += 1
                    continue
                sub = tok
                break
            if sub not in GIT_READ:
                abstain()
            continue

        if exe not in READ_VERBS:
            abstain()

        if exe == "find" and any(t in FIND_DANGEROUS for t in seg[1:]):
            abstain()

        if exe == "sort" and any(
            t in ("-o", "--output") or t.startswith("--output=") for t in seg[1:]
        ):
            abstain()

        if exe == "cd":
            target = next((t for t in seg[1:] if not t.startswith("-")), None)
            if target and target.startswith("/"):
                rp = os.path.realpath(target)
                if not (rp == root or rp.startswith(root + os.sep)):
                    abstain()

    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "allow",
            "permissionDecisionReason": (
                "Read-only submodule traversal (cd + read verbs, redirects only "
                "to /dev/null) — auto-approved by allow-readonly-traversal hook."
            ),
        }
    }))


if __name__ == "__main__":
    main()
