# Defined in - @ line 1
function ssh --wraps='TERM=xterm-256color ssh' --description 'alias ssh=TERM=xterm-256color ssh'
  TERM=xterm-256color ssh $argv;
end
