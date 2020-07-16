# Defined in - @ line 1
function console --wraps='bin/rails console' --description 'alias console=bin/rails console'
  bin/rails console $argv;
end
