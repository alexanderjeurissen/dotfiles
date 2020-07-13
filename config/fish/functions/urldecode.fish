# Defined in - @ line 1
function urldecode --wraps='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"' --description 'alias urldecode=python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
  python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])" $argv;
end
