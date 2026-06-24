---
description: >-
  Bring a per-issue workspace's feature branches up to date by MERGING each submodule's integration
  branch in (never rebase), then pushing. Auto-resolves mechanical merge conflicts (e.g. append-only
  migration lists); asks you when a resolution is ambiguous. Auto-targets the cmux workspace it's run
  from. Does not touch the tracker or the hub repo.
argument-hint: "[ISSUE-ID] (optional — omit to target the current workspace or pick from a list)"
allowed-tools: Bash Read Edit AskUserQuestion
disable-model-invocation: true
---
Sync a per-issue workspace (requested target: **$ARGUMENTS**).

This is the `/workspace-sync` command. It keeps the issue's feature branch(es) current with their
integration branches and pushes — so the work is durable and the manifest stays a valid
reconstruction recipe. **Merge strategy (not rebase)**: no history rewriting, no force-push,
PR/MR-review-friendly. When a merge conflicts, this command **resolves it** (automatically for
mechanical collisions, with your input when the right answer is unclear) rather than stopping.

## Step 0 — Resolve the target workspace

The ISSUE-ID argument is **optional**. Resolve the target in this order, then carry the resolved
**ISSUE-ID** through the rest of the command (no `cd` — the engine self-anchors; resolve
`HUB="$(workspace hub)"` once for the manifest-fallback read and absolute worktree paths):

1. **Explicit arg.** If `$ARGUMENTS` is non-empty, use it as the ISSUE-ID.

2. **Auto-detect the caller workspace.** Otherwise, identify the cmux workspace this session is
   running in and read its working directory — if that dir is inside `worktrees/<ISSUE>/`, that's
   the target (the common case: "sync the workspace I'm in"):
   ```bash
   CALLER=$(cmux identify --json | python3 -c "import sys,json; print(json.load(sys.stdin)['caller']['workspace_ref'])")
   cmux list-workspaces --json | python3 -c "
   import sys, json, re
   caller = '$CALLER'
   for w in json.load(sys.stdin)['workspaces']:
       if w['ref'] == caller:
           m = re.search(r'/worktrees/([^/]+)', w.get('current_directory') or '')
           print(m.group(1) if m else '')
   "
   ```
   If a non-empty ISSUE is printed, that's the target. If empty (e.g. you're at the hub), fall
   through to (3).

3. **Pick from a list.** Run `cmux list-workspaces` (plain text shows the
   `workspace:<N>  <ISSUE-ID> · <title>` names). Filter out non-issue rows (`Root`, etc.) and
   present the issue workspaces via `AskUserQuestion`. Capture the ISSUE-ID (token before ` · `). As
   a fallback, the manifest also lists active workspaces:
   `git -C "$HUB" show HEAD:worktrees/WORKSPACES.md`.

## Step 1 — Run the engine
```bash
workspace sync --issue <ISSUE-ID>
```
For each in-scope submodule worktree under `worktrees/<ISSUE-ID>/modules/<repo>`, the engine:
`fetch origin/<integration-branch>` → `git merge --no-edit origin/<integration-branch>` →
`git push` (plain; sets upstream on first push). The integration branch is resolved from the
**top-level** checkout.

The engine prints one line per submodule:
- `OK <repo>: …` — merged + pushed. Nothing more to do.
- `CONFLICT <repo>: …` — the merge is **left in progress** in `worktrees/<ISSUE-ID>/modules/<repo>`.
  Go to step 2. (The engine stops at the first conflict and exits non-zero; that's expected — this
  command drives the resolution and re-runs.)
- `ERROR <repo>: …` — fetch/push failed (offline, network, or remote moved). Relay it; not a conflict.

## Step 2 — Resolve conflicts (auto where mechanical, ask where ambiguous)

For each repo the engine reported `CONFLICT`, work inside its worktree
(`$HUB/worktrees/<ISSUE-ID>/modules/<repo>`). List the unmerged files:
```bash
git -C "$HUB/worktrees/<ISSUE-ID>/modules/<repo>" diff --name-only --diff-filter=U
```
Resolve **every** conflicted file with the right tier below, then complete the merge.

### Tier A — Auto-resolve mechanical collisions (no need to ask)

These have one objectively-correct resolution. Resolve them directly (Edit), then continue.

- **Pure-append registries** — both sides append distinct lines to an ordered/append-only list and
  nothing else conflicts. **Resolution: union both sides**, deduped, preserving the file's existing
  order. The overwhelmingly common case is a **migration version list** (e.g. each branch appended
  its migration's `('<version>'),` line to a `schema_migrations` VALUES list): union all version
  lines from both `HEAD` and the incoming side, deduped, sorted to match the file's existing order,
  replacing the whole `<<<<<<< … >>>>>>>` block (including any `|||||||` diff3 base section).
  **Guard:** this is Tier A only when the conflict is confined to the append-only list and every
  conflicting line is a bare list entry. If the file has conflict hunks *elsewhere* (real divergence
  — a column/index/table or other logic defined differently on each side), those hunks are **Tier B**.
  Only union when you can see neither side *edited* the other's lines; when unsure, drop to Tier B.

### Tier B — Ask the user (ambiguous / semantic conflicts)

For any conflict where the correct merge isn't a mechanical union — overlapping edits to the same
code, schema/DDL divergence, logic both sides changed — **do not guess**. Read the conflict hunks so
you can describe them concretely:
```bash
git -C "$HUB/worktrees/<ISSUE-ID>/modules/<repo>" diff --diff-filter=U -- <file>
```
Then present the decision via `AskUserQuestion`, one question per conflicted file (or per hunk if a
file has several distinct ones). State the file/path and summarize what each side did. Offer:
- **A specific merged resolution you recommend** (first option) — describe exactly what it keeps from each side.
- **Take the integration branch's version** (theirs — the incoming side).
- **Keep the feature branch's version** (ours — the work in this worktree).
- (The user can always pick "Other" to describe a custom resolution.)

Apply the chosen resolution with Edit (for a hand-merged result) or, for a clean whole-file pick,
`git -C <worktree> checkout --ours <file>` / `--theirs <file>`. **Never silently discard either
side's changes** — that's exactly what Tier B exists to prevent.

### Complete the merge

Once a repo's files are all resolved (no markers remain — verify with
`grep -rn '^<<<<<<<\|^|||||||\|^=======\|^>>>>>>>' <files>`), stage and commit the merge:
```bash
git -C "$HUB/worktrees/<ISSUE-ID>/modules/<repo>" add <resolved files>
git -C "$HUB/worktrees/<ISSUE-ID>/modules/<repo>" commit --no-edit
```

## Step 3 — Re-run the engine to push (and catch any later repos)
```bash
workspace sync --issue <ISSUE-ID>
```
Re-running is idempotent: already-merged repos do an "already up to date" merge and push; any repo
the engine hadn't reached yet (it stops at the first conflict) now gets its turn. Repeat steps 2–3
until every repo reports `OK`.

**Pre-push hook note:** if a repo's pre-push hooks (linters, type-checks) require running dev
services and the push fails *only* because those services aren't up — and the failures are in files
pulled in by the merge, not this branch's own changes — say so and offer either to bring up the
worktree's dev stack and re-push, or to push with `--no-verify`. Don't bypass hooks when the
failures implicate this branch's actual changes.

## Step 4 — Summarize
Report which repos synced cleanly, which conflicts were auto-resolved (and how), which you asked
about (and the chosen resolution), and anything still needing attention.

## Guardrails
- **Merge, never rebase** — the engine enforces this; don't manually rebase feature branches here.
- **Never force-push.**
- **Auto-resolve only mechanical collisions** (Tier A) — union-style appends where neither side
  edited the other's lines. Everything semantic is **Tier B → ask**; never guess a code merge.
- **Never silently drop a side's changes** — a Tier-B resolution always reflects an explicit choice.
- **No tracker, no hub-repo commit** — posting a changeset summary to the issue is done by
  hand (out of scope for this command).
