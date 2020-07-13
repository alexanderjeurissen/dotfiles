# Defined in - @ line 1
function disk_usage --wraps='sudo lsof' --description 'alias disk_usage=sudo lsof'
  sudo lsof $argv;
end
