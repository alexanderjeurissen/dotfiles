# Interview Question Bank

Use this bank to run a mandatory intake before drafting any new skill.

## Interview rules
- Start with core questions, then ask as many follow-ups as needed.
- Use structured options for most questions.
- Ask follow-ups when required fields are missing or contradictory.
- Do not draft files until required answers are complete.

## Core mandatory questions

1. What is the one-sentence mission of this skill?
2. Which outcomes must the skill reliably produce?
3. What is explicitly out of scope?
4. What user phrases should trigger this skill?
5. What similar requests should not trigger this skill?
6. Should invocation be automatic, manual, or both?
7. What risk level does this workflow have (low, medium, high)?
8. Does the skill perform side effects (write, deploy, network, payments)?
9. Which tools are required, optional, and disallowed?
10. Which CLIs or libraries are already preferred or mandated?
11. Should Context7 proposals include only CLIs, only libraries, or both?
12. After reviewing Context7 candidates, which option should be adopted?
13. If none of the candidates are acceptable, should we proceed with no external dependency?
14. Should this be instructions-only, script-assisted, or script-first?
15. If scripts are needed, which steps must be deterministic?
16. What output format is required (template, sections, schema)?
17. Which edge cases must be handled explicitly?
18. What references are needed beyond `SKILL.md`?
19. What explicit trigger prompts should pass?
20. What implicit trigger prompts should pass?
21. What negative controls should not trigger?
22. What acceptance checks must be true before considering the skill complete?

## Conditional follow-up questions
- Which candidate should be the default recommendation and why?
- Are there team standards or policies that override top-ranked tooling?
- What install/runtime assumptions are acceptable in target environments?
- Which failure modes must be handled explicitly in scripts?
- Which outputs must be schema-checked or validator-checked before completion?
- Which terms or concepts need explicit definitions to avoid ambiguity?
- Are any requirements time-sensitive or version-sensitive and how should they be labeled?
- What evidence indicates the skill is production-ready versus experimental?

## Completion gate
Required answers must cover:
- Mission and boundaries
- Trigger behavior
- Safety and tool constraints
- Tooling discovery and final tool choice
- Determinism and script policy
- Output requirements
- Evaluation prompts
