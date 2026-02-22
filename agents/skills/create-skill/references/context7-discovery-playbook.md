# Context7 Discovery Playbook

Run this process for every new skill request.

## Goal
Find practical CLI/library options, then use `askUserQuestion` to confirm what to adopt.

## Procedure
1. Extract tooling needs from interview answers (language, runtime, task type, constraints).
2. Resolve candidate libraries with Context7 (`resolve-library-id`) before querying docs.
3. Query docs with resolved library IDs (`query-docs`) for each top candidate.
4. Create a shortlist of 2-4 options with concise tradeoffs.
5. Ask user choice questions:
   - Include external dependency or not
   - If yes, which candidate to adopt
6. Record final decision and reflect it in `SKILL.md` and references.

## Deterministic execution rules
- Never query docs without resolving a library ID first.
- Keep Context7 calls bounded and focused.
- Use a consistent candidate card format for every option.
- Always produce an explicit user choice step before drafting.

## Candidate card format
- Name and ecosystem
- Primary use case fit
- Key advantages
- Key risks or limitations
- Operational footprint (install/runtime complexity)

## Decision rules
- If one option clearly dominates, still ask for user confirmation.
- If user has an existing stack standard, prioritize that unless blocked.
- If all options are rejected, proceed with no external dependency.
