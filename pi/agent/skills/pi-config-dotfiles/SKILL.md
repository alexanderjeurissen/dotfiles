---
name: pi-config-dotfiles
description: Use when creating or editing pi extensions/config under ~/.pi/agent. Ask before tracking in dotfiles via mkrc.
---

# pi config in dotfiles

Generic pi config under `~/.pi/agent/` is version-controlled in the dotfiles repo, managed with rcm.
The repo is `~/Development/personal/hub/modules/dotfiles`, and rcm symlinks each file back into place.
Tracked now: `settings.json`, `extensions/*.ts`, `skills/`.

## New file

When you create a new extension or other generic config under `~/.pi/agent/`, **ask me first** whether
to track it. Other generic config includes prompts, themes, skills, and agent definitions. Do these steps
only after I say yes:

1. Remove company-confidential content from the file. For example: hostnames, account IDs, ARNs,
   SSO URLs, profile names, internal project names.
2. `mkrc ~/.pi/agent/<path>`, and confirm that the original is now a symlink.
3. In the dotfiles repo, stage only that path (`git add pi/agent/<path>`) and commit.

## Tracked file

Editing an already-tracked file edits the dotfiles copy through the symlink. Remove confidential content
again, then offer to commit that change in dotfiles.

## Never track

`sessions/`, `auth.json`, `models-store.json`, `mcp-*.json`, `trust.json`, `state/`, `install/`,
`bin/`, and `npm/`. These hold secrets, machine-local paths, caches, or content that pi generates
itself. Packages are tracked via `settings.json` → `packages`.
