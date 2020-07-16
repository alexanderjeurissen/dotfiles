# Defined in - @ line 1
function cd..ls --wraps='cd .. && ls' --description 'alias cd..ls=cd .. && ls'
  cd .. && ls $argv;
end
