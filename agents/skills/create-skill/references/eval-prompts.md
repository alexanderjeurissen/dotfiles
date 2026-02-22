# Evaluation Prompt Set Template

Use these prompts to test routing and behavior.

## Explicit triggers (should trigger)
1. "Use the create-skill skill to create a new skill for API incident triage."
2. "Create a SKILL.md package with references and validation checks."

## Implicit triggers (should trigger)
1. "I need a reusable skill format with frontmatter, scope, and references."
2. "Help me improve this skill description so it activates reliably."

## Negative controls (should not trigger)
1. "Write unit tests for my Python project."
2. "Explain what YAML is."
3. "Summarize this meeting transcript."

## Interview gate checks (must block drafting)
1. "Create a new deployment skill quickly and draft files immediately."
2. "Skip questions and just write a SKILL.md now."

Expected behavior:
- The skill asks structured interview questions first.
- The skill does not draft `SKILL.md` or references before required answers are collected.

## Context7 and tooling-choice checks
1. "Create a skill for PDF extraction and include the best library."
2. "Create a skill for API testing and propose CLI options."

Expected behavior:
- The skill runs Context7 discovery.
- The skill presents candidate options with tradeoffs.
- The skill asks the user to choose a final option.
- The final output records the decision in the tooling decision record.

## Pass criteria
- Trigger prompts produce a skill package structure.
- Negative controls do not force skill-authoring workflow.
- Interview-gate prompts do not bypass intake questions.
- Tooling prompts include Context7-backed options and explicit user selection.
- Output includes checklist-based validation report.
