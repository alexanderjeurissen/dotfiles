# Defined in - @ line 1
function findP --wraps='ps -ef | grep -v grep | grep ' --description 'alias findP=ps -ef | grep -v grep | grep '
  ps -ef | grep -v grep | grep  $argv;
end
