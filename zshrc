# NOTE: zsh config profiling
# zmodload zsh/zprof


# Allow expanding commands using C-e
# bindkey -e # Disabled in favor of vi mode
bindkey "^E" forward-char

# History settings {{{
# Reduce HISTSIZE or disable incappendhistory if history lag is noticeable
  SAVEHIST=100000        # total number of lines kept in history file
  HISTSIZE=5000          # limit in-memory history to improve responsiveness
  HISTFILE=~/.zsh_history
  setopt appendhistory
  setopt sharehistory
  setopt histignorealldups
  setopt incappendhistory # disable if history lag becomes noticeable
  setopt hist_reduce_blanks
  setopt hist_verify
# }}}

# Disables greeting
unsetopt correct_all

# FZF settings {{{
if command -v fzf >/dev/null; then
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
else
  fzf-file-widget()   { echo 'fzf not installed' >&2; }
  fzf-branch-widget() { echo 'fzf not installed' >&2; }
fi
# }}}


# Plugins {{{
# Heavy plugins are loaded lazily to keep startup fast. See _lazy_init_plugins
# below for details.
# }}}

# Lazy-load plugin initialization after the first prompt. Manual autoload via
# add-zsh-hook delays sourcing of zsh-autosuggestions, zoxide and fzf shell
# integration until the shell is ready, which keeps startup responsive.
autoload -Uz add-zsh-hook
_lazy_init_plugins() {
  if [[ -z ${_zsh_autosuggest_loaded-} ]] && command -v brew >/dev/null; then
    local dir="$HOMEBREW_PREFIX/share/zsh-autosuggestions"
    [[ -f $dir/zsh-autosuggestions.zsh ]] && source $dir/zsh-autosuggestions.zsh
    _zsh_autosuggest_loaded=1
  fi

  if [[ -z ${_zoxide_loaded-} ]] && command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
    _zoxide_loaded=1
  fi

  if [[ -z ${_fzf_shell_loaded-} ]] && command -v fzf >/dev/null; then
    eval "$(fzf --zsh)"
    _fzf_shell_loaded=1
  fi

  if [[ ${_zsh_autosuggest_loaded-0} -eq 1 && ${_zoxide_loaded-0} -eq 1 && ${_fzf_shell_loaded-0} -eq 1 ]]; then
    add-zsh-hook -d precmd _lazy_init_plugins
  fi
}
add-zsh-hook precmd _lazy_init_plugins

# Vi settings {{{
  bindkey -v
# }}

source ~/.zsh_aliases
builtin source ~/.zsh_prompt
source ~/.zsh_keybindings
# vim: foldmethod=marker:sw=2:foldlevel=10
#

# NOTE: profile zsh config
# zprof
