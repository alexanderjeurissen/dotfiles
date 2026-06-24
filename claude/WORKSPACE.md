# Workspace workflow (shared)

This is the host-neutral core of the per-issue worktree workflow, shared across every workspace
that uses it. Each workspace's own `CLAUDE.md`/`AGENTS.md` imports this file and then adds its
repo-specific bits (the actual submodules + remotes, integration branches, tracker/forge
conventions, planning artifacts). Nothing here names a specific repository or organization — the
engine discovers all of that at runtime.

Throughout: **workspace** = the top-level checkout (the stable integration view); **issue** = the
work identifier a per-issue worktree is keyed on (a tracker issue, a PR/MR, or an ad-hoc slug);
**PR/MR** = the merge request on whichever forge a submodule lives (GitHub PR, GitLab MR).

## Repository structure conventions

A workspace is a git repo holding **planning artifacts** alongside **git submodules** for the
code/content repos. All submodules live under `modules/` and are configured with `update=none` —
treat each as an independent git repo:

- To make changes: `cd modules/<repo>/ && git checkout <branch> && … && git commit && git push`.
- Each submodule has its own remote, branches, and history.
- **Before implementing changes**, ensure the target repo is on a feature branch (create one if needed).
- NEVER run `git submodule update` — it is a no-op by design (`update=none`).
- Git operations (add, commit, push, checkout) inside a submodule are scoped to that submodule's repo.

The workspace repo also tracks planning artifacts (e.g. `mockups/`, `docs/`) — commit those from
the workspace root.

### Pinning submodule state (auto-pin)

**Always auto-pin immediately after a commit lands in a submodule** in the *main checkout*. As soon
as you commit (or rebase/reset to a new SHA) in a main-checkout submodule, pin its new SHA in the
workspace repo:

```sh
git -C "$(workspace root)" add modules/<repo>   # stages the submodule's current SHA as a gitlink
git -C "$(workspace root)" commit -m "pin <repo> after <description>"
```

Submodule commit → workspace-repo pin, every time. Stage only the gitlink(s) you changed so the
pin commit stays focused. **In the worktree-focused workflow, pinning is consolidated into
`/update-modules`** (the single pinning path): feature commits land in per-issue *worktrees* and do
**not** pin, while the top-level checkout is fast-forwarded to integration-branch tips and pinned
there. The rule above still governs any *direct* commit you make in a main-checkout submodule, but
in normal flow feature work never touches the main checkout, so that's rare.

## Per-issue worktree workspaces

Parallel work on multiple issues happens in **isolated per-issue worktrees**, not by switching
branches in the shared submodule checkouts. Each issue gets a "mini-workspace": a git worktree of
*this workspace repo* at `worktrees/<ISSUE>/` (carrying `CLAUDE.md`/`AGENTS.md`, `.claude/`,
`.cmux/`, `docs/`, …), with a git worktree of each in-scope submodule nested inside it under
`modules/<repo>` on the issue's feature branch (mirroring the main checkout's `modules/` layout).
Submodule object stores are shared (no re-clone), and a cmux workspace cwd's into it — so the
Claude instance sees a complete, isolated environment.

```
<workspace>/                    PRIMARY — stable integration view
├─ modules/                     submodules on their integration branches
│  └─ repo-a/  repo-b/  …
└─ worktrees/
   ├─ WORKSPACES.md             tracked reconstruction manifest (the checkouts are gitignored)
   └─ <ISSUE>/                  a per-issue mini-workspace (worktree of the workspace repo)
      ├─ CLAUDE.md .claude/ …    came free with the workspace worktree
      └─ modules/
         └─ repo-a/             worktree of repo-a on the feature branch (shared object store)
```

### The integration-branch invariant (load-bearing)

In the top-level checkout, **each submodule sits on its integration branch** (e.g. `main`, or
`develop`/`master` where a repo uses those). That checkout *is* the per-repo source of truth: every
command reads "what branch is this submodule on in the workspace?" to decide the integration base.
Nothing is hardcoded. **Feature work never lives in the main checkout — only in worktrees.**
`workspace integration-branch <repo>` resolves it and warns when a checkout diverges from its
`origin/HEAD` default (usually a sign of leaked feature work that wants migrating into a worktree).

### The four commands

| Command | What it does |
|---|---|
| `/workspace <ISSUE>` | Create the mini-workspace: workspace worktree + submodule worktrees on the feature branch, share memory, record the manifest, spawn a cmux workspace (Claude Code + terminal splits) cwd'd into it. Claude *suggests* repo scope; the user confirms. |
| `/workspace-sync [ISSUE]` | **Merge** each submodule's integration branch into the feature branch (never rebase) + push. Auto-resolves mechanical conflicts, asks when ambiguous; auto-targets the workspace it's run from. No force-push. |
| `/update-modules` | Fast-forward the main checkout's submodules to their integration tips + **pin**. The only pinning path. Run after upstream PRs/MRs merge. |
| `/teardown <ISSUE>` | Remove the worktrees + drop the manifest row (after a safety check for unsaved work). Keeps feature branches and the cmux workspace. |

The engine `workspace` (on PATH, from `dotfiles/scripts/` via `~/.scripts`; shared across
workspaces and discovering this one's submodules + integration branches from `.gitmodules` and the
main checkout) does the deterministic git/fs plumbing only — it never commits the workspace repo,
talks to a tracker, or touches cmux. The slash commands orchestrate the tracker, scope
confirmation, the workspace-repo commits (manifest rows, pins), and cmux spawning. The commands are
global (`~/.claude/commands/`, symlinked from `dotfiles/claude/commands/`), so every workspace
shares one copy.

### The manifest — `worktrees/WORKSPACES.md`

Tracked, while the per-issue checkouts are gitignored (`worktrees/*/`). One row per active workspace
(issue, title, repos, branch, opened). It's a **reconstruction recipe**: on a fresh clone, each row
is enough to rebuild the worktree from the pushed feature branches — which is exactly why
`/workspace-sync`'s push matters. `/workspace` and `/teardown` maintain it; the row is committed as
standing housekeeping.

### Memory & history

Because a per-issue workspace cwd's to `worktrees/<ISSUE>/`, Claude keys it as a separate project
(separate memory + history). `/workspace` symlinks that project's `memory/` → the canonical
workspace memory, so **facts are shared** while **history stays isolated** per issue.

## cmux Workflow

cmux is the visual map of in-flight work. Each active issue gets **one cmux workspace** — the
per-issue worktree — created by `/workspace`. The workspace root stays open as the hub.

### What `/workspace` spawns

`/workspace <ISSUE>` calls `cmux-spawn-work`, which creates a workspace **cwd'd to**
`worktrees/<ISSUE>/` (the isolated mini-workspace), split into **two panes** — **Claude Code** on
the left and a **terminal** on the right — and tagged with a **distinct color** (the `/workspace`
command picks one not already in use; `cmux-spawn-work` defaults to Blue). It is **idempotent**
(re-running with the same `--name` returns the existing workspace) and **never steals focus**
(`--focus false`).

```bash
cmux-spawn-work --name "<ISSUE> · <title>" --cwd "$PWD/worktrees/<ISSUE>"
# → workspace=workspace:21 status=created name="<ISSUE> · <title>"
```

Workspace naming: `<ISSUE-ID> · <title>`. Output is one `key=value` line; capture `workspace=` if
you need the ref.

### Rules for agents

- **`/workspace` proposes, never auto-spawns.** It confirms repo scope before creating worktrees or
  the cmux workspace. Skip the spawn if you're already inside the right workspace.
- **Inside a workspace, submodule paths are `modules/<repo>/…`** — exactly as at the workspace root.
- **Never steal focus.** `cmux-spawn-work` passes `--focus false`; don't call `select-workspace`,
  `focus-pane`, or `focus-panel` after spawning.
- **Never auto-close.** Closing is always the user's decision. `/teardown` removes the *worktrees*
  but leaves the cmux workspace open for the user to close
  (`cmux close-workspace --workspace <ref>`).

Each workspace's `.cmux/cmux.json` defines its own static Command-Palette templates (the home hub,
and any surface like a mockup previewer). After editing it, run `cmux reload-config`.

## Mermaid Diagrams

When generating Mermaid diagrams, follow these rules:

### Structure

- **Use flowcharts with subgraphs** — prefer `graph TD` / `graph LR` with `subgraph` blocks to
  organize related nodes. This is the default diagram type for all visualizations.
- **Never use sequence diagrams** — model actor/service interactions as a flowchart with subgraphs
  representing each actor/service and edges representing the interactions.
- **Subgraph naming** — use quoted descriptive labels: `subgraph Core["Main Service"]`. The ID is a
  short key; the quoted string is the human-readable title.
- **Internal direction** — set `direction TB` or `direction LR` inside each subgraph.
- **Direction** — `TD` (top-down) for hierarchical flows, `LR` (left-right) for pipelines/timelines.

### Styling (required)

Every diagram must include explicit styling. Every subgraph must have a `style` declaration with
`fill`, `stroke`, `stroke-width`, and `color`. Use this semantic palette:

  | Role / meaning        | fill      | stroke    |
  |-----------------------|-----------|-----------|
  | Primary / core system | `#f0f4ff` | `#0969da` |
  | Success / result      | `#f0fff4` | `#1a7f37` |
  | Secondary / agent     | `#f0f4ff` | `#8250df` |
  | Warning / gateway     | `#fff8f0` | `#bc4c00` |
  | Error / deny          | `#ffcdd2` | `#c62828` |

Always set `color:#1f2328` for readable text, and `stroke-width:2px` for primary subgraphs (1px for
secondary/supporting ones). Nodes representing error states or decision outcomes should get
individual `style` declarations (e.g., `style Deny fill:#ffcdd2,stroke:#c62828,stroke-width:2px`).

### Rich node content

- **HTML line breaks** — use `<br/>` inside node labels for multi-line content.
- **Italic annotations** — use `<i>...</i>` for secondary details within node labels.
- **Edge labels** — describe the action or data being passed (e.g., `-->|"POST /login"|`).
- **Dashed edges** — use `-.->` for secondary/reference/async flows; solid (`-->`) for the happy path.
