starship init fish | source

bind -M insert \cE forward-char

set -Ux ENABLE_SPRING 0
set -g DEFAULT_USER $USER

set -Ux LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
set -Ux CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"

# NOTE: H1 related env variables {{{
  set -Ux SKIP_WAIT 1
  set -Ux PROCFILE_NAME 'Procfile.local'
# }}}

set PATH "/usr/local/bin" $PATH
set PATH "/usr/local/sbin" $PATH

set PATH "$HOME/.bin" $PATH # TODO: evaluate env var
set PATH "$HOME/.scripts" $PATH # include my own scripts

set PATH "$HOME/.yarn/bin" $PATH
set PATH "$HOME/.cargo/bin" $PATH

set PATH "$HOME/.rbenv/shims" $PATH
set PATH "$HOME/.nodenv/shims" $PATH

# TMUX needs screen-256-color
if set -q TMUX
  set TERM tmux-256color;
else
  set TERM xterm-256color-italic
end

set -g XML_CATALOG_FILES "/usr/local/etc/xml/catalog" # TODO: evaluate env var

# Java settings {{{
  set -Ux JAVA_HOME (/usr/libexec/java_home)
  set -Ux MAVENPATH $HOME/.maven
  set PATH $PATH "$MAVENPATH/bin"
# }}}

# FZF settings {{{
 set -Ux FZF_DEFAULT_OPTS '--color=bg+:#073642,bg:#eee8d5,spinner:#859900,hl:#586e75,fg:#073642,pointer:#859900,info:#cb4b16,fg+:#fdf6e3,marker:#859900,header:#586e75,prompt:#859900,hl+:#859900'
 set -Ux FZF_DEFAULT_COMMAND 'rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'
 set -Ux FZF_CTRL_T_COMMAND 'rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'
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

# makes sure global bin is respected when doing yarn global add
# https://github.com/yarnpkg/yarn/issues/1027
set PATH $PATH (yarn global bin)

source ~/.gitaliases
