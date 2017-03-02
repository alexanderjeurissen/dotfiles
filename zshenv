# Defines environment variables.
export ENABLE_SPRING=1
export DEFAULT_USER=$USER
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# recommended by brew doctor {{{
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"
# }}}

export PATH="$HOME/.bin:$PATH"
export PATH="/Users/alexanderjeurissen/.dotfiles/scripts:$PATH" # include my own scripts
export PATH="$PATH:/Users/alexanderjeurissen/Development/arcanist/bin"

export TERM=xterm-256color-italic
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

# Go settings {{{
  export GOPATH=$HOME/golang
  export GOROOT=/usr/local/opt/go/libexec
  export PATH=$PATH:$GOPATH/bin
  export PATH=$PATH:$GOROOT/bin
# }}}

# FZF {{{
  # export FZF_DEFAULT_OPTS='
  #   --color fg:188,bg:237,hl:241,fg+:188,bg+:236,hl+:176
  #   --color info:180,prompt:176,pointer:176,marker:168,spinner:176,header:241
  # '

  export FZF_DEFAULT_OPTS='
    --color fg:237,bg:231,hl:247,fg+:237,bg+:255,hl+:127
    --color info:136,prompt:127,pointer:127,marker:167,spinner:127,header:247
  '
# }}}

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
