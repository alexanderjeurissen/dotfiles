# NOTE: init starship prompt
# starship init fish | source

# NOTE: init zoxide (improved cd)
zoxide init fish | source

# NOTE: allow expanding commands using C-e
bind -M insert \cE forward-char

# NOTE: disables "Welcome to Fish" greeting
set fish_greeting

set -gx ENABLE_SPRING 0
set -gx DEFAULT_USER $USER

# set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"

# NOTE: H1 related env variables {{{
  set -gx SKIP_WAIT 1
  set -gx PROCFILE_NAME 'Procfile.local'
  set -gx LINT_STAGED 1
  set -gx PULL_LOCK 1
# }}}

set PATH "/home/linuxbrew/.linuxbrew/bin" $PATH # NOTE: linux brew
set PATH "$HOME/.bin" $PATH # TODO: evaluate env var
set PATH "$HOME/bin" $PATH # NOTE: linux usr bin
set PATH "$HOME/.local/bin" $PATH # NOTE: linux usr bin
set PATH "$HOME/.scripts" $PATH # include my own scripts

set PATH "$HOME/.yarn/bin" $PATH
set PATH "$HOME/.cargo/bin" $PATH

eval (luarocks path)


# set -g XML_CATALOG_FILES "/usr/local/etc/xml/catalog" # TODO: evaluate env var

# Java settings {{{
  # set -gx JAVA_HOME (/usr/libexec/java_home)
  # set -gx MAVENPATH $HOME/.maven
  # set PATH $PATH "$MAVENPATH/bin"
# }}}

# FZF settings {{{
 set -gx FZF_DEFAULT_OPTS '--color=bw,border:0,bg:8,info:2,prompt:12,fg:10 --height 40% --reverse --prompt="  "'
 # set -gx FZF_DEFAULT_OPTS '--color=bg+:#073642,bg:#eee8d5,spinner:#859900,hl:#586e75,fg:#073642,pointer:#859900,info:#cb4b16,fg+:#fdf6e3,marker:#859900,header:#586e75,prompt:#859900,hl+:#859900'
 set -gx _ZO_FZF_OPTS "--height 40% --reverse $FZF_DEFAULT_OPTS"
 set -gx FZF_DEFAULT_COMMAND 'rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'
 set -gx FZF_CTRL_T_COMMAND 'rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'
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
  # gpgconf --launch gpg-agent
  set -gx GPG_TTY (tty)
  set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  # fish_ssh_agent
  # set -gx SSH_AUTH_SOCK "/Users/alexanderjeurissen/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
# }}}

source ~/.gitaliases

# vim: foldmethod=marker:sw=2:foldlevel=10
