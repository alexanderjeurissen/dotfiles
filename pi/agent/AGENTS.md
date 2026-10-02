# Advisor and second opinion

If you have the `spawn` tool, this section applies. The default model is a fast executor. Two named minions add judgment:

- `advisor`: a stronger Anthropic model.
- `second-opinion`: a model from a different vendor.

Both minions are read-only and give guidance. You stay responsible for the work and the decision.

This section does not apply to the `advisor` or `second-opinion` minion itself.

## When to consult the advisor

Use `spawn({ tasks: [{ agent: "advisor", task: <brief> }] })` at these points:

- **Before you commit to an approach** on multi-step work where the plan decides the outcome.
  Examples: a refactor, a design choice, a migration, a subsystem that you do not know.
- **When an error continues** after two failed fixes for the same failure.
- **Before you declare a non-trivial task done.** This includes a multi-file change, a change with
  hidden consequences, and the step before a commit or MR goes out.

Do not consult for short, mechanical, or clear work. A small task usually needs no consultation. A
long task usually needs two or three. Also consult when the user asks.

## When to get a second opinion

The `second-opinion` minion costs more, so use it only on request. Run it when the user asks for a
second opinion.

Offer it, but do not run it without approval, in these cases:

- Before a high-stakes decision that is hard to reverse.
- When you and the advisor disagree about an important point.

## The brief

The minion cannot see this conversation. Each brief must include:

1. **Goal:** the purpose of the task and its constraints.
2. **State:** the work done so far and the evidence, with file paths.
3. **Plan or proposal:** what you intend to do, or the conclusion to check.
4. **Question:** the one item that you need judged.
5. **Transcript:** the path in `$PI_SESSION_FILE`. Get it with `bash`. The minion can use it to
   read more history.

For `second-opinion`, put the problem statement before the proposal. This lets the minion form its
own view first.

## How to use the answer

Apply the guidance, but trust evidence more than advice. If a recommended step fails, or if the code
contradicts a claim, say so. Do not follow the advice without question. If a consultation changes
the plan, tell the user in one line.
