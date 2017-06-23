# Defines environment variables.
export ENABLE_SPRING=1
export DEFAULT_USER=$USER
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export NO_SUGGESTED_REVIEWERS=yes

# recommended by brew doctor {{{
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"
# }}}


# export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

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
   --color fg:223,bg:234,hl:245,fg+:223,bg+:237,hl+:11
   --color info:81,prompt:167,pointer:167,marker:167,spinner:167,header:245
 '
# }}}

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
