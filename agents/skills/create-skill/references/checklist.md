# Skill Quality Checklist

## Spec compliance
- [ ] Directory contains `SKILL.md`
- [ ] `name` is 1-64 chars, lowercase/hyphenated, no leading/trailing hyphen, no `--`
- [ ] `name` matches directory name
- [ ] `description` is present and non-vague
- [ ] Optional fields used correctly (`license`, `compatibility`, `metadata`, `allowed-tools`)

## Interview completeness
- [ ] Core interview questions completed
- [ ] Majority of questions use structured options
- [ ] Required fields collected before drafting starts
- [ ] Follow-up questions resolve conflicting or incomplete answers

## Tooling discovery
- [ ] Context7 discovery run for every new skill request
- [ ] Candidate CLIs/libraries identified and compared
- [ ] User asked to choose when multiple candidates exist
- [ ] Chosen tooling (or no-tooling decision) is explicitly recorded
- [ ] Final skill content reflects the user's tooling decision

## Routing quality
- [ ] Description states what the skill does
- [ ] Description states when to use it
- [ ] Description includes likely user keywords
- [ ] Scope boundaries are explicit

## Authoring quality
- [ ] Degree of freedom is explicitly chosen (high, medium, low)
- [ ] Instructions use imperative, objective language
- [ ] Terminology is consistent throughout the skill
- [ ] No avoidable time-sensitive instructions
- [ ] No monolithic or over-fragmented structure

## Progressive disclosure
- [ ] `SKILL.md` is concise and procedural
- [ ] Deep detail lives in `references/`
- [ ] No deep reference chaining
- [ ] Every referenced file exists

## Safety
- [ ] No secrets in files
- [ ] Side effects call out confirmation requirements
- [ ] Tool usage follows least privilege
- [ ] Non-standard metadata is stored under `metadata` (not random top-level keys)

## Evaluation readiness
- [ ] Baseline behavior captured before adding heavy instructions
- [ ] At least one validate -> fix -> repeat feedback loop is included for quality-critical outputs
- [ ] Explicit trigger prompts defined
- [ ] Implicit trigger prompts defined
- [ ] Negative controls defined
- [ ] Expected trigger outcomes documented
