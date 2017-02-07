switch $TERM
  case eterm eterm-color
    function fish_title; end
    function fish_default_key_bindings; end
end

# set rbenv
status --is-interactive; and . (rbenv init -|psub)

# set default editor to vim
setenv EDITOR vim

# disable fish welcome message
set fish_greeting ""

# load general aliases
source ~/.config/fish/aliases.fish

# load git aliases
source ~/.config/fish/git_aliases.fish

# load git prompt
source ~/.config/fish/prompt.fish
# source ~/.config/fish/prompt_new.fish
