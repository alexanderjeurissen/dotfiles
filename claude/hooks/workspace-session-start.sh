#!/usr/bin/env bash
# SessionStart hook — readiness for per-issue worktrees.
#
# If this session opened inside a hub worktree (…/.claude/worktrees/<name>, or the legacy
# workspaces/<name>), share the hub's canonical memory into this worktree's Claude project and
# tell Claude that submodule worktrees populate on demand. No-op everywhere else — the hub root,
# non-hub projects, or when the `workspace` engine isn't on PATH.
#
# Network-free (no git fetch) and non-blocking: always exits 0, and stays silent unless we're
# actually inside a worktree, so it's safe to run on every session start. Plain stdout is added
# to the session context by Claude Code.

command -v workspace >/dev/null 2>&1 || exit 0

# `workspace prepare` sets up the shared-memory symlink (if in a worktree) and prints the
# worktree name; it prints nothing and returns 0 when not in a worktree.
name="$(workspace prepare 2>/dev/null)" || exit 0
[ -n "$name" ] || exit 0

printf 'Session context: you are in the per-issue worktree "%s" — a git worktree of the hub, with hub memory shared. Submodule worktrees under modules/ are populated on demand: if you need modules/<repo> and its directory is empty, run `workspace fill <repo>` before using it.\n' "$name"
exit 0
