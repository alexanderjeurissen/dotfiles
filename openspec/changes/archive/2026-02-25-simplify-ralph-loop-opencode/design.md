## Context

`scripts/ralph_loop` currently encodes a Claude-oriented workflow with two operational modes (`plan` and `build`), mode-specific prompt defaults, mode-specific model defaults, and double-`Ctrl+C` signal handling for graceful versus force stop behavior. This creates coupling between workflow style and runtime implementation and increases complexity for operators.

The target state is a single OpenCode-based loop contract that accepts one prompt file input and makes stop behavior explicit: `q` for graceful boundary stop and `Ctrl+C` for immediate termination.

## Goals / Non-Goals

**Goals:**
- Standardize execution on OpenCode (`opencode run`) with structured logs suitable for spinner/status feedback.
- Remove plan/build branching and require one explicit prompt file argument.
- Introduce deterministic model resolution via CLI, env, and profile defaults.
- Simplify run controls to one graceful key (`q`) and one hard-stop key (`Ctrl+C`).
- Remove deprecated repository scaffolding guidance (`ralph-setup` skill and templates).

**Non-Goals:**
- Rewriting Ralph prompts or changing prompt authoring methodology beyond accepting a single file path.
- Removing commit/push-per-iteration behavior in this change.
- Introducing interactive profile selection UI.

## Decisions

### 1) Execution engine switches from Claude CLI to OpenCode CLI
- Decision: Replace `claude -p ...` invocation with `opencode run ...` in JSON output mode.
- Rationale: OpenCode is the intended operator surface and already emits machine-parseable event streams.
- Alternatives considered:
  - Keep dual engine support (Claude + OpenCode): rejected for additional branching and maintenance burden.
  - Keep Claude as default with optional OpenCode: rejected because it preserves the legacy coupling we want to remove.

### 2) Single positional prompt file is required
- Decision: CLI requires `ralph_loop <prompt_file>` and exits non-zero with usage when omitted or unreadable.
- Rationale: Explicit input removes hidden behavior and eliminates plan/build mode coupling.
- Alternatives considered:
  - Default to `PROMPT.md` when omitted: rejected due to ambiguity and accidental wrong-context runs.

### 3) Model selection uses strict precedence
- Decision: Resolve model as `--model` > `RALPH_MODEL` > profile default (`--profile` or `RALPH_PROFILE`) > OpenCode default.
- Rationale: Predictable override hierarchy supports one-off experiments and stable environment defaults.
- Alternatives considered:
  - Profile-first before env: rejected because explicit model envs are often used for automation.

### 4) Control semantics: `q` graceful, `Ctrl+C` hard
- Decision: `q` sets a stop-after-current-iteration flag; `Ctrl+C` immediately terminates the loop and child process group.
- Rationale: Keeps graceful stop ergonomic without overloading interrupt signal semantics.
- Alternatives considered:
  - Retain double-`Ctrl+C`: rejected as fragile and harder to reason about.
  - `s` key for graceful stop: rejected in favor of `q` as more natural for quit intent.

### 5) Remove `ralph-setup` skill rather than adapting it
- Decision: delete `agents/skills/ralph-setup/` artifacts.
- Rationale: the skill enforces a dual-prompt setup model that conflicts with the new single-prompt contract.
- Alternatives considered:
  - Update `ralph-setup` to single prompt: rejected per explicit product direction to remove the skill entirely.

## Risks / Trade-offs

- [TTY-only key capture for `q`] -> Mitigation: detect interactive terminal and disable hotkey behavior in non-TTY environments.
- [Mismatch between OpenCode JSON event schema and parser assumptions] -> Mitigation: implement tolerant status parsing with safe fallback (`running`) and validate against real sample logs.
- [Process cleanup regressions on hard stop] -> Mitigation: preserve process group tracking and test `Ctrl+C` termination path manually.
- [Repository references to removed skill become stale] -> Mitigation: search and update/remove direct `ralph-setup` references in docs and skill registries.
- [Per-iteration auto-commit may commit unintended files] -> Mitigation: out of scope for this change; document as known behavior for future hardening.

## Migration Plan

1. Introduce the new `scripts/ralph_loop` CLI contract and OpenCode execution path.
2. Validate core operator flows: fail-fast argument validation, iteration run, `q` graceful stop, `Ctrl+C` hard stop.
3. Remove `agents/skills/ralph-setup/` and clean up references.
4. Announce new invocation examples using explicit prompt file input.

Rollback strategy: restore previous `scripts/ralph_loop` and reintroduce removed skill directory from git history if critical workflow breakage occurs.

## Open Questions

- Should profile defaults map only models, or also behavioral flags (for example push policy) in a follow-up change?
- Should loop status parser also surface token/cost snippets from OpenCode events, or remain minimal?
