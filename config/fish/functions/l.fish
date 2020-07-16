# Defined in - @ line 1
function l --wraps=exa\ -lah\ --time-style=\'long-iso\'\ --group-directories-first --description alias\ l=exa\ -lah\ --time-style=\'long-iso\'\ --group-directories-first
  exa -lah --time-style='long-iso' --group-directories-first $argv;
end
