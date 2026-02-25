## ADDED Requirements

### Requirement: Loop runner uses OpenCode with a single prompt input
The loop runner SHALL execute iterations using OpenCode and SHALL require a single positional `prompt_file` argument. The runner MUST fail fast with a non-zero exit when `prompt_file` is omitted or the file does not exist.

#### Scenario: Prompt argument omitted
- **WHEN** an operator runs the loop runner without a positional prompt file argument
- **THEN** the runner exits non-zero and prints usage including the required `prompt_file` positional

#### Scenario: Prompt file missing
- **WHEN** an operator passes a `prompt_file` path that does not exist
- **THEN** the runner exits non-zero before starting any iteration and reports the missing file path

#### Scenario: Iteration executes via OpenCode
- **WHEN** an operator starts the runner with a valid prompt file
- **THEN** each iteration invokes OpenCode in non-interactive run mode and writes iteration output logs to the session directory

### Requirement: Model selection follows deterministic precedence
The loop runner SHALL resolve model selection with this precedence order: CLI `--model`, then `RALPH_MODEL`, then profile default selected by `--profile` or `RALPH_PROFILE`, then OpenCode default model behavior.

#### Scenario: CLI model overrides env and profile
- **WHEN** an operator provides `--model` and also has `RALPH_MODEL` and profile defaults configured
- **THEN** the runner uses the CLI model value for the iteration command

#### Scenario: Env model used when CLI model absent
- **WHEN** an operator omits `--model` and `RALPH_MODEL` is set
- **THEN** the runner uses `RALPH_MODEL` regardless of selected profile

#### Scenario: Profile default used when explicit model is absent
- **WHEN** an operator omits `--model` and `RALPH_MODEL`, and selects a profile through `--profile` or `RALPH_PROFILE`
- **THEN** the runner uses that profile's configured default model

### Requirement: Stop controls separate graceful and hard termination
The loop runner SHALL support graceful stop-after-boundary by pressing `q` during an active iteration, and SHALL treat `Ctrl+C` as immediate hard termination of the runner and its child process group.

#### Scenario: Operator requests graceful stop with q
- **WHEN** an operator presses `q` while an iteration is running in an interactive terminal
- **THEN** the runner completes the current iteration, performs normal end-of-iteration actions, and exits before starting the next iteration

#### Scenario: Operator requests hard stop with Ctrl+C
- **WHEN** an operator presses `Ctrl+C` while an iteration is running
- **THEN** the runner immediately terminates the child process group, restores terminal state, and exits with interrupt semantics

#### Scenario: Non-interactive environment has no graceful hotkey
- **WHEN** the runner executes in a non-TTY environment
- **THEN** graceful stop hotkey polling is disabled and the runner continues to support hard stop signals

### Requirement: Session metadata no longer depends on plan/build modes
The loop runner SHALL name session/log context without plan/build mode semantics and SHALL include prompt-derived context in operator-visible metadata.

#### Scenario: Session starts with single prompt mode
- **WHEN** a new loop session begins
- **THEN** startup output and session directory naming do not reference `plan` or `build` mode labels

#### Scenario: Iteration commits avoid mode token
- **WHEN** iteration commit messages are generated
- **THEN** commit messages do not contain `ralph:plan` or `ralph:build` mode prefixes
