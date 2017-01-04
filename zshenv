# Defines environment variables.

export ENABLE_SPRING=1
export DEFAULT_USER=$USER
export PHANTOMJS_BIN="/usr/local/bin/phantomjs"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PS1=$PS1'$( [ -n $TMUX ] && tmux setenv -g TMUX_PWD_$(tmux display -p "#D" | tr -d %) $PWD)'

# recommended by brew doctor {{{
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"
# }}}

export PATH="$HOME/.bin:$PATH"
export PATH="/Users/alexanderjeurissen/.dotfiles/scripts:$PATH" # include my own scripts
export TERM=xterm-256color-italic
export PYTHONIOENCODING=utf8
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

# Go settings
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export PATH="$PATH:/Users/alexanderjeurissen/Development/arcanist/bin"

# FZF {{{
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
#  export FZF_DEFAULT_OPTS='
#    --color fg:7,bg:0,hl:12,fg+:7,bg+:10,hl+:1
#    --color info:3,prompt:5,pointer:1,marker:5,spinner:3,header:8
#  '

# Cake
# export FZF_DEFAULT_OPTS='
#   --color fg:0,bg:15,hl:8,fg+:0,bg+:14,hl+:6
#   --color info:6,prompt:6,pointer:6,marker:6,spinner:6,header:8
# '

# Base2-Tone
# export FZF_DEFAULT_OPTS='
#   --color fg:13,bg:0,hl:8,fg+:13,bg+:10,hl+:15
#   --color info:3,prompt:5,pointer:1,marker:5,spinner:3,header:8
# '

# OneDark.vim
# export FZF_DEFAULT_OPTS='
#   --color fg:145,bg:235,hl:59,fg+:145,bg+:236,hl+:170
#   --color info:180,prompt:170,pointer:170,marker:204,spinner:170,header:59
# '

# Gruvbox.vim
export FZF_DEFAULT_OPTS='
  --color fg:223,bg:234,hl:245,fg+:223,bg+:237,hl+:11
  --color info:81,prompt:167,pointer:167,marker:167,spinner:167,header:245
'

# }}}

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
