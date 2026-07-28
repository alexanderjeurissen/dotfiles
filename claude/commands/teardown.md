---
description: >-
  Dismantle a per-issue workspace: remove the nested submodule worktrees and the workspace's top-level worktree,
  prune, and drop the manifest row (committing it). Auto-targets the workspace it's run from. Checks
  for unpushed/uncommitted work (and a running dev stack) and confirms before destroying. The single
  confirmation also decides whether to close the cmux workspace (default: close; the user can keep it
  open). Does not delete feature branches.
argument-hint: "[ISSUE-ID] (optional — omit to target the current workspace or pick from a list)"
allowed-tools: Bash Read AskUserQuestion
disable-model-invocation: true
---
Tear down a per-issue workspace (requested target: **$ARGUMENTS**).

This is the `/teardown` command. It removes the worktrees and updates the reconstruction manifest.
Whether the cmux workspace is also closed is **decided as part of the single Step-2 confirmation**
(default: close it; the user can choose to keep it open) — so consent is captured at the moment of
decision, not deferred to a second prompt that gets dropped. It is intentionally **not** wired to
"is the work done?" — you run it when you're done with the workspace; the code lives on as commits on
the (pushed) feature branches.

> **No `cd`, ever.** The engine (`workspace`, on PATH) self-anchors to the hub from anywhere — it
> climbs out of any submodule before resolving, so the old `.git/modules` trap is gone. Run it
> directly, and use `git -C "$HUB"` (with `HUB="$(workspace hub)"` from step 0) for the one hub-repo
> commit. Never change directory.

## Step 0 — Resolve the target + hub (no `cd`)

The ISSUE-ID argument is **optional**. Resolve the target in this order, then carry the resolved
**ISSUE-ID**, **cmux workspace ref**, and **`$HUB`** through the rest of the command:

1. **Explicit arg.** If `$ARGUMENTS` is non-empty, use it as the ISSUE-ID.

2. **Auto-detect the caller workspace.** Identify the cmux workspace this session is running in and
   read its working directory. If that dir is inside `workspaces/<ISSUE>/`, that's the target (the
   common case: "tear down the workspace I'm in"). This call also yields the cmux ref we need to
   close later — run it **regardless** of how ISSUE was resolved:
   ```bash
   CALLER=$(cmux identify --json | python3 -c "import sys,json; print(json.load(sys.stdin)['caller']['workspace_ref'])")
   cmux list-workspaces --json | python3 -c "
   import sys, json, re
   caller = '$CALLER'
   for w in json.load(sys.stdin)['workspaces']:
       if w['ref'] == caller:
           d = w.get('current_directory') or ''
           m = re.search(r'/workspaces/([^/]+)', d)
           print(f\"{w['ref']}\t{m.group(1) if m else ''}\t{d}\")
   "
   ```
   The three tab-separated fields are: cmux ref to close, ISSUE (empty if at the hub root), and the
   caller's working directory. If ISSUE is empty (you're at the hub root), fall through to (3) to pick a
   target.

3. **Pick from a list.** Run `cmux list-workspaces` (plain text shows the
   `workspace:<N>  <ISSUE-ID> · <title>` names). Filter out non-issue rows (`Root`, etc.) and
   present the issue workspaces via `AskUserQuestion`. From the chosen row capture both the
   `workspace:<N>` ref and the ISSUE-ID (token before ` · `).

> **Now resolve the hub** for the manifest commit. The engine self-anchors from anywhere, so
> there's no path to juggle — ask it:
> ```bash
> HUB="$(workspace hub)"   # authoritative hub path, from the hub or any workspace
> echo "HUB=$HUB"
> ```

## Step 1 — Safety check (engine dry-run) + dev stack
Ask the engine to report uncommitted/unpushed work — it iterates the submodule worktrees itself, so
no shell glob and no cwd dependency. If the workflow uses per-issue dev stacks, also detect a
leftover one:
```bash
workspace teardown --issue <ISSUE-ID> --check
echo "--- dev stack ---"
docker compose ls --format json 2>/dev/null \
  | python3 -c "import sys,json; [print(p['Name']) for p in json.load(sys.stdin)]" 2>/dev/null \
  | grep -i "^$(echo '<ISSUE-ID>' | tr 'A-Z' 'a-z')-" || echo "(no <issue>-* compose project running)"
```
The check's final line is `check=clean issue=<ISSUE-ID>` or `check=dirty issue=<ISSUE-ID>`. A running
`<issue>-*` compose project means the worktree's dev stack is still up and should be brought down in
step 3.

## Step 2 — Confirm the destructive action **and** the close decision (mandatory)
Teardown is destructive (the engine uses `--force`) and may close the workspace you're sitting in.
**Always** confirm via a single `AskUserQuestion` before proceeding — state plainly which ISSUE-ID
and which cmux workspace are in scope, and surface anything from step 1: uncommitted/unpushed work
(`check=dirty`) and any running dev stack. If there's unsaved work, recommend running
`/workspace-sync <ISSUE-ID>` first so it's pushed.

This one question **also** decides the fate of the cmux workspace — fold it into the same prompt so
there is no second, droppable offer later. Offer these options (default to the first):

- **Tear down + close the cmux workspace** *(recommended)* — removes the worktrees, drops the
  manifest row, and closes `workspace:<N>`.
- **Tear down, keep the workspace open** — removes the worktrees but leaves `workspace:<N>` open.
- **Cancel** — do nothing.

Carry the chosen **close / keep-open** decision into step 5. Only proceed (steps 3–5) on explicit
confirmation; on Cancel, stop here.

## Step 3 — Bring down the dev stack (if any), then run the engine
If step 1 found a running compose project for this issue, bring it down first (keeps cloned volumes;
add `--volumes` only if the user wants the data gone):
```bash
COMPOSE_PROJECT_NAME=<issue>-<svc> docker compose -f <issue-worktree>/modules/<repo>/docker-compose.yml down
```
Then run the teardown engine (cwd-independent — `workspace` self-anchors):
```bash
workspace teardown --issue <ISSUE-ID>
```
Removes each submodule worktree, then the workspace's top-level worktree, prunes, and drops the manifest row. It
deliberately **leaves** the per-issue memory symlink + history under `~/.claude` untouched (harmless;
points at persistent canonical memory).

## Step 4 — Commit the manifest (hub repo, via `git -C`)
No `cd` — operate on the hub the engine reported:
```bash
git -C "$HUB" add workspaces/WORKSPACES.md
git -C "$HUB" commit -m "workspace: close <ISSUE-ID>"
```
Standing housekeeping — no need to ask.

## Step 5 — Report, then execute the close decision from step 2
Report the outcome as text. The worktrees are gone and the manifest is committed.

Now act on the **close / keep-open** decision the user already made in step 2 — do **not** re-prompt:

- **Keep open:** say so and stop; the cmux workspace stays as-is.
- **Close:** run the close as a **synchronous** call (do **not** background it; the Bash tool reaps
  lingering children, so a backgrounded close is killed before its RPC fires). Use the resolved
  **literal** `workspace:<N>` ref from step 0 — shell variables don't persist across Bash calls:

```bash
cmux close-workspace --workspace workspace:<N>
```

Note that closing the **caller** workspace (the one you're sitting in) ends this Claude session; the
synchronous call delivers the RPC before the CLI returns and your report text already rendered, so
don't expect to print anything after it. Closing a **non-caller** (picked from the hub) leaves the
session alive — verify with `cmux list-workspaces` if you like.

Also note that the **feature branch(es) are intentionally kept** (the work may be unmerged) — offer
to delete local branches only if the user confirms they're merged.

## Guardrails
- **No `cd` — call `workspace` (on PATH) directly and use `git -C "$HUB"`** — see step 0. The engine
  self-anchors to the hub from anywhere (climbing out of any submodule), so the old `.git/modules`
  anchoring trap is gone.
- **Never destroy unsaved work silently** — the step-2 confirmation is mandatory, every time.
- **Don't delete feature branches** unless the user confirms they're merged.
- **Never close the cmux workspace without consent** — the choice is captured in the step-2
  confirmation (default: close; keep-open is an explicit option), and step 5 just executes it. There
  is no separate end-of-run offer. When the decision is *close*, close **synchronously, never
  backgrounded**. All durable state (worktree removal, manifest commit) already landed in steps 3–4,
  so an unclosed workspace is harmless — recover/close it from any session with
  `cmux close-workspace --workspace workspace:<N>`.
