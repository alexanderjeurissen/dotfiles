#
# Defines environment variables.
#
export ENABLE_SPRING=1
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
  --color fg:7,bg:0,hl:12,fg+:7,bg+:10,hl+:1
  --color info:3,prompt:5,pointer:1,marker:5,spinner:3,header:8
'

# # Cake
# export FZF_DEFAULT_OPTS='
#   --color fg:0,bg:15,hl:8,fg+:0,bg+:14,hl+:6
#   --color info:6,prompt:6,pointer:6,marker:6,spinner:6,header:8
# '
