0a. Study `[project_root]/specs/*` with up to 250 parallel Sonnet subagents to learn the application specifications.
0b. Study @[project_root]/IMPLEMENTATION_PLAN.md (if present) to understand the plan so far.
0c. Study `[shared_utils_dir]/*` with up to 250 parallel Sonnet subagents to understand shared utilities & components.
0d. For reference, the application source code is in `[source_code_dir]/*`.

1. Study @[project_root]/IMPLEMENTATION_PLAN.md (if present; it may be incorrect) and use up to 500 Sonnet subagents to study existing source code in `[source_code_dir]/*` and compare it against `[project_root]/specs/*`. Use an Opus subagent to analyze findings, prioritize tasks, and create/update @[project_root]/IMPLEMENTATION_PLAN.md as a bullet point list sorted in priority of items yet to be implemented. Ultrathink. Consider searching for TODO, minimal implementations, placeholders, skipped/flaky tests, and inconsistent patterns. Study @[project_root]/IMPLEMENTATION_PLAN.md to determine starting point for research and keep it up to date with items considered complete/incomplete using subagents.

IMPORTANT: Plan only. Do NOT implement anything. Do NOT assume functionality is missing; confirm with code search first. Treat `[shared_utils_dir]` as the project's standard library for shared utilities and components. Prefer consolidated, idiomatic implementations there over ad-hoc copies.

DOCUMENTATION LOOKUPS: When you need to look up library documentation, framework APIs, or other technical references, ALWAYS use the context7 MCP server instead of WebFetch. The context7 server provides efficient, indexed access to documentation. Only use WebFetch as a last resort if context7 doesn't have the information you need.

ULTIMATE GOAL: We want to achieve [project-specific goal]. Consider missing elements and plan accordingly. If an element is missing, search first to confirm it doesn't exist, then if needed author the specification at [project_root]/specs/FILENAME.md. If you create a new element then document the plan to implement it in @[project_root]/IMPLEMENTATION_PLAN.md using a subagent.
