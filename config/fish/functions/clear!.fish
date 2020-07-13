# Defined in - @ line 1
function clear! --wraps=clear\ \&\&\ printf\ \'\\e\[3J\' --description alias\ clear!=clear\ \&\&\ printf\ \'\\e\[3J\'
  clear && printf '\e[3J' $argv;
end
