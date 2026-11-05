# Subagents

Delegation runs through Paseo (`pi-paseo-subagent`: `subagent_run`, `subagent_wait`,
`subagent_read`, `subagent_list`, `subagent_stop`). It works only inside a Paseo agent. In the Pi
CLI, do the work yourself.

If your task starts with "You are a delegated Paseo subagent", do not start subagents unless your
task or the skill it names tells you to.

## Profiles

Pick the model with `profile`, not `provider`. `subagent_presets` lists each profile's model, effort
and "when to use" notes. Pass `thinking` only to change the effort for one call.

| Profile | Use for |
|---|---|
| `opus` | Planning, hard debugging, the advisor, the Anthropic review pass |
| `sol` | The OpenAI review pass, cross-vendor checks of code |
| `sonnet` | Implementation from a clear spec, coordinators, research scouts |
| `haiku` | Cheap scoped subagents: search, triage, summaries, extraction |
| `terra` | Screenshots and diagrams, drafting text, moderate coding |
| `astra` | A second opinion on a high-stakes decision, only when the user asks |

## Advisor

The default model is a fast executor. A stronger model adds judgment. Consult it:

- **Before you commit to an approach** on multi-step work where the plan decides the outcome
  (a refactor, a design choice, a migration, a subsystem you do not know).
- **When an error continues** after two failed fixes for the same failure.
- **Before you declare a non-trivial task done** (a multi-file change, a change with hidden
  consequences, the step before a commit or MR goes out).

Do not consult for short, mechanical or clear work, and always when the user asks.

```js
subagent_run({ name: "advisor", role: "scout", profile: "opus", prompt: <brief> })
```

Then `subagent_wait` for it. A **second opinion** uses a different vendor and costs more: run it
only when the user asks. Offer it before a high-stakes, hard-to-reverse decision, or when you and
the advisor disagree. Use `profile: "astra"`.

The brief must stand alone, because the subagent cannot see this conversation:

1. **Goal:** the purpose of the task and its constraints.
2. **State:** the work done so far and the evidence, with file paths.
3. **Plan or proposal:** what you intend to do, or the conclusion to check. For a second opinion,
   put the problem before the proposal so it forms its own view first.
4. **Question:** the one item you need judged.
5. **Rules:** "Give guidance in under 300 words. Do not edit, write or start subagents."

Trust evidence more than advice. If a recommended step fails, or the code contradicts a claim, say
so. If a consultation changes the plan, tell the user in one line.

## Code review

For a review of an MR, PR, branch or diff, use the `mr-dual-review` skill where it exists. It
starts one coordinator subagent that runs an Opus and a Sol pass, merges them and posts. Do not
review a change you wrote in this session.
