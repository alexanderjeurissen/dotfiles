# Quality Patterns

Use these patterns to improve skill quality without increasing context bloat.

## Concision triage
Before adding any paragraph, ask:
- Does the agent need this to succeed?
- Is this knowledge already likely known?
- Does this text justify its token cost?

If not, remove it or move it to `references/`.

## Degree of freedom selector
- High freedom: Multiple approaches are valid and context determines best path.
- Medium freedom: Preferred pattern exists; limited variation is acceptable.
- Low freedom: Operation is fragile; deterministic script or strict sequence required.

## Instruction style
- Use imperative, objective language.
- Prefer direct commands over advisory phrasing.
- Keep terms stable (one concept, one label).

## Evaluation-first loop
1. Capture baseline behavior without the skill.
2. Add minimal instructions to close key gaps.
3. Re-test against explicit, implicit, and negative prompts.
4. Iterate until outcomes are stable.

## Feedback loop pattern
For quality-critical steps, embed:
- Validate output
- Fix issues
- Re-run validation
- Proceed only after pass

## Anti-pattern checks
- Monolithic entrypoint: oversized `SKILL.md` containing everything.
- Over-fragmented references: too many tiny files with no clear navigation.
- Option overload: too many equivalent alternatives without a default.

## Preferred balance
- `SKILL.md`: concise overview + workflow + decision points.
- `references/`: focused deep dives loaded on demand.
- Optional scripts for deterministic operations.
