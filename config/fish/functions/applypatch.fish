# Defined in - @ line 1
function applypatch --wraps='git am --signoff <' --description 'alias applypatch=git am --signoff <'
  git am --signoff < $argv;
end
