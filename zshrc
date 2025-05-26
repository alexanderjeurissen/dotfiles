# NOTE: zsh config profiling
# zmodload zsh/zprof


# Allow expanding commands using C-e
# bindkey -e # Disabled in favor of vi mode
bindkey "^E" forward-char

# History settings {{{
  SAVEHIST=100000
  HISTFILE=~/.zsh_history
  setopt appendhistory
  setopt sharehistory
  setopt histignorealldups
  setopt incappendhistory
  setopt hist_reduce_blanks
  setopt hist_verify
# }}}

# Disables greeting
unsetopt correct_all

# FZF settings {{{
bindkey -r "^T"
bindkey -M emacs '^F' fzf-file-widget
bindkey -M vicmd '^F' fzf-file-widget
bindkey -M viins '^F' fzf-file-widget

__fsel_branch() {
  local branches=$(git branch --list)
  setopt localoptions pipefail no_aliases 2> /dev/null
  local branch_name
  echo "$branches" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --ansi --tac --query=${LBUFFER} ${FZF_DEFAULT_OPTS-} ${FZF_BRANCH_OPTS-}" $(__fzfcmd) | awk '{print $1}' | while read -r branch_name; do
    echo "$branch_name"
  done
  local ret=$?
  echo
  return $ret
}

fzf-branch-widget() {
  LBUFFER="${LBUFFER}$(__fsel_branch)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle -N fzf-branch-widget
bindkey -r "^B"
bindkey -M emacs '^B' fzf-branch-widget
bindkey -M vicmd '^B' fzf-branch-widget
bindkey -M viins '^B' fzf-branch-widget
# }}}


# Plugins {{{
  if command -v brew >/dev/null; then
    plugin_dir="$(brew --prefix)/share/zsh-autosuggestions"
    [[ -f $plugin_dir/zsh-autosuggestions.zsh ]] && source $plugin_dir/zsh-autosuggestions.zsh
    # TODO: zsh-syntax-highlighting significantly slows down the shell
    # source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
# }}}

# Vi settings {{{
  bindkey -v
# }}

source ~/.zsh_aliases
builtin source ~/.zsh_prompt
source ~/.zsh_keybindings
# vim: foldmethod=marker:sw=2:foldlevel=10
#

# Initialize zoxide (improved cd)
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"


# NOTE: profile zsh config
# zprof
