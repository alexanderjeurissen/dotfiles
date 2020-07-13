# Defined in - @ line 1
function urlencode --wraps='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"' --description 'alias urlencode=python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
  python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])" $argv;
end
