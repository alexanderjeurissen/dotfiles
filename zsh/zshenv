#
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# export FZF_DEFAULT_OPTS='
# --color fg:10,bg:7,hl:136,fg+:7,bg+:10,hl+:234
# --color info:33,prompt:125,spinner:160,pointer:167,marker:255,header:33
# '

export FZF_DEFAULT_OPTS='
  --color=light
'

