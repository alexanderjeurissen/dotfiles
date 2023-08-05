# NOTE: init zoxide (improved cd)
zoxide init fish | source

# NOTE: allow expanding commands using C-e
bind -M insert \cE forward-char

# NOTE: disables "Welcome to Fish" greeting
set fish_greeting

set -gx ENABLE_SPRING 0
set -gx DEFAULT_USER $USER

set -gx EDITOR 'nvim'
set -gx HSANDBOX_EDITOR 'nvim'

# NOTE: util variables (used by Tmux etc) {{{
set -gx NERD_IDX_FILL '' '' '' '' '' '' '' '' '' ''
set -gx NERD_IDX_OUTLINE '' '' '' '' '' '' '' '' '' ''
# }}}

# NOTE: misc env variables {{{
set -gx TZ_LIST 'Europe/Amsterdam,America/New_York,America/Los_Angeles'
# }}}

# TODO: figure out why we had this
# set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"

# NOTE: H1 related env variables {{{
  set -gx SKIP_WAIT 1
  set -gx LINT_STAGED 1
  set -gx PULL_LOCK 1
  set -gx USING_ASDF true
  set -gx POSTGRES_USERNAME 'alexanderjeurissenlocal'
  set -gx POSTGRES_PASSWORD 'hunter3'
  set -gx TAILWIND_MODE watch
  set -gx HACKERONE_ON_DOCKER true
  export NODE_OPTIONS=--max_old_space_size=4096
# }}}

# NOTE: set ripgrep rc file
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

# NOTE: set path {{{
set PATH "/home/linuxbrew/.linuxbrew/bin" $PATH # NOTE: linux brew
set PATH "$HOME/.bin" $PATH # TODO: evaluate env var
set PATH "$HOME/bin" $PATH # NOTE: linux usr bin
set PATH "$HOME/.local/bin" $PATH # NOTE: linux usr bin
set PATH "$HOME/.local/opt" $PATH # NOTE: webi installs
set PATH "$HOME/.scripts" $PATH # include my own scripts

set PATH "$HOME/.yarn/bin" $PATH
set PATH "$HOME/.cargo/bin" $PATH

eval (luarocks path)
# }}}

# NOTE: Go path settings {{{
  set -gx GOPATH "$HOME/Development/go"
  set PATH "$GOPATH/bin" $PATH
# }}}

# set -g XML_CATALOG_FILES "/usr/local/etc/xml/catalog" # TODO: evaluate env var

# Java settings {{{
  # set -gx JAVA_HOME (/usr/libexec/java_home)
  # set -gx MAVENPATH $HOME/.maven
  # set PATH $PATH "$MAVENPATH/bin"
# }}}

# FZF settings {{{
 set -gx FZF_DEFAULT_OPTS '--color=bw,border:0,info:2,prompt:12,fg:,bg+:0,fg+:,gutter:0 --height 40% --reverse --prompt="  " --border=none --no-separator --no-scrollbar'

 set -gx _ZO_FZF_OPTS "--height 40% --reverse $FZF_DEFAULT_OPTS"
 set -gx FZF_DEFAULT_COMMAND 'rg --files'
 set -gx FZF_CTRL_T_COMMAND 'rg --files'
# }}}

# LS colors settings {{{
eval (gdircolors -c ~/.dircolors/dircolors.ansi-dark)
# }}}
# The following two are required to make yarn install binaries and
# packages in nodenv's location. Without they will go into
# ~/.yarn/bin, ~/.config/yarn. These config settings get written into
# ~/.yarnrc. The problem is that this only works with the `nodenv
# prefix` that is in effect when these commands run (ie. a global
# version) - whereas nodenv can use a local version or one set by
# NODENV_VERSION in the shell
# yarn config set prefix `nodenv prefix`
# yarn config set global-folder `nodenv prefix`

# GPG settings {{{
  # set -x SSH_AUTH_SOCK /Users/alexanderjeurissen/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
# }}}

alias g git
source ~/.gitaliases

# vim: foldmethod=marker:sw=2:foldlevel=10

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

