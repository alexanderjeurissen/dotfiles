# Defined in - @ line 1
function dotfiles --wraps='cd ~/.dotfiles/' --description 'alias dotfiles=cd ~/.dotfiles/'
  cd ~/.dotfiles/ $argv;
end
