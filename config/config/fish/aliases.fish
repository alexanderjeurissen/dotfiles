## ALIASES
# alias rake="noglob rake"
alias pryr="pry -r ./config/environment -r rails/console/app -r rails/console/helpers"
# alias bower="noglob bower"
alias rubocop="/Users/alexander/.rbenv/versions/2.1.0/bin/rubocop"
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias gd='git diff'
alias sq='sequelize'
alias gcc='gcc-4.9'
alias l='ls -l'
# alias tn='tmux new -s "(basename $PWD)"; or tmux at -t "(basename $PWD)";'
function tn
  set --local session_name (basename $PWD)
  tmux new -s "$session_name"; or tmux at -t "$session_name";
end
# this alias replaces vim with nvim
alias vim='vim'

# Aliases for common typo's
alias cd..='cd ..'

alias attach='tmux attach -t'

# Directory aliases
alias etf='cd ~/git/PersonalProjects/EmergencyTeamFrontend/'
alias etb='cd ~/git/PersonalProjects/EmergencyTeamBackend/'
alias 3feed='cd ~/git/Defacto/360-Feedback/'
alias 3web='cd ~/git/Defacto/360WebApp/'
alias hours='cd ~/Git/Defacto/Hours'
alias LS='cd ~/git/Defacto/LearningSpaces'

alias shopback='cd ~/git/Hanze/ShopOfTheFuture_backend'
alias shopfront='cd /git/Hanze/ShopOfTheFuture_frontend'
alias shopmob='cd /git/Hanze/ShopOfTheFuture_android'

alias newtab='cd /git/PersonalProjects/new-tab-replacement'
alias poc='cd ~/git/ProofOfConcepts/'
alias resolutions='system_profiler SPDisplaysDataType |grep Resolution'
