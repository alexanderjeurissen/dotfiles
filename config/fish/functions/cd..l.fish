# Defined in - @ line 1
function cd..l --wraps='cd .. && l' --description 'alias cd..l=cd .. && l'
  cd .. && l $argv;
end
