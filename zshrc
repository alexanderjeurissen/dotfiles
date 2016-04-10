export PATH="$HOME/.bin:$PATH"

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# recommended by brew doctor {{{
  export PATH="/usr/local/bin:$PATH"
  eval "$(rbenv init - --no-rehash)"
  eval "$(nodenv init - --no-rehash)"
  export NVM_DIR=~/.nvm
  . $(brew --prefix nvm)/nvm.sh
# }}}

# minimal prompt {{{
  autoload -U promptinit && promptinit
  prompt pure
# }}}

# Vi mode {{{
  bindkey -v
  export KEYTIMEOUT=1
# }}}

# completions {{{
  autoload -U compinit && compinit
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# }}}

# aliasses {{{
  alias l="ls -1AG"
  alias rake="noglob bundle exec rake"
  alias pryr="pry -r ./config/environment -r rails/console/app -r rails/console/helpers"
  alias bower="noglob bower"
  alias rubocop="/Users/alexander/.rbenv/versions/2.1.0/bin/rubocop"
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
  alias showDriveUsage='sudo lsof'
  alias sq='sequelize'
  alias gcc='gcc-5'
  alias c++='c++-5'
  alias tn='tmux new -s "${$(basename `PWD`)//./}" || tmux at -t "${$(basename `PWD`)//./}"'
  alias attach='tmux attach -t'
  alias findP='ps -ef | grep -v grep | grep '
# }}}

# Aliases for common typo's {{{
  alias cd..='cd ..'
  alias cd..l='cd .. && l'
  alias cd..ls='cd .. && ls'
# }}}

# Nvim & vim aliases {{{
  alias vim='nvim'
  alias nvim='nvim'
  alias v='nvim'
  alias vi='vim'
# }}}

# Aliases for foreman {{{
  alias startServices="tmux new-window -n 'Services' 'foreman start -c all=0,redis=1,postgresql=1,mailcatcher=1 ; read'"
  alias startBackend="tmux new-window -n 'Backend' 'foreman start -c all=1,redis=0,postgresql=0,mailcatcher=0,sass=0,webpack=0,uidocs=0,karma=0 ; read'"
  alias startFrontend="tmux new-window -n 'Frontend' 'foreman start -c all=0,sass=1,webpack=1,uidocs=1,karma=1 ; read'"
  alias startAll="startServices & startBackend & startFrontend"
# }}}

alias h1="cd ~/git/hackerone/"

# Alias for clearing the screen
alias clearScreen="clear && printf '\e[3J'"

# set nvim as defaut editory
export EDITOR="nvim"

# rbenv and nodeenv init {{{
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
  if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
# }}}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# FZF {{{
  export FZF_DEFAULT_COMMAND='ag -l -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export TMPDIR="/private/tmp" # fix vim-dispatch/issues/64

# added by travis gem
[ -f /Users/alexander/.travis/travis.sh ] && source /Users/alexander/.travis/travis.sh

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# git aliases {{{
  source ~/.gitaliases
  alias changedfiles= "git diff --name-only | uniq | xargs nvim"
# }}}

# History options {{{
  if [ -z "$HISTFILE" ]; then
      HISTFILE=$HOME/.zsh_history
  fi

  HISTSIZE=10000
  SAVEHIST=10000

  setopt append_history
  setopt extended_history
  setopt hist_expire_dups_first
  setopt hist_ignore_dups # ignore duplication command history list
  setopt hist_ignore_space
  setopt hist_verify
  setopt inc_append_history
  setopt share_history # share command history data
#}}}

export PATH="/Users/alexanderjeurissen/Development/arcanist/bin:$PATH"

# Nginx {{{
  nginx_setup() {
    local dest=$(brew --prefix)/etc/nginx/sites/$(basename `pwd`).conf

    $(cp ~/.dotfiles/nginx/template.conf $dest)
    $(sed -ie "s/APP_NAME/$(basename `PWD`)/g" $dest)
    $(sed -ie "s@APP_PATH@$PWD@g" $dest)
    $(sudo nginx -s reload)
  }

  # Create nginx conf for current git repo
  alias devlink='nginx_setup'
  alias sites='ranger $(brew --prefix)/etc/nginx/sites/'

# }}}
