# Interview Playbook

Run this sequence for every new-skill request.

## Phase 1: Kickoff intake
1. Ask an initial batch of 8-10 structured questions.
2. Prefer option-based prompts with a custom-answer path.
3. Capture answers in a compact requirements summary.

## Phase 2: Context7 tooling discovery
1. Use Context7 to discover relevant CLIs and libraries for the requested workflow.
2. Build a shortlist of 2-4 candidates with concise pros and cons.
3. Ask the user to select one candidate when multiple options are viable.
4. If the user rejects all options, confirm a no-dependency approach.

## Phase 3: Gap and conflict resolution
1. Check for missing required categories.
2. Ask 4-8 targeted follow-up questions.
3. Resolve contradictory inputs before moving on.

## Phase 4: Confirmation
1. Present a concise recap of decisions.
2. Ask for confirmation of mission, scope, triggers, safety limits, and final tooling choice.
3. If confirmation changes requirements, loop back to follow-up questions.

## Phase 5: Drafting (only after gate passes)
1. Create `SKILL.md` with validated frontmatter and workflow.
2. Create `references/` and `scripts/` only when justified by interview answers.
3. Add evaluation prompts with explicit, implicit, and negative controls.

## Mandatory gate before drafting
- Core question set completed, plus follow-up questions until required fields are complete and conflicts are resolved.
- Most questions are structured (multi-select or single-select).
- Required fields complete and conflicts resolved.
- Context7 discovery completed and tool choice confirmed with the user.

## Fallback behavior
If `askUserQuestion` is unavailable, ask the same questions inline and keep the same blocking gate.
