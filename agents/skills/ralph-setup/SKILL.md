---
name: ralph-setup
description: Set up the Ralph Loop workflow files (PROMPT_plan.md, PROMPT_build.md, AGENTS.md, IMPLEMENTATION_PLAN.md) in the current project. Use when initializing a new project for autonomous Ralph-style development loops.
disable-model-invocation: true
---

# Ralph Loop Setup

Initialize the current project with the Ralph Loop workflow files. Templates are in this skill's `templates/` directory.

## Setup Steps

1. **Determine the project root.** Run `git rev-parse --show-toplevel` to get the git root. Present it as the recommended default, but ask the user to confirm or specify a different path (e.g. a subfolder like `agents/graphql_agent`). The confirmed project root determines:
   - **File placement**: all generated files (PROMPT_plan.md, PROMPT_build.md, AGENTS.md, IMPLEMENTATION_PLAN.md) are written into this directory.
   - **Path construction**: the project root relative to git root is used as the prefix when building the directory placeholders below. If the project root IS the git root, use no prefix.

2. **Derive the project goal** by reading the files in the project root's `specs/` directory and synthesizing a concise ULTIMATE GOAL statement from them.

3. **Detect tooling defaults.** Before asking the user, look in the project for `pyproject.toml`, `Makefile`, `justfile`, `.pre-commit-config.yaml`, `mise.toml`, and CI config to infer actual build/test/typecheck/lint commands. Use discovered commands as defaults in the questions below.

4. **Ask the user** for project-specific details using AskUserQuestion:
   - The **source code directory** (default: `src`) — relative to the project root.
   - The **shared utilities directory** (default: `src/lib`) — relative to the project root.
   - **Build/sync command** (default: `uv sync`)
   - **Test command** (default: `pytest`)
   - **Typecheck command** (default: `uv run --with pyright pyright .`, or "none")
   - **Lint command** (default: `ruff check --fix && ruff format`, or "none")
   - Present the derived project goal for confirmation and let the user adjust if needed.

5. **Build full paths** from the user's answers. Combine the project root (relative to git root) with each directory to produce paths relative to git root. Examples:
   - Project root `agents/graphql_agent` + source `src` → `agents/graphql_agent/src`
   - Project root `.` (git root) + source `src` → `src`
   - Specs are always at `[project_root]/specs` — no separate configuration needed

6. **Read templates** from this skill's templates directory:
   - `templates/PROMPT_plan.md`
   - `templates/PROMPT_build.md`
   - `templates/AGENTS.md`
   - `templates/IMPLEMENTATION_PLAN.md`

7. **Customize templates** by replacing placeholders:
   - `[project_root]` → project root path relative to git root (or `.` if they are the same)
   - `[source_code_dir]` → full source code path relative to git root
   - `[shared_utils_dir]` → full shared utilities path relative to git root
   - `[project-specific goal]` → the derived/confirmed goal
   - `[build command]`, `[test command]`, `[typecheck command]`, `[lint command]` → actual commands in AGENTS.md
   - Remove validation entries from AGENTS.md if the user said "none" for a command

8. **Write files** to the project root directory:
   - Always write: `PROMPT_plan.md`, `PROMPT_build.md`
   - **AGENTS.md handling**:
     - If `AGENTS.md` does **not** exist → write it from the customized template
     - If `AGENTS.md` exists → check whether it contains the expected headings (`## Build & Run`, `## Validation`, `## Operational Notes`, `## Codebase Patterns`). If any are missing, suggest edits to add the missing sections from the template. Do NOT overwrite the existing file without user consent.
   - Only write `IMPLEMENTATION_PLAN.md` if it does **not** already exist (it will be generated/managed by Ralph during the planning phase)

9. **Summarize** what was created and provide next steps:
   - Suggest running `/ralph-loop` with the planning prompt first: `/ralph-loop @<path>/PROMPT_plan.md --max-iterations 5`
   - Then building: `/ralph-loop @<path>/PROMPT_build.md" --max-iterations 20`
   - Use the actual project root path in the suggested commands
