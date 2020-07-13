# Defined in - @ line 1
function ls --wraps='exa --group-directories-first' --description 'alias ls=exa --group-directories-first'
  exa --group-directories-first $argv;
end
