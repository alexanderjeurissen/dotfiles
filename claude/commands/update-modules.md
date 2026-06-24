---
description: >-
  Fast-forward the top-level workspace checkout's submodule pointers to their integration branch
  tips, then pin the moved submodules in the workspace repo. The single, deliberate pinning path.
  Run after upstream PRs/MRs merge.
argument-hint: "[--repos repo-a,repo-b] (optional; defaults to all)"
allowed-tools: Bash Read
disable-model-invocation: true
---
Refresh the workspace's stable integration view: **$ARGUMENTS**

This is the `/update-modules` command. In the worktree-focused workflow, the top-level submodule
checkouts always sit on their integration branches and act as a clean, stable vantage point. This
command catches them up to upstream and pins them. It is the **only** place pinning happens —
per-issue worktrees never pin.

> **No `cd`, ever.** The engine (`workspace`, on PATH) self-anchors to the workspace root from
> anywhere — it climbs out of any submodule before resolving — so the fast-forward and pin always
> act on the top-level checkout, not a worktree. Resolve the root once for the pin commit:
> ```bash
> ROOT="$(workspace root)"; echo "ROOT=$ROOT"
> ```

## Steps

### 1. Run the engine
```bash
workspace update-modules $ARGUMENTS
```
For each submodule, the engine resolves its integration branch from the **current checkout**,
fetches, and `git merge --ff-only`. Output lines:
- `MOVED <repo>: <old> → <new> (<branch>)` — fast-forwarded.
- `OK <repo>: already current …` — nothing to do.
- `SKIP <repo>: … not a fast-forward …` — diverged or has local commits; relay and leave it.
- A trailing `PIN:<repo> <repo>…` line lists the submodules that moved.

### 2. Surface divergence warnings
The engine warns (stderr) when a submodule is on a branch other than its `origin/HEAD` default (e.g.
still on a feature branch in the main checkout). Relay these — they usually mean the **one-time
migration** hasn't run, or feature work leaked into the main checkout. Suggest the migration if so.

### 3. Pin the moved submodules (workspace repo)
For exactly the repos in the `PIN:` line, stage those gitlinks and commit — standing housekeeping,
no need to ask:
```bash
git -C "$ROOT" add modules/<moved-repo> [modules/<moved-repo> …]
git -C "$ROOT" commit -m "pin <repos> after fast-forward to <branch> tip(s)"
```
If nothing moved (`PIN:` absent), there's nothing to pin — say so.

### 4. Report
List what moved, what was already current, and anything skipped.

## Guardrails
- **Fast-forward only** — never merge-commit or reset the main checkout here. A `SKIP` means the
  user must reconcile manually (the main checkout shouldn't have local commits).
- **Pin only what moved** — keep the pin commit focused (per the auto-pin convention).
- **This is the only pinning path** — don't pin from inside per-issue worktrees.
