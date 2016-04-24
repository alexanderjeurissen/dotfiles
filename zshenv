#
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi


# export FZF_DEFAULT_OPTS='
#   --color=dark
# '


# FZF
# COLOR:
#     fg      Text
#     bg      Background
#     hl      Highlighted substrings
#     fg+     Text (current line)
#     bg+     Background (current line)
#     hl+     Highlighted substrings (current line)
#     info    Info
#     prompt  Prompt
#     pointer Pointer to the current line
#     marker  Multi-select marker
#     spinner Streaming input indicator
#     header  Header

# Gotham
# export FZF_DEFAULT_OPTS='
# --color fg:7,bg:0,hl:5,fg+:6,bg+:8,hl+:5
# --color info:2,prompt:5,spinner:1,pointer:6,marker:255,header:33

# solarized
export FZF_DEFAULT_OPTS='
  --color=dark
'

# export FZF_DEFAULT_OPTS='
#   --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
#   --color info:183,prompt:110,spinner:107,pointer:167,marker:215
# '
