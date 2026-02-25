## 1. Loop CLI and model resolution

- [ ] 1.1 Replace plan/build argument parsing in `scripts/ralph_loop` with required positional `prompt_file` parsing and fail-fast validation
- [ ] 1.2 Add `--max-iterations`, `--model`, and `--profile` option parsing to `scripts/ralph_loop`
- [ ] 1.3 Implement model precedence logic (`--model` > `RALPH_MODEL` > profile default from `--profile`/`RALPH_PROFILE` > OpenCode default)
- [ ] 1.4 Update session labeling and startup output in `scripts/ralph_loop` to remove plan/build semantics and include prompt-derived context

## 2. OpenCode execution and runtime controls

- [ ] 2.1 Replace Claude invocation with `opencode run` invocation in `scripts/ralph_loop` while preserving per-iteration log files
- [ ] 2.2 Update log status parsing to OpenCode JSON event types and keep robust fallback status handling
- [ ] 2.3 Implement graceful stop key handling for `q` in interactive terminals only (stop after current iteration)
- [ ] 2.4 Simplify signal handling so `Ctrl+C` performs immediate hard stop and process-group cleanup
- [ ] 2.5 Update iteration commit message format to remove mode-prefixed tokens (`ralph:plan` / `ralph:build`)

## 3. Remove deprecated setup skill and references

- [ ] 3.1 Delete `agents/skills/ralph-setup/SKILL.md`
- [ ] 3.2 Delete `agents/skills/ralph-setup/templates/AGENTS.md`
- [ ] 3.3 Delete `agents/skills/ralph-setup/templates/IMPLEMENTATION_PLAN.md`
- [ ] 3.4 Delete `agents/skills/ralph-setup/templates/PROMPT_build.md`
- [ ] 3.5 Delete `agents/skills/ralph-setup/templates/PROMPT_plan.md`
- [ ] 3.6 Remove or update repository references that still prescribe the removed dual-prompt `ralph-setup` flow

## 4. Verification

- [ ] 4.1 Verify CLI fail-fast behavior for missing `prompt_file` and missing prompt path
- [ ] 4.2 Verify model resolution precedence with representative combinations of CLI flags and env vars
- [ ] 4.3 Verify `q` graceful-stop and `Ctrl+C` hard-stop behavior in interactive runs
- [ ] 4.4 Verify non-TTY execution disables graceful hotkey polling without breaking loop execution
