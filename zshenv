export DEFAULT_USER=$USER
export EDITOR='nvim'
export HSANDBOX_EDITOR='nvim'

export HOMEBREW_PREFIX="/opt/homebrew" # lookup using (brew --prefix)
# Export early so startup scripts can use the cached value without invoking brew

# Misc env variables
export TZ_LIST='Europe/Amsterdam,America/New_York,America/Los_Angeles'

# H1 related env variables
export SKIP_WAIT=1
export LINT_STAGED=1
export PULL_LOCK=1

# export LIBRARY_PATH="/opt/homebrew/opt/gcc/lib/gcc/$(gcc -dumpversion)/"
# export LD_LIBRARY_PATH="/opt/homebrew/opt/gcc/lib/gcc/$(gcc -dumpversion)/"

# Set ripgrep rc file
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Opt out from telemetry
export OPENSPEC_TELEMETRY=0
export DO_NOT_TRACK=1

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
