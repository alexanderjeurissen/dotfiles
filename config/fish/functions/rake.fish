# Defined in - @ line 1
function rake --wraps='noglob rake' --description 'alias rake=noglob rake'
  noglob rake $argv;
end
