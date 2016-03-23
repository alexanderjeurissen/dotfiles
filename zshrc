export PATH="$HOME/.bin:$PATH"


# recommended by brew doctor
export PATH="/usr/local/bin:$PATH"
eval "$(rbenv init - --no-rehash)"
eval "$(nodenv init - --no-rehash)"
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh

# minimal prompt
autoload -U promptinit && promptinit
prompt pure

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# completions
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# aliasses
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
alias tn='tmux new -s "$(basename `pwd`)" || tmux at -t "$(basename `pwd`)"'
alias attach='tmux attach -t'
alias findP='ps -ef | grep -v grep | grep '

# Create nginx conf for current git repo
alias devlink='nginx_setup'
alias sites='ranger $(brew --prefix)/etc/nginx/sites/'
# Aliases for common typo's
alias cd..='cd ..'
alias cd..l='cd .. && l'
alias cd..ls='cd .. && ls'


#H1 aliases
alias start_db="pg_ctl -D ./tmp/postgres -l logfile start"
alias h1="cd ~/git/hackerone/"
# set vim as defaut editory
export EDITOR="vim"

# rbenv and nodeenv init
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export TMPDIR="/private/tmp" # fix vim-dispatch/issues/64

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

export PATH="/Users/alexanderjeurissen/Development/arcanist/bin:$PATH"


# FZF
# COLOR:
#     fg      Text
#     bg      Background
#     hl      Highlighted substrings
#     fg+     Text (current line)
#     bg+     Background (current line)
#     hl+     Highlighted substrings (current line)
#     info    Info
#     prompt  Prompt
#     pointer Pointer to the current line
#     marker  Multi-select marker
#     spinner Streaming input indicator
#     header  Header

# export FZF_DEFAULT_OPTS='
# --color fg:7,bg:0,hl:136,fg+:7,bg+:2,hl+:2
# --color info:7,prompt:7,spinner:7,pointer:167,marker:255,header:33
# '
export FZF_DEFAULT_OPTS='
  --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
  --color info:183,prompt:110,spinner:107,pointer:167,marker:215
'

nginx_setup() {
  local dest=$(brew --prefix)/etc/nginx/sites/$(basename `pwd`).conf

  $(cp ~/.dotfiles/nginx/template.conf $dest)
  $(sed -ie "s/APP_NAME/$(basename `PWD`)/g" $dest)
  $(sed -ie "s@APP_PATH@$PWD@g" $dest)
  $(sudo nginx -s reload)
}
