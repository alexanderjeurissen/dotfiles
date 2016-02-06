export PATH="$HOME/.bin:$PATH"


# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

# minimal prompt
autoload -U promptinit && promptinit
prompt pure

# Vi mode
bindkey -v

# completions
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# aliasses
alias l="ls -1AG"
alias rake="noglob rake"
alias pryr="pry -r ./config/environment -r rails/console/app -r rails/console/helpers"
alias bower="noglob bower"
alias rubocop="/Users/alexander/.rbenv/versions/2.1.0/bin/rubocop"
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias showDriveUsage='sudo lsof'
alias gd='git diff'
alias sq='sequelize'
alias gcc='gcc-5'
alias c++='c++-5'
alias tn='tmux new -s "$(basename `pwd`)" || tmux at -t "$(basename `pwd`)"'
alias findP='ps -ef | grep -v grep | grep '

# Aliases for common typo's
alias cd..='cd ..'
alias cd..l='cd .. && l'
alias cd..ls='cd .. && ls'

alias attach='tmux attach -t'

# Directory aliases
alias etf='cd ~/git/PersonalProjects/EmergencyTeamFrontend/'
alias etb='cd ~/git/PersonalProjects/EmergencyTeamBackend/'
alias 3feed='cd ~/git/Defacto/360-Feedback/'
alias 3web='cd ~/git/Defacto/360WebApp/'
alias hours='cd ~/Git/Defacto/Hours'
alias LS='cd ~/git/Defacto/LearningSpaces'
alias proof='cd ~/git/Defacto/proof'

alias shopback='cd ~/git/Hanze/ShopOfTheFuture_backend'
alias shopfront='cd /git/Hanze/ShopOfTheFuture_frontend'
alias shopmob='cd /git/Hanze/ShopOfTheFuture_android'

alias newtab='cd /git/PersonalProjects/new-tab-replacement'
alias poc='cd ~/git/ProofOfConcepts/'
alias resolutions='system_profiler SPDisplaysDataType |grep Resolution'

export EDITOR="vim"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


export NVM_DIR="/Users/alexander/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export TMPDIR="/private/tmp" # fix vim-dispatch/issues/64
# source /usr/local/share/zsh/site-functions/_aws
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f /Users/alexander/.travis/travis.sh ] && source /Users/alexander/.travis/travis.sh

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# git aliases
source ~/.gitaliases

# History options
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

# Go settings
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
