---
description: >-
  Instantiate a fully-isolated, per-issue workspace: a worktree of the hub repo with
  nested worktrees of the in-scope submodules on the issue's feature branch, shared memory, a
  tracked manifest row, and a cmux workspace cwd'd into it. Claude suggests the repo scope; you
  confirm. Targets a tracker issue or a PR/MR.
argument-hint: "<ISSUE-ID> (e.g. ABC-597) or a PR/MR (e.g. !37575 / #42 / MR-37575 / PR-42)"
allowed-tools: Bash Read AskUserQuestion mcp__linear
disable-model-invocation: true
---
Create an isolated per-issue workspace for: **$ARGUMENTS**

This is the `/workspace` command of the workspace workflow (see the workspace guide →
"Per-issue workspaces"). The engine is `workspace`; this command orchestrates the
tracker, scope confirmation, the hub-repo commit, and the cmux spawn.

> **No `cd`, ever.** The engine (`workspace`, on PATH) self-anchors to the hub from anywhere — it
> climbs out of any submodule before resolving. Resolve the hub once for the manifest commit and the
> spawn cwd, and use `git -C "$HUB"`:
> ```bash
> HUB="$(workspace hub)"; echo "HUB=$HUB"
> ```

## Steps

### 1. Resolve the target → the workspace identifier

A workspace targets **either a tracker issue or a PR/MR**. The chosen identifier is load-bearing:
it becomes the worktree dir (`worktrees/<ID>/`), the manifest row, **and** the cmux workspace name —
so it must be canonical and consistent. Pick the path by what `$ARGUMENTS` names:

**A. Tracker issue** (`ABC-597`, …)
- Run `get_issue $ARGUMENTS` (Linear). Capture: `title`, `gitBranchName`, `url`, `priority`, and
  the **description** (esp. any "Touch-points" / file paths).
- The identifier is the issue key verbatim (`ABC-597`). `gitBranchName` is the canonical branch —
  **use it verbatim** as `--branch`.
- If the issue isn't found or the user passed a bare description, you may proceed ad-hoc: synthesize
  a branch `feature/<lowercased-key-or-slug>` and a title. Confirm the branch name.

**B. PR/MR** (`!37575`, `MR-37575`, `#42`, `PR-42`, a PR/MR URL, or "review the PR/MR for branch X")
- **The identifier is always `PR-<N>` / `MR-<IID>`** — the forge's PR/MR number, never the branch
  slug or an embedded tracker key. (This rule prevents drift: a branch like `srp/abc-73-flow` must
  still produce `MR-37575`, not `ABC-73`.)
- Resolve the PR/MR from the appropriate submodule (its remote determines forge/project), using
  that submodule's forge CLI — `gh` for GitHub, `glab` for GitLab. Given a number directly, or
  derive it from a branch, e.g.:
  ```bash
  # GitHub: branch → number
  gh pr list --head "<branch>" --json number,title,headRefName
  # GitLab: branch → IID
  glab mr list --source-branch "<branch>"
  ```
- `--branch` is the PR/MR's source branch (use it verbatim). The **title** is the PR/MR title (trim
  noise; drop a trailing `(!<IID> review)` / `(#<N> review)` — the `MR-`/`PR-` prefix carries it).

### 2. Suggest the repo scope (Claude suggests → user decides)
Infer which submodules are in scope from the issue/PR description + this conversation, then
**always** confirm with an interactive checklist (the user is the decider). The candidate set is
this workspace's submodules — list them with `workspace list` (or read `.gitmodules`); don't
hardcode names. Map evidence → submodule using each repo's role (paths, languages, and naming in
the description), and present the inferred set **pre-selected** via `AskUserQuestion` (multiSelect)
with your reasoning in the question text. Default when nothing is clearly indicated: the primary
application submodule.

### 3. Surface integration-branch warnings
For each chosen repo, the engine resolves the integration base from that submodule's branch **in the
top-level checkout**. Run `workspace integration-branch <repo>` (or just let `create` print
warnings) and **relay any warning** — e.g. "<repo> is on a feature branch, not its default". A
warning usually means the one-time migration hasn't run yet, or feature work leaked into the main
checkout; ask whether to proceed before creating.

### 4. Create the workspace
The engine's `--issue` flag is just the **workspace identifier** resolved in step 1 — pass the
tracker key (`ABC-597`) or the `PR-<N>`/`MR-<IID>`, whichever applies:
```bash
workspace create \
  --issue <ID> \
  --branch <gitBranchName | PR/MR source branch> \
  --repos <comma,separated,confirmed,repos> \
  --title "<issue or PR/MR title>"
```
Capture `workspace_dir=` from the final stdout line. Idempotent — safe to re-run; it also
**restores** branches that already exist on the remote (the rebuild path).

### 5. Commit the manifest (hub repo)
The engine wrote `worktrees/WORKSPACES.md` but did not commit:
```bash
git -C "$HUB" add worktrees/WORKSPACES.md
git -C "$HUB" commit -m "workspace: open <ID> (<repos>)"
```
This is standing housekeeping (like a pin) — no need to ask first.

### 6. Spawn the cmux workspace (cwd'd into the worktree; claude + terminal splits)
First pick a **distinct color** — one not already used by another workspace, so the sidebar stays
legible — then spawn, using the absolute `workspace_dir` from step 4:
```bash
palette=("#1565C0" "#2E7D32" "#C62828" "#6A1B9A" "#EF6C00" "#00838F" "#AD1457" "#283593" "#9E9D24" "#00695C" "#455A64" "#5D4037")
used="$(cmux --json list-workspaces | jq -r '.workspaces[].custom_color // empty')"
color="${palette[0]}"   # fallback if all are taken
for c in "${palette[@]}"; do
  if ! grep -qiF "$c" <<<"$used"; then color="$c"; break; fi
done

cmux-spawn-work \
  --name "<ID> · <title>" \
  --cwd "<workspace_dir>" \
  --color "$color"
```
The cmux name uses the **same identifier** as the worktree dir and manifest — they never diverge.
This creates a cmux workspace cwd'd to the worktree with two splits — **Claude Code (left)** and a
**terminal (right)**, tagged with the chosen distinct color — so the instance sees a fully isolated
mini-workspace (shared memory, isolated history). Idempotent (re-running returns the existing
workspace) and never steals focus. (`cmux-spawn-work` defaults to Blue if `--color` is omitted.)

### 7. Report
Summarize: workspace dir, the feature branch, which submodules are checked out, and the cmux
workspace ref. Mention that `/workspace-sync <ID>` keeps it current and `/teardown <ID>` dismantles it.

## Guardrails
- **PR/MR targets are always `PR-<N>` / `MR-<IID>`** — derive the identifier from the forge number,
  never from the branch slug or an embedded tracker key. Worktree dir, manifest row, and cmux name
  all use this one identifier; they must never diverge.
- **Confirm scope** — never skip the checklist; the user decides repos.
- **Relay divergence warnings** — don't silently base a feature branch off stale feature work.
- **Don't push anything** — `/workspace` only creates locally. Pushing is `/workspace-sync`.
- **Idempotent** — re-running for an existing issue reuses/restores; it won't clobber work.
