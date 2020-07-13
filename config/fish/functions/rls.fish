# Defined in - @ line 1
function rls --wraps='cd && cd - && ls -G' --description 'alias rls=cd && cd - && ls -G'
  cd && cd - && ls -G $argv;
end
