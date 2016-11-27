[ -n "$TMUX" ] && export TERM=screen-256color

if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# prompt {{{
  autoload -U promptinit && promptinit
  POWERLEVEL9K_MODE='awesome-patched'
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_DISABLE_RPROMPT=true

  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
  POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="❯ "

  POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  POWERLEVEL9K_SHORTEN_DELIMITER=""
  POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
  POWERLEVEL9K_DIR_HOME_BACKGROUND="black"
  POWERLEVEL9K_DIR_HOME_FOREGROUND="249"
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="black"
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="249"
  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="black"
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="249"
  POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
  POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
  POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
  POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
  POWERLEVEL9K_TIME_BACKGROUND="black"
  POWERLEVEL9K_TIME_FOREGROUND="249"
  POWERLEVEL9K_TIME_FORMAT="%D{\UE12E %H:%M \uE868 %d.%m.%y}"
  POWERLEVEL9K_SHOW_CHANGESET=true
  POWERLEVEL9K_STATUS_VERBOSE=true
  POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=('status' 'context' 'dir' 'vcs')
# }}}

# Vi mode {{{
  bindkey -v
  export KEYTIMEOUT=1
# }}}

# completions {{{
  autoload -U compinit && compinit
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# }}}

# Zplug plugin definitions {{{
  source ~/.zplug/init.zsh
  zplug "zsh-users/zsh-syntax-highlighting", nice:10
  zplug "bhilburn/powerlevel9k"
# }}}

# aliasses {{{
  alias l="ls -1AG"
  alias up="git up && bundle && yarn && bin/rake db:migrate"
  alias stash="git add -A && git commit -m 'TEMP_COMMIT: stashed changes on `date`'"
  alias rake="noglob bin/rake"
  alias spec="bin/rspec"
  alias console="bin/rails console"
  alias commit="git add -A && git commit"
  alias migrations="g up && bin/rake db:migrate"
  alias rails="bin/rails"
  alias r="rails"
  alias routes="zeus rake routes | fzf"
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
  alias proselint='PYTHONIOENCODING=utf8 proselint'
# }}}

# Aliases for TaskWarrior {{{
  alias t="task"
  alias in='task add +in'

  # TICKLER file, defer items etc.
  tickle() {
      deadline=$1
      shift
      in +tickle wait:$deadline $@
  }

  alias tick=tickle

  # Think something over ? like yes/no ? think alias!!
  alias think='tickle +1d'
# }}}

# Aliases for common typo's {{{
  alias cd..='cd ..'
  alias cd..l='cd .. && l'
  alias cd..ls='cd .. && ls'
# }}}

# Nvim & vim aliases {{{
  alias vim='nvim'
  alias vi='nvim'
  alias v='nvim'
  alias oldvim="\vim"

  # Courtesy of Henry Kupty
  # this makes it so no nested vim sessions are started when editing files in term splits
  if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
    alias h='nvr -o'
    alias v='nvr -O'

    alias vim='nvr -O'
    alias nvim='nvr -O'
    alias vi='nvr -O'
  fi
# }}}

# Aliases for foreman {{{
  alias startServices="tmux new-window -n 'Services' 'foreman start -c all=0,redis=1,postgresql=1,mailcatcher=1 ; read'"
  alias startBackend="tmux new-window -n 'Backend' 'foreman start -c all=1,redis=0,postgresql=0,mailcatcher=0,sass=0,webpack=0,uidocs=0,karma=0 ; read'"
  alias startFrontend="tmux new-window -n 'Frontend' 'foreman start -c all=0,sass=1,webpack=1,uidocs=1,karma=1 ; read'"

  alias nServices="foreman start -c all=0,redis=1,postgresql=1,mailcatcher=1 ; read"
  alias nBackend="foreman start -c all=1,redis=0,postgresql=0,mailcatcher=0,sass=0,webpack=0,uidocs=0,karma=0 ; read"
  alias nFrontend="foreman start -c all=0,sass=1,webpack=1,uidocs=1,karma=1 ; read"

  alias startAll="startServices & startBackend & startFrontend"
# }}}

# Aliases for Arcanist {{{
  alias diffb="arc diff --browse"
  # alias difflc="arc diff --browse --message \"$(git log -1 --pretty=%B)\""
# }}}

# Aliases for directories {{{
  alias h1="cd ~/git/hackerone/"
  alias dotfiles="cd ~/.dotfiles/"
# }}}

alias psqlh1='psql -D "./tmp/postgres" -k . -p 3100'

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

export PS1=$PS1'$( [ -n $TMUX ] && tmux setenv -g TMUX_PWD_$(tmux display -p "#D" | tr -d %) $PWD)'
export TMPDIR="/private/tmp" # fix vim-dispatch/issues/64

# added by travis gem
[ -f /Users/alexander/.travis/travis.sh ] && source /Users/alexander/.travis/travis.sh

# Zplug {{{
# Can manage local plugins
# zplug "~/.zsh", from:local

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# }}}

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Gruvbox 256 colors support OSX
# source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
# source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh"

# git aliases {{{
  source ~/.gitaliases
  alias changedfiles= "git diff --name-only | uniq | xargs nvim"
  alias removeArtefacts="git stash -u && git stash drop"
  # alias rebase_to_develop="git rebase -i HEAD~$(git log --oneline develop..|wc -l| tr -d ' ')"
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

it2prof() { echo -e "\033]50;SetProfile=$1\a" }

# Fzf functions {{{
  # fbr - checkout git branch (including remote branches)
  fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  }

  # fco - checkout git branch/tag
  fco() {
    local tags branches target
    tags=$(
      git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
      git branch --all | grep -v HEAD             |
      sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
      sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
      (echo "$tags"; echo "$branches") |
      fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
  }
#}}}
export PATH="/Users/alexanderjeurissen/Development/arcanist/bin:$PATH"
