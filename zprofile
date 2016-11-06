export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export NODENV_ROOT=/usr/local/var/nodenv



# recommended by brew doctor {{{
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"
  eval "$(rbenv init - --no-rehash)"
  eval "$(nodenv init - --no-rehash)"
  export NVM_DIR=~/.nvm
  . $(brew --prefix nvm)/nvm.sh
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
