# vim:foldmethod=marker:sw=2

# NOTE: Helps with profiling zsh startup time
# zmodload zsh/zprof

if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# general functions {{{
  # NOTE: Make a directory and move into it
  # https://unix.stackexchange.com/questions/125385/combined-mkdir-and-cd
  mkcdir() {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
  }

  # NOTE: Run command till the exit code is zero
  try_loop() {
    until [ $? == 0 ]
    do
      echo "LOOPING !!"
      $@
      sleep 0.1
    done
  }

  until_fail() {
    until [ $? != 0 ]
    do
      echo "TRY_FAIL_LOOP"
      $@
      sleep 0.1
    done
  }

  port() { lsof -n -i:$@ | grep LISTEN; }
  device() { lsof +f -- $@ }

  wifi_signal_strength() {
    while x=1; do /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI; sleep 0.5; done
  }
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
  ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=white,bold,bg=red')
  ZSH_HIGHLIGHT_PATTERNS+=('git push master' 'fg=white,bold,bg=red')
  ZSH_HIGHLIGHT_PATTERNS+=('git push develop' 'fg=white,bold,bg=red')
  ZSH_HIGHLIGHT_PATTERNS+=('git push develop' 'fg=white,bold,bg=red')
  ZSH_HIGHLIGHT_PATTERNS+=('git merge master' 'fg=white,bold,bg=red')
# }}}

# Vi mode {{{
  # set nvim as defaut editor
  export EDITOR="nvim"

  bindkey -v
  export KEYTIMEOUT=1

  autoload -U edit-command-line
  zle -N edit-command-line
  bindkey -M vicmd v edit-command-line
# }}}

# completions {{{
  zmodload zsh/complist

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

  _fzf_complete_git() {
      ARGS="$@"
      local branches
      local files

      if [[ $ARGS == 'git checkout -- '* ]] || [[ $ARGS == 'git reset -- '* ]]; then
          files=$(git ls-files)
          _fzf_complete "--reverse --multi" "$@" < <(
              echo "$files"
          )
      elif [[ $ARGS == 'git checkout'* ]] || [[ $ARGS == 'git merge'* ]]; then
          branches=$(git branch -vv)
          _fzf_complete "--reverse --multi" "$@" < <(
              echo "$branches"
          )
      else
          eval "zle ${fzf_default_completion:-expand-or-complete}"
      fi
  }

  _fzf_complete_git_post() {
    awk '{print $1}'
  }

  _fzf_complete_g() {
      ARGS="$@"
      local branches
      local files

      if [[ $ARGS == 'g checkout -- '* ]] || [[ $ARGS == 'g reset -- '* ]]; then
          files=$(git ls-files)
          _fzf_complete "--reverse --multi" "$@" < <(
              echo "$files"
          )
      elif [[ $ARGS == 'g checkout'* ]] || [[ $ARGS == 'g merge'* ]]; then
          branches=$(git branch -vv)
          _fzf_complete "--reverse --multi" "$@" < <(
              echo "$branches"
          )
      elif [[ $ARGS == 'g log -- '* ]]; then
          files=$(git ls-files)
          _fzf_complete "--reverse --multi" "$@" < <(
              echo "$files"
          )
      else
          eval "zle ${fzf_default_completion:-expand-or-complete}"
      fi
  }

  _fzf_complete_g_post() {
    awk '{print $1}'
  }

  _fzf_complete_gco() {
      ARGS="$@"
      local branches
      local files

      if [[ $ARGS == 'gco -- '* ]]; then
          files=$(git ls-files)
          _fzf_complete "--reverse --multi" "$@" < <(
              echo "$files"
          )
      elif [[ $ARGS == 'gco'* ]]; then
          branches=$(git branch -vv)
          _fzf_complete "--reverse --multi" "$@" < <(
              echo "$branches"
          )
      else
          eval "zle ${fzf_default_completion:-expand-or-complete}"
      fi
  }

  _fzf_complete_gco_post() {
    awk '{print $1}'
  }
# }}}

# Zgen plugin definitions {{{
  source "${HOME}/.zgen/zgen.zsh"

  # if the init script doesn't exist
  if ! zgen saved; then
    # zgen load "alexanderjeurissen/ombre.zsh" prompt_ombre_setup
    zgen load "zsh-users/zsh-syntax-highlighting"
    zgen load "zsh-users/zsh-completions"
    zgen load "zsh-users/zsh-autosuggestions"

    # generate the init script from plugins above
    zgen save
  fi
# }}}

# aliasses {{{
  alias textedit="/Applications/TextEdit.app/Contents/MacOS/TextEdit"
  alias l="exa -lah --time-style='long-iso' --group-directories-first"
  alias ls="exa --group-directories-first"
  alias rls="cd && cd - && ls -G"
  alias upd="git pull origin develop:develop --rebase --ff-only"
  alias upm="git pull origin master:master --rebase --ff-only"
  alias rake="noglob rake"
  alias console="bin/rails console"
  alias migrate="bin/rake db:migrate && bin/rake db:test:prepare"
  alias rerun="bundle exec cucumber -p rerun"
  alias routes="rails_routes | fzf | pbcopy"
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
  alias disk_usage='sudo lsof'
  alias findP="ps -ef | grep -v grep | grep "
  alias applypatch="git am --signoff <"
  alias create_commit_range_patch="git format-patch"
  alias prof="source ~/.zshrc && source ~/.zshenv && source ~/.zprofile"
  alias structuresql="g difftool develop -- db/structure.sql && g diff develop -- db/structure.sql"
  alias verify_approvals="approvals verify -d nvim -d  -a"
  # FIXME: https://github.com/alexanderjeurissen/dotfiles/issues/14 {{{
  alias changed_files="git diff develop --name-only"
  # }}}
  alias eslintspecific="yarn run eslint:specific -- --fix"
  alias cucumber_step="CAPYBARA_STEP=1 bundle exec cucumber"
  alias urldecode='python -c "import sys, urllib as ul; \
    print ul.unquote_plus(sys.argv[1])"'

  alias urlencode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(sys.argv[1])"'
  alias disable_mouse_acceleration='defaults write .GlobalPreferences com.apple.mouse.scaling -1'
  alias mutt='TERM=screen-256color neomutt'
  alias neomutt='TERM=screen-256color \neomutt'
  alias no_unexpected='git checkout db/structure.sql app/models/bounty.rb'
  # NOTE: needed seeing as remote servers likely won't have my custom tic
  alias ssh='TERM=xterm-256color ssh'
  alias clear!="clear && printf '\e[3J'" # Alias for clearing the whole screen in tmux

  # Alias for pentesting/hacking {{{
    alias proxy-on="sudo networksetup -setsecurewebproxy 'Wi-Fi' 127.0.0.1 12345 && sudo networksetup -setwebproxy 'Wi-Fi' 127.0.0.1 12345"
    alias proxy-off="sudo networksetup -setsecurewebproxystate 'Wi-Fi' off && sudo networksetup -setwebproxystate 'Wi-Fi' off"
    alias subbrute="$HOME/git/hackerij/subbrute/subbrute.py"
  # }}}

  # Aliases for common typo's {{{
    alias cd..='cd ..'
    alias cd..l='cd .. && l'
    alias cd..ls='cd .. && ls'
    alias clera="clear"
    alias celar="clear"
  # }}}

  # Nvim & vim aliases {{{
    alias v='nvim'
    alias v!='nvim -u NONE'

    # v () {
    #   if [ -z "$NVIM_LISTEN_ADDRESS" ]; then
    #     branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    #     basename=$(basename $PWD)
    #     session_name=""

    #     if [[ -z $branch ]] ; then
    #       # attempt to get short-sha-name
    #       branch=":$(git rev-parse --short HEAD 2> /dev/null)"
    #     fi

    #     if [ "$?" -me 0 ]; then
    #       # NOTE: this must not be a git repo
    #       session_name="$basename"
    #     else
    #       session_name="${basename}_${branch}"
    #     fi

    #     abduco -e ^z -A "$session_name" nvim "$@"
    #   else
    #     nvr -s "$@"
    #   fi
    # }
    alias vlint="nvim -q <(yarn run eslint-f `git diff --name-only HEAD  $(git merge-base HEAD origin/develop)`)"
  # }}}

  # Aliases for Arcanist {{{
    alias diff="arc diff"
    alias diffb="arc diff --browse"

    # NOTE: Cherrypick diff by applying it without commit and no branch
    # Then commit it with message: "Patch <diff-id> (TODO: remove this commit before landing)
    cherrypick() {
      arc patch --nocommit --nobranch "${1}"
      git commit -a -m "Patch ${1} (TODO: remove this commit before landing)"
    }
  # }}}

  # Aliases for directories {{{
    alias h1="cd ~/Development/hackerone/"
    alias payments="cd ~/Development/hackerone-payments/"
    alias dotfiles="cd ~/.dotfiles/"
    alias gpodder="cd ~/Library/Application Support/gPodder"
  # }}}

  # Aliases for foreman and psql {{{
    alias psql_rails='psql -U alexander -p 3100 -h localhost -d postgres'
    alias pg_dumpall_rails='pg_dumpall -U alexander -p 3100 -h localhost -f backup.sql'
    alias neo4j="db/neo4j/development/bin/neo4j"
  # }}}
# }}}

# Fzf {{{
# --files: List files that would be searched but do not search
# --ignore: Do respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
  # export FZF_DEFAULT_COMMAND='ag -l -g ""'
  export FZF_DEFAULT_COMMAND='rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# Then, source plugins and add commands to $PATH
# Only source zplugins when a new terminal is opened not when source ~/.zshrc
# This is due to conflict between some plugins that causes a crash
# https://github.com/zsh-users/zsh-autosuggestions/issues/205
if [[ $ZSH_EVAL_CONTEXT == 'file' ]]; then
  # zplug load
fi

# git aliases {{{
  source ~/.gitaliases
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

# Auto suggestions {{{
  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
  bindkey '^e' autosuggest-accept
# }}}

# NOTE: The following lines fool setup setup script that those lines are already present in my
# terminal config. I prefer setting these in the zprofile
# eval "$(rbenv init -)"
# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh


# NOTE: Helps with profiling zsh startup time
# zprof

eval "$(starship init zsh)"
