---
description: >-
  Instantiate a fully-isolated worktree: a worktree of the hub repo with nested worktrees of the
  in-scope submodules, shared memory, and a cmux workspace cwd'd into it. Claude suggests the repo
  scope; you confirm. Spawn mechanics only — no tracker, no manifest.
argument-hint: "<name> (a slug or issue id, e.g. ENP-597 or auth-spike)"
allowed-tools: Bash Read AskUserQuestion
disable-model-invocation: true
---
Create an isolated worktree for: **$ARGUMENTS**

This is the `/workspace` command. The engine is `workspace`; this command confirms the repo scope
and spawns the cmux workspace. It does **not** talk to a tracker or commit the hub repo.

> **No `cd`, ever.** The engine (`workspace`, on PATH) self-anchors to the hub from anywhere.
> Resolve it once for the spawn cwd:
> ```bash
> HUB="$(workspace hub)"; echo "HUB=$HUB"
> ```

## Steps

### 1. Pick the worktree name
Use `$ARGUMENTS` verbatim as the worktree **name** — it becomes the worktree dir, the default
branch, and the cmux workspace title. It's just a label (a slug or an issue id); no tracker lookup.
Multiple worktrees for the same issue are fine — each is independent. If `$ARGUMENTS` is empty, ask
for a name.

### 2. Suggest the repo scope (Claude suggests → user decides)
Infer which submodules are in scope from this conversation, then **always** confirm with an
interactive checklist (the user decides). The candidate set is this hub's submodules — list them
with `workspace list` / `git worktree list`, or read `.gitmodules`; don't hardcode names. Present
the inferred set **pre-selected** via `AskUserQuestion` (multiSelect) with your reasoning in the
question text. Default when nothing is clearly indicated: the primary application submodule. **Keep
scope tight** — each submodule is a full working-tree checkout, so materialization cost scales with
the number you pick.

### 3. Bootstrap the worktree
```bash
workspace bootstrap --name <name> --repos <comma,separated,confirmed,repos> [--branch <branch>]
```
Adopts the worktree if the harness already made it (Claude Desktop / `claude --worktree`), else
creates it; then materializes a worktree of each in-scope submodule (branch defaults to `<name>`).
Capture `workspace_dir=` from the final stdout line. Idempotent — safe to re-run; it also
**restores** branches that already exist on the remote (the rebuild path).

### 4. Relay integration-branch warnings
`bootstrap` prints a warning if a submodule in the hub checkout is on a non-default branch (usually
a sign of leaked feature work). **Relay any such warning** before continuing.

### 5. Spawn the cmux workspace (cwd'd into the worktree; claude + terminal splits)
Pick a **distinct color** — one not already used by another workspace, so the sidebar stays
legible — then spawn, using the absolute `workspace_dir` from step 3:
```bash
palette=("#1565C0" "#2E7D32" "#C62828" "#6A1B9A" "#EF6C00" "#00838F" "#AD1457" "#283593" "#9E9D24" "#00695C" "#455A64" "#5D4037")
used="$(cmux --json list-workspaces | jq -r '.workspaces[].custom_color // empty')"
color="${palette[0]}"   # fallback if all are taken
for c in "${palette[@]}"; do
  if ! grep -qiF "$c" <<<"$used"; then color="$c"; break; fi
done

cmux-spawn-work \
  --name "<name>" \
  --cwd "<workspace_dir>" \
  --color "$color"
```
This creates a cmux workspace cwd'd to the worktree with two splits — **Claude Code (left)** and a
**terminal (right)**, tagged with the chosen color. Idempotent (re-running returns the existing
workspace) and never steals focus.

### 6. Report
Summarize: worktree dir, the branch, which submodules are checked out, and the cmux workspace ref.
Mention that `/workspace-sync` keeps it current and `workspace teardown --name <name>` (run from the
hub) dismantles it.

## Guardrails
- **Confirm scope** — never skip the checklist; keep it tight (each repo is a full checkout).
- **Relay divergence warnings** — don't silently base a feature branch off stale feature work.
- **Don't push anything** — `/workspace` only creates locally. Pushing is `/workspace-sync`.
- **Idempotent** — re-running reuses/restores; it won't clobber work.
- **Spawn mechanics only** — no tracker, no manifest, no hub-repo commit.
