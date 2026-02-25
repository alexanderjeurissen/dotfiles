---
name: create-skill
description: Creates high-quality Agent Skills with spec-compliant SKILL.md frontmatter, progressive disclosure structure, and routing-aware descriptions. Use when creating a new skill or improving an existing skill's clarity, safety, and trigger reliability.
license: Apache-2.0
metadata:
  owner: platform-team
  version: "0.1.0"
  lang: "en"
---

# Create Skill

## Goal
Produce a skill package that is spec-compliant, concise, discoverable, and reliable in real agent workflows.

## Use this skill when
- Creating a new `SKILL.md`-based skill
- Refactoring a long or vague skill
- Improving invocation reliability
- Adding evaluation prompts and acceptance checks

## Do not use this skill when
- The user asks for one-off ad hoc instructions (not reusable)
- The task is only to run an existing script without authoring or updating a skill

## Workflow
1. Interview the user first (mandatory):
   - Use `askUserQuestion` extensively to gather requirements before drafting.
   - Use the runtime's equivalent tool when names differ (for example `question`).
   - Start with a structured core set of questions, then continue with targeted follow-ups until ambiguity is removed.
   - Cover mission, scope boundaries, trigger phrases, risk level, scripts, outputs, evaluation needs, and tooling preferences.
   - Do not draft any skill files until required interview answers are complete.

2. Run Context7 tooling discovery (mandatory):
   - Use Context7 on every new skill request to identify relevant CLIs and libraries.
   - Resolve candidate libraries first, then query docs for practical usage patterns.
   - Build a shortlist of 2-4 candidates when multiple viable options exist.
   - Summarize tradeoffs clearly and ask the user which option to adopt.
   - If the user rejects all candidates, continue with an instructions-only approach.
   - Record the final tooling choice and rationale in the validation report; do not create a dedicated tooling-decision artifact file.

3. Define scope:
   - Write one sentence for mission.
   - List in-scope and out-of-scope tasks.
   - Keep one workflow per skill.

4. Set degree of freedom:
   - Choose high freedom for context-dependent tasks with multiple valid approaches.
   - Choose medium freedom when a preferred pattern exists but some variation is acceptable.
   - Choose low freedom with deterministic scripts for fragile, repeatable operations.

5. Draft frontmatter:
   - Set `name` (lowercase, hyphenated, matches folder).
   - Write `description` with:
     - what it does
     - when to use it
     - user-facing trigger keywords
   - Add optional fields only when useful (`license`, `compatibility`, `metadata`, `allowed-tools`).

6. Write lean `SKILL.md` body:
   - Include goal, usage boundaries, workflow steps, edge cases, and outputs.
   - Include selected tooling decisions when external CLIs or libraries are adopted.
   - Use imperative, objective instruction language.
   - Keep terminology consistent across the whole skill.
   - Keep it concise; move deep details to `references/`.

7. Apply progressive disclosure:
   - Keep `SKILL.md` as navigation and core procedure.
   - Place detailed docs in `references/`.
   - Keep references one level deep from `SKILL.md`.

8. Add safety and determinism:
   - Avoid secrets in skill files and scripts.
   - Use scripts only for fragile, repetitive, deterministic steps.
   - Prefer least-privilege tools; require confirmation for risky side effects.

9. Build an evaluation set:
   - Start with an evaluation-first loop: baseline behavior, minimal instructions, then iterate.
   - Add explicit trigger prompts.
   - Add implicit trigger prompts.
   - Add negative controls that must not trigger.

10. Add feedback loops for quality-critical tasks:
   - Include validate -> fix -> repeat loops where output correctness matters.
   - Add clear stopping conditions before proceeding to next steps.

11. Run acceptance checks:
   - Interview responses complete for all required categories.
   - Context7 discovery completed and user tooling choice captured.
   - Skill avoids anti-patterns (monolithic `SKILL.md`, over-fragmented references).
   - Content avoids time-sensitive instructions unless clearly marked legacy.
   - Frontmatter valid and name-directory match.
   - Description quality is specific and bounded.
   - Referenced files exist.
   - Safety checks pass.

## Output format
Return:
1. Final directory tree
2. `SKILL.md` content
3. Any `references/*` and `scripts/*` content
4. A short validation report against checklist criteria

## References
- Checklist: `references/checklist.md`
- Description patterns: `references/description-patterns.md`
- Evaluation prompts: `references/eval-prompts.md`
- Interview question bank: `references/interview-question-bank.md`
- Interview playbook: `references/interview-playbook.md`
- Context7 discovery playbook: `references/context7-discovery-playbook.md`
- Tooling selection rubric: `references/tooling-selection-rubric.md`
- Quality patterns: `references/quality-patterns.md`
