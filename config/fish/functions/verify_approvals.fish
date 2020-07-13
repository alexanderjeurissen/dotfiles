# Defined in - @ line 1
function verify_approvals --wraps='approvals verify -d nvim -d  -a' --description 'alias verify_approvals=approvals verify -d nvim -d  -a'
  approvals verify -d nvim -d  -a $argv;
end
