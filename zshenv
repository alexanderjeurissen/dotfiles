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
export PATH="$HOME/.cargo/bin:$PATH"

export TERM=xterm-256color-italic
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

# Go settings {{{
  export GOPATH=$HOME/golang
  export GOROOT=/usr/local/opt/go/libexec
  export PATH=$PATH:$GOPATH/bin
  export PATH=$PATH:$GOROOT/bin
# }}}

# FZF settings {{{
export FZF_DEFAULT_OPTS='
   --color fg:0,bg:15,hl:8,fg+:0,bg+:14,hl+:6
   --color info:6,prompt:6,pointer:6,marker:6,spinner:6,header:8'
# }}}

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
