[ -n "$TMUX" ] && export TERM=screen-256color

if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# prompt {{{
  autoload -U promptinit && promptinit
  prompt pure
# }}}

# ZSH highlighting settings {{{
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
  ZSH_HIGHLIGHT_PATTERNS+=('Closed' 'fg=cyan,bold,bg=default')
  ZSH_HIGHLIGHT_PATTERNS+=('Needs Review' 'fg=magenta,bold,bg=default')
  ZSH_HIGHLIGHT_PATTERNS+=('Needs Revision' 'fg=red,bold,bg=default')
  ZSH_HIGHLIGHT_PATTERNS+=('Accepted' 'fg=green,bold,bg=default')
  ZSH_HIGHLIGHT_PATTERNS+=('No Revision' 'fg=blue,bold,bg=default')
  ZSH_HIGHLIGHT_PATTERNS+=('Abandoned' 'fg=default,bold,bg=default')
  ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
# }}}

# Vi mode {{{
  bindkey -v
  export KEYTIMEOUT=1
# }}}

# completions {{{
  zmodload zsh/complist
  autoload -U compinit && compinit
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  # use the tag name as group name
  zstyle ':completion:*' group-name ''
  # format all messages not formatted in bold prefixed with ----
  zstyle ':completion:*' format '%B---- %d%b'
  # format descriptions (notice the vt100 escapes)
  zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
  # bold and underline normal messages
  zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
  # format in bold red error messages
  zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
  # activate menu selection
  zstyle ':completion:*' menu select
  # activate approximate completion, but only after regular completion (_complete)
  zstyle ':completion:::::' completer _complete _approximate
  # limit to 2 errors
  zstyle ':completion:*:approximate:*' max-errors 2
# }}}

# Zplug plugin definitions {{{
  source ~/.zplug/init.zsh
  zplug "zsh-users/zsh-syntax-highlighting", nice:10
  zplug "zsh-users/zsh-completions"
# }}}

# aliasses {{{
  alias l="ls -AGC"
  alias ls="ls -G"
  alias up="git up && bundle && yarn && bin/rake db:migrate"
  alias stash="git add -A && git commit -m 'TEMP_COMMIT: stashed changes on `date`'"
  alias rake="noglob bin/rake"
  alias console="bin/rails console"
  alias commit="git add -A && git commit"
  alias migrations="g up && bin/rake db:migrate"
  alias rails="bin/rails"
  alias r="bin/rails"
  alias routes="zeus rake routes | fzf"
  alias pryr="pry -r ./config/environment -r rails/console/app -r rails/console/helpers"
  alias bower="noglob bower"
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
  alias showDriveUsage='sudo lsof'
  alias gcc='gcc-5'
  alias c++='c++-5'
  alias tn='tmux new -s "${$(basename `PWD`)//./}" || tmux at -t "${$(basename `PWD`)//./}"'
  alias kn='kak -d -s "${$(basename `PWD`)//./}"'
  alias attach='tmux attach -t'
  alias findP='ps -ef | grep -v grep | grep '
  alias proselint='PYTHONIOENCODING=utf8 proselint'
  alias applypatch='git am --signoff <'
# }}}

# Alias for hackerij {{{
  alias burp='java -jar -Xmx3072m ~/Git/hackerij/burp.jar'
  alias proxy-on="sudo networksetup -setsecurewebproxy 'Wi-Fi' 127.0.0.1 8080 && sudo networksetup -setwebproxy 'Wi-Fi' 127.0.0.1 8080"
  alias proxy-off="sudo networksetup -setsecurewebproxystate 'Wi-Fi' off && sudo networksetup -setwebproxystate 'Wi-Fi' off"
#}}}

# Aliases for TaskWarrior {{{
  alias t="task"
  alias todo='task add +in'

  # TICKLER file, defer items etc.
  tickle() {
      deadline=$1
      shift
      todo +tickle wait:$deadline $@
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
  # alias vim='nvim'
  alias vi='nvim'
  alias v='nvim'
  alias vim='nvim'
# }}}

# Aliases for Arcanist {{{
  alias diffb="arc diff --browse"
  alias diffu="arc diff --no-unit --excuse \"jenkins\" --verbatim"

  nexttask() {
    next_task=`arc task | egrep -o 'T\d+' | head -1`
    echo $next_task | pbcopy
    arc browse $next_task
  }

  browse() {
    case $1 in
      diffs)
        objects=`arc list`
        [ -z $objects ] && return 1
        chosen_object=`echo $objects | fzf | egrep -o 'D\d+'`
        ;;

      tasks)
        objects=`arc tasks`
        [ -z $objects ] && return 1
        chosen_object=`echo $objects | fzf | egrep -o 'T\d+'`
        ;;
      *)
        echo "Usage: $0 {diffs|tasks}"
        return 1
    esac

    if [ -z $chosen_object ]; then
      echo "operation cancelled"
      return 1
    fi

    arc browse "${chosen_diff}"
  }

  # Cherrypick diff by applying it without commit and no branch
  # Then commit it with message: "Patch <diff-id> (TODO: remove this commit before landing)
  cherrypick() {
    arc patch --nocommit --nobranch "${1}"
    git commit -a -m "Patch ${1} (TODO: remove this commit before landing)"
  }
# }}}

# Aliases for directories {{{
  alias h1="cd ~/git/hackerone/"
  alias payments="cd ~/git/hackerone_payments/"
  alias dotfiles="cd ~/.dotfiles/"
# }}}

alias psql_rails='postgres -U alexanderjeurissen -p 3100 -h localhost -d postgres'

# Alias for clearing the screen
alias clearScreen="clear && printf '\e[3J'"

# set nvim as defaut editor
export EDITOR="nvim"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# FZF {{{
  export FZF_DEFAULT_COMMAND='ag -l -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

export TMPDIR="/private/tmp" # fix vim-dispatch/issues/64

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
zplug load

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
  __fzf_branch() {
    local cmd='git branch'

    if which arc > /dev/null; then
      cmd="arcbranchansi"
    fi

    setopt localoptions pipefail 2> /dev/null
    eval "$cmd" | FZF_DEFAULT_OPTS="--ansi --height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
      echo -n "${(q)item} " | cut -d'\' -f1
    done
    local ret=$?
    echo
    return $ret
  }

  branch-widget() {
    LBUFFER="${LBUFFER}$(__fzf_branch)"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
  }
  zle     -N   branch-widget
  bindkey '^B' branch-widget
# }}}
export PATH="/Users/alexanderjeurissen/Development/arcanist/bin:$PATH"
source "$HOME/Development/arcanist/resources/shell/bash-completion"
export PS1=$PS1'$( [ -n $TMUX ] && tmux setenv -g TMUX_PWD_$(tmux display -p "#D" | tr -d %) $PWD)'
