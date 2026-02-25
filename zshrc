# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/alexanderjeurissen/.zsh/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# NOTE: zsh config profiling
# zmodload zsh/zprof

eval "$(mise activate zsh)"

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

# Initialize completion system
autoload -Uz compinit
compinit -d ~/.cache/zcompdump-$ZSH_VERSION
if [[ -f ~/.cache/zcompdump-$ZSH_VERSION ]]; then
  zcompile ~/.cache/zcompdump-$ZSH_VERSION
fi

# Disables greeting
unsetopt correct_all

# Lazy-load plugin initialization after the first prompt. Manual autoload via
# add-zsh-hook delays sourcing of zsh-autosuggestions, zoxide and atuin shell
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

  # make sure you have `tac` [1] (if on on macOS) and `atuin` [2] installed, then drop the below in your ~/.zshrc
  #
  # [1]: https://unix.stackexchange.com/questions/114041/how-can-i-get-the-tac-command-on-os-x
  # [2]: https://github.com/ellie/atuin
  if [[ -z ${_atuin_shell_loaded-} ]] && command -v atuin >/dev/null; then
    export ATUIN_NOBIND="true"

    eval "$(atuin init zsh)"

  bindkey '^R' _atuin_search_widget
  bindkey -M emacs '^R' _atuin_search_widget
  bindkey -M vicmd '^R' _atuin_search_widget
  bindkey -M viins '^R' _atuin_search_widget

  bindkey '^E' _atuin_search_widget
  bindkey -M emacs '^E' _atuin_search_widget
  bindkey -M vicmd '^E' _atuin_search_widget
  bindkey -M viins '^E' _atuin_search_widget

    _atuin_shell_loaded=1
  fi

  if [[ ${_zsh_autosuggest_loaded-0} -eq 1 && ${_zoxide_loaded-0} -eq 1 && ${_fzf_shell_loaded-0} -eq 1 ]]; then
    add-zsh-hook -d precmd _lazy_init_plugins
  fi
}
add-zsh-hook precmd _lazy_init_plugins

# Vi settings {{{
  bindkey -v
# }}

if [[ -f ~/.zsh_aliases.zwc ]]; then
  source ~/.zsh_aliases.zwc
else
  source ~/.zsh_aliases
fi

if [[ -f ~/.zsh_prompt.zwc ]]; then
  builtin source ~/.zsh_prompt.zwc
else
  builtin source ~/.zsh_prompt
fi

if [[ -f ~/.zsh_keybindings.zwc ]]; then
  source ~/.zsh_keybindings.zwc
else
  source ~/.zsh_keybindings
fi


if [[ -f .venv/bin/activate ]]; then
  source .venv/bin/activate
fi

# vim: foldmethod=marker:sw=2:foldlevel=10
#

# NOTE: profile zsh config
# zprof
