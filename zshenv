export DEFAULT_USER=$USER
export EDITOR='nvim'
export HSANDBOX_EDITOR='nvim'

export HOMEBREW_PREFIX="/opt/homebrew" # lookup using (brew --prefix)

# Misc env variables
export TZ_LIST='Europe/Amsterdam,America/New_York,America/Los_Angeles'

# H1 related env variables
export SKIP_WAIT=1
export LINT_STAGED=1
export PULL_LOCK=1
export POSTGRES_USERNAME='alexanderjeurissenlocal'
export POSTGRES_PASSWORD='hunter3'
export TAILWIND_MODE='watch'
export HACKERONE_ON_DOCKER=true

export CLAUDE_CODE_USE_BEDROCK=1
export ANTHROPIC_MODEL="us.anthropic.claude-3-7-sonnet-20250219-v1:0"
export ANTHROPIC_SMALL_FAST_MODEL="us.anthropic.claude-3-5-haiku-20241022-v1:0"

# export LIBRARY_PATH="/opt/homebrew/opt/gcc/lib/gcc/$(gcc -dumpversion)/"
# export LD_LIBRARY_PATH="/opt/homebrew/opt/gcc/lib/gcc/$(gcc -dumpversion)/"

# Set ripgrep rc file
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

