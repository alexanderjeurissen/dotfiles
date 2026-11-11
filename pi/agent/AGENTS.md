## Advisor

An advisor is a fresh-context check at a decision point. It sees only your brief, so it catches what
your own context hides. Consult it:

- **Before you commit to an approach** on multi-step work where the plan decides the outcome
  (a refactor, a design choice, a migration, a subsystem you do not know).
- **When an error continues** after two failed fixes for the same failure.
- **Before you declare a non-trivial task done** (a multi-file change, a change with hidden
  consequences, the step before a commit or MR goes out).

Do not consult for short, mechanical or clear work, and always when the user asks.

Pick the advisor by your own model (`$PI_MODEL`):

- **You run on Opus** (the default): use `sol`, a different vendor at a lower price.
- **You run on any other model:** use `opus`.

```js
subagent_run({ name: "advisor", role: "scout", profile: "sol", prompt: <brief> }) // "opus" if you are not Opus
```

Then `subagent_wait` for it.

# Subagents

Delegation runs through Paseo (`pi-paseo-subagent`: `subagent_run`, `subagent_wait`,
`subagent_read`, `subagent_list`, `subagent_stop`). It works only inside a Paseo agent. In the Pi
CLI, do the work yourself.

If your task starts with "You are a delegated Paseo subagent", do not start subagents unless your
task or the skill it names tells you to.

## Delegate by default

Inside Paseo, hand separable work to subagents instead of doing it all yourself. Subagents keep your
context small, run in parallel, and let a cheaper model do cheap work. Before a multi-step task,
split it: what can run without you, and what needs your judgment?

Delegate:

- **Reading and searching** across many files, modules or repos (`haiku`).
- **Log, CI and test-output triage**, and summaries of long threads, diffs or docs (`haiku`).
- **Research**: web or doc lookups, comparing options, checking versions (`sonnet`).
- **Independent tracks** of a larger task, one subagent each, run in parallel (`sonnet`).
- **Verification** with fresh eyes: reviewing your own change, checking a claim (`opus` or `sol`).

Do it yourself when the work is a few tool calls, when steps depend tightly on each other, or when
it is a decision or an outward-facing action (posting, committing, messaging).

How:

- Start independent subagents together, then keep working. Paseo wakes you when each finishes;
  use `subagent_wait` only when you need the result now.
- Pick the cheapest profile that fits. Up to 8 active subagents at a time (the tool's limit per agent).
- The brief must stand alone: goal, paths, constraints, the exact output wanted.
- Speed comes from turn count, not from the model. A subagent costs about 10 s to start, and each
  tool round trip costs 3-6 s, at any thinking level. To cut turns, name the exact files and
  commands in the brief, and tell the child to batch independent reads and searches into one
  `codemode` call. `opus` is the slowest per turn; prefer `haiku` or `sol` when a scout must be fast.
- Ask for long results in a file and the path in the reply: the finish notification truncates at
  4,000 characters. Use `~/.local/state/subagents/<skill-or-task>/<slug>/<unit>.md`, one file per
  child, and ask for a one-line verdict plus the path as the reply. Never `/tmp`: macOS empties it on
  reboot while Paseo resumes the session, so the parent keeps the summary and loses the report.
- Fan out only when there are three or more independent units. For one or two, do them yourself.
  Split a long job that has independent parts (more than about 10 tool calls in a row) across
  parallel children; a unit of a few calls is not worth the start-up cost.
- Children never act outward: no posting, commenting, committing, pushing, messaging, or Linear or
  tracker writes. Say so in every brief. Children have the same tools you have, so this is an
  instruction, not a block. The parent reads the files, decides and acts.
- Subagents share your working directory. Give `worker` subagents disjoint files, and never two
  writers on the same file.

## Profiles

Pick the model with `profile`, not `provider`. `subagent_presets` lists each profile's model, effort
and "when to use" notes. Pass `thinking` only to change the effort for one call.

| Profile | Use for |
|---|---|
| `opus` | Planning, hard debugging, the Anthropic review pass, the advisor for non-Opus sessions |
| `sol` | The OpenAI review pass, cross-vendor checks, the advisor for Opus sessions |
| `sonnet` | Implementation from a clear spec, coordinators, research scouts |
| `haiku` | Cheap scoped subagents: search, triage, summaries, extraction |
| `terra` | Screenshots and diagrams, drafting text, moderate coding |
| `astra` | Only when the user asks for `astra` by name |

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

Then `subagent_wait` for it.

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
