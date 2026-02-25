## Why

The current `scripts/ralph_loop` is optimized for a Claude-specific two-mode workflow (`plan` vs `build`) and carries complex double-`Ctrl+C` signal logic that increases operational friction. We want a simpler, model-flexible loop runner centered on OpenCode with a single prompt input and clearer run controls.

## What Changes

- Replace Claude-specific execution in `scripts/ralph_loop` with OpenCode execution (`opencode run`) while preserving iterative loop behavior and per-iteration logs.
- Remove mode differentiation (`plan`/`build`) and require a single positional prompt file argument; fail fast when omitted or missing.
- Introduce model/profile configuration with deterministic precedence: CLI `--model`, then `RALPH_MODEL`, then profile default (`--profile`/`RALPH_PROFILE`), then OpenCode default.
- Simplify stop controls: `q` requests graceful stop after the current iteration; `Ctrl+C` performs immediate hard stop.
- Update session/log labeling and commit message semantics to remove mode coupling and reflect single-prompt operation.
- Remove the `ralph-setup` skill and its template artifacts so repository guidance no longer depends on dual prompt files.

## Capabilities

### New Capabilities
- `ralph-loop-runner`: Defines the single-prompt OpenCode loop contract, runtime controls, model/profile resolution, and logging behavior.
- `ralph-skill-catalog`: Defines repository skill catalog expectations for removing deprecated Ralph setup scaffolding artifacts.

### Modified Capabilities
- None.

## Impact

- Affected code: `scripts/ralph_loop`.
- Affected docs/skills: `agents/skills/ralph-setup/` (removed) and any references to two-prompt Ralph setup flow.
- Runtime behavior: key handling changes (`q` graceful, `Ctrl+C` hard), model selection path changes, and single required prompt file input.
- Tooling dependency: OpenCode CLI availability for loop execution.
