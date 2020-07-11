# export NODENV_ROOT=/usr/local/var/nodenv

if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash)"; fi
if which nodenv > /dev/null; then eval "$(nodenv init - --no-rehash)"; fi

# Defines environment variables.
export ENABLE_SPRING=0
export DEFAULT_USER=$USER
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

# NOTE: H1 related env variables {{{
  export SKIP_WAIT=1
  export PROCFILE_NAME='Procfile.local'
# }}}

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.bin:$PATH" # TODO: evaluate env var
export PATH="$HOME/.scripts:$PATH" # include my own scripts

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.nodenv/shims:$PATH"

# Git fuzzy {{{
  export PATH="$HOME/Development/open_source/git-fuzzy/bin:$PATH"
  # export GF_BAT_STYLE=changes
  export GF_BAT_THEME=solarized
# }}}

# TMUX needs screen-256-color
if [ -n "$TMUX" ]; then
  export TERM=tmux-256color;
else
  export TERM=xterm-256color-italic
fi

export XML_CATALOG_FILES="/usr/local/etc/xml/catalog" # TODO: evaluate env var

# Java settings {{{
  export JAVA_HOME=`/usr/libexec/java_home`
  export MAVENPATH=$HOME/.maven
  export PATH=$PATH:$MAVENPATH/bin
# }}}

# Scarf settings {{{
  export PATH=$PATH:$HOME/.scarf/bin
# }}}

# FZF settings {{{
 # export FZF_DEFAULT_OPTS='--color bw'
  # --color fg:240,bg:230,hl:33,fg+:241,bg+:221,hl+:33
  # --color info:33,prompt:33,pointer:166,marker:166,spinner:33
 export FZF_DEFAULT_OPTS='--color=bg+:#073642,bg:#eee8d5,spinner:#859900,hl:#586e75,fg:#073642,pointer:#859900,info:#cb4b16,fg+:#fdf6e3,marker:#859900,header:#586e75,prompt:#859900,hl+:#859900'
# }}}

export VIM_CONFIG_PATH=$HOME/.config/nvim/

# The following two are required to make yarn install binaries and
# packages in nodenv's location. Without they will go into
# ~/.yarn/bin, ~/.config/yarn. These config settings get written into
# ~/.yarnrc. The problem is that this only works with the `nodenv
# prefix` that is in effect when these commands run (ie. a global
# version) - whereas nodenv can use a local version or one set by
# NODENV_VERSION in the shell
# yarn config set prefix `nodenv prefix`
# yarn config set global-folder `nodenv prefix`

# makes sure global bin is respected when doing yarn global add
# https://github.com/yarnpkg/yarn/issues/1027
export PATH="$PATH:$(yarn global bin)"
