# Workspace workflow (shared)

This is the host-neutral core of the per-issue workspace workflow, shared across every **hub** that
uses it. Each hub's own `CLAUDE.md`/`AGENTS.md` imports this file and then adds its repo-specific
bits (the actual submodules + remotes, integration branches, tracker/forge conventions). Nothing
here names a specific repository or organization — the engine discovers all of that at runtime.

Two terms carry the load (and used to collide — they're now distinct):

- **hub** = the top-level checkout — the stable integration view, containing `modules/` (submodules
  on their integration branches) and per-issue worktrees under `.claude/worktrees/`. It stays open as the home base. The git repo it's
  a checkout of is the **hub repo**.
- **workspace** = the per-issue, isolated environment for one unit of work — *materialized* as git
  *worktrees* (a top-level worktree of the hub + nested submodule worktrees) plus its cmux workspace.
  ("worktree" is the git mechanism; "workspace" is the thing you work in.)

Also: **issue** = the work identifier a workspace is keyed on (a tracker issue, a PR/MR, or an
ad-hoc slug); **PR/MR** = the merge request on whichever forge a submodule lives (GitHub PR, GitLab MR).

## Repository structure conventions

The hub is a checkout of a git repo (the *hub repo*) that groups **git submodules** for the
code/content repos under `modules/`. Work tracking and planning
live in the issue tracker (Linear), not in the repo. Each submodule is configured with `update=none`
— treat each as an independent git repo:

- To make changes: `cd modules/<repo>/ && git checkout <branch> && … && git commit && git push`.
- Each submodule has its own remote, branches, and history.
- **Before implementing changes**, ensure the target repo is on a feature branch (create one if needed).
- NEVER run `git submodule update` — it is a no-op by design (`update=none`).
- Git operations (add, commit, push, checkout) inside a submodule are scoped to that submodule's repo.

The hub repo may also track supporting assets (e.g. `mockups/`) — commit those from the hub.

### Pinning submodule state (auto-pin)

**Always auto-pin immediately after a commit lands in a submodule** in the *hub checkout*. As soon as
you commit (or rebase/reset to a new SHA) in a hub-checkout submodule, pin its new SHA in the hub repo:

```sh
git -C "$(workspace hub)" add modules/<repo>   # stages the submodule's current SHA as a gitlink
git -C "$(workspace hub)" commit -m "pin <repo> after <description>"
```

Submodule commit → hub-repo pin, every time. Stage only the gitlink(s) you changed so the pin commit
stays focused. **In the workspace workflow, pinning is consolidated into `/update-modules`**
(the single pinning path): feature commits land in per-issue *workspaces* and do **not** pin, while
the hub checkout is fast-forwarded to integration-branch tips and pinned there. The rule above still
governs any *direct* commit you make in a hub-checkout submodule, but in normal flow feature work
never touches the hub checkout, so that's rare.

## Per-issue workspaces

Parallel work on multiple issues happens in **isolated per-issue workspaces**, not by switching
branches in the hub's submodule checkouts. Each issue gets a "mini-workspace": a git worktree of *the
hub repo* at `.claude/worktrees/<ISSUE>/` (carrying `CLAUDE.md`/`AGENTS.md`, `.claude/`, `.cmux/`, `docs/`, …),
with a git worktree of each in-scope submodule nested inside it under `modules/<repo>` on the issue's
feature branch (mirroring the hub's `modules/` layout). Submodule object stores are shared (no
re-clone), and a cmux workspace cwd's into it — so the Claude instance sees a complete, isolated
environment.

```
<hub>/                          PRIMARY — the hub, a stable integration view
├─ modules/                     submodules on their integration branches
│  └─ repo-a/  repo-b/  …
└─ .claude/
   ├─ WORKSPACES.md             frozen legacy manifest (checkouts are gitignored)
   └─ worktrees/
      └─ <ISSUE>/               a per-issue workspace (worktree of the hub repo)
         ├─ CLAUDE.md .claude/ …  came free with the top-level worktree
         └─ modules/
            └─ repo-a/          worktree of repo-a on the feature branch (shared object store)
```

### The integration-branch invariant (load-bearing)

In the hub checkout, **each submodule sits on its integration branch** (e.g. `main`, or
`develop`/`master` where a repo uses those). The hub *is* the per-repo source of truth: every command
reads "what branch is this submodule on in the hub?" to decide the integration base. Nothing is
hardcoded. **Feature work never lives in the hub checkout — only in workspaces.**
`workspace integration-branch <repo>` resolves it and warns when a checkout diverges from its
`origin/HEAD` default (usually a sign of leaked feature work that wants migrating into a workspace).

### The four commands

| Command | What it does |
|---|---|
| `/workspace <name>` | Confirm repo scope, then `workspace bootstrap`: adopt the worktree the harness made (Claude Desktop / `claude --worktree`) or create one, materialize the in-scope submodule worktrees, share memory, and spawn a cmux workspace (Claude Code + terminal splits) cwd'd into it. Spawn mechanics only — no tracker, no manifest. |
| `/workspace-sync [name]` | **Merge** each submodule's integration branch into the feature branch (never rebase) + push. Auto-resolves mechanical conflicts, asks when ambiguous; auto-targets the worktree it's run from. No force-push. |
| `/update-modules` | Fast-forward the hub checkout's submodules to their integration tips + **pin**. The only pinning path. Run after upstream PRs/MRs merge. |
| `workspace teardown --name <name>` | Remove a worktree's submodule + hub worktrees, then prune (run from the hub; `--check` first for a safety report). `workspace prune` alone sweeps dangling registrations. Keeps feature branches. |

The engine `workspace` (on PATH, from `dotfiles/scripts/` via `~/.scripts`; shared across hubs and
discovering this hub's submodules + integration branches from `.gitmodules` and the hub checkout)
does the deterministic git/fs plumbing only — it never commits the hub repo, talks to a tracker, or
touches cmux. (`workspace hub` prints the hub path from anywhere; `$WORKSPACE_HUB` overrides it.) The
slash commands orchestrate scope confirmation, the hub-repo pin commits, and cmux spawning. The commands are global (`~/.claude/commands/`, symlinked from
`dotfiles/claude/commands/`), so every hub shares one copy.

### Shared Claude assets (host-neutral, dotfiles-managed)

Alongside the commands, dotfiles carries two more host-neutral layers, linked into `~/.claude/` by
`rcup` and therefore shared by every hub + every project:

- **`dotfiles/claude/skills/` → `~/.claude/skills/`** — global skills. The `cmux-*` family lives here
  (cmux is host-neutral), so hubs must **not** keep hub-local copies under `<hub>/.claude/skills/`.
- **`dotfiles/claude/hooks/` → `~/.claude/hooks/`** — global hooks. `allow-readonly-traversal.py` is
  wired as a `PreToolUse(Bash)` hook in `~/.claude/settings.json`; it auto-approves provably
  read-only `cd`+`/dev/null` submodule traversals (and only those — it abstains otherwise, keyed to
  `CLAUDE_PROJECT_DIR`), removing the built-in cd+redirect approval prompt.

To add either, drop the file under `dotfiles/claude/{skills,hooks}/` and run `rcup`.

### The manifest — `.claude/WORKSPACES.md` (frozen / deprecated)

Worktrees are now disposable and often hash-named (Claude Desktop / `claude --worktree` generate the
names), so the engine no longer maintains a manifest. Where a tracked `.claude/WORKSPACES.md` still
exists, it's a **frozen record** of the draining legacy `workspaces/` worktrees — delete it once
those are gone. Worktree checkouts stay gitignored (`.claude/worktrees/*/`, legacy `workspaces/*/`);
durability comes from `/workspace-sync` pushing the feature branches, not from a manifest.

### Memory & history

Because a workspace cwd's to `.claude/worktrees/<ISSUE>/`, Claude keys it as a separate project (separate
memory + history). `/workspace` symlinks that project's `memory/` → the canonical hub memory, so
**facts are shared** while **history stays isolated** per issue.

## cmux Workflow

cmux is the visual map of in-flight work. Each active issue gets **one cmux workspace** — the
per-issue workspace — created by `/workspace`. The hub itself stays open as the home base.

### What `/workspace` spawns

`/workspace <ISSUE>` calls `cmux-spawn-work`, which creates a cmux workspace **cwd'd to**
`.claude/worktrees/<ISSUE>/` (the isolated mini-workspace), split into **two panes** — **Claude Code** on the
left and a **terminal** on the right — and tagged with a **distinct color** (the `/workspace` command
picks one not already in use; `cmux-spawn-work` defaults to Blue). It is **idempotent** (re-running
with the same `--name` returns the existing workspace) and **never steals focus** (`--focus false`).

```bash
cmux-spawn-work --name "<ISSUE> · <title>" --cwd "$PWD/.claude/worktrees/<ISSUE>"
# → workspace=workspace:21 status=created name="<ISSUE> · <title>"
```

Workspace naming: `<ISSUE-ID> · <title>`. Output is one `key=value` line; capture `workspace=` if you
need the ref.

### Rules for agents

- **`/workspace` proposes, never auto-spawns.** It confirms repo scope before creating worktrees or
  the cmux workspace. Skip the spawn if you're already inside the right workspace.
- **Inside a workspace, submodule paths are `modules/<repo>/…`** — exactly as at the hub root.
- **Never steal focus.** `cmux-spawn-work` passes `--focus false`; don't call `select-workspace`,
  `focus-pane`, or `focus-panel` after spawning.
- **Never auto-close.** Closing is always the user's decision. `/teardown` removes the *worktrees*
  but leaves the cmux workspace open for the user to close
  (`cmux close-workspace --workspace <ref>`).

Each hub's `.cmux/cmux.json` defines its own static Command-Palette templates (the hub home base, and
any surface like a mockup previewer). After editing it, run `cmux reload-config`.

## Mermaid Diagrams

The house style for Mermaid diagrams (flowcharts with subgraphs, never sequence diagrams; the
required semantic palette; rich node content) lives in the **`mermaid-style`** skill — global, from
`dotfiles/claude/skills/`.
