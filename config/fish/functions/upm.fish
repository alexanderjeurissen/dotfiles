# Defined in - @ line 1
function upm --wraps='git pull origin master:master --rebase --ff-only' --description 'alias upm=git pull origin master:master --rebase --ff-only'
  git pull origin master:master --rebase --ff-only $argv;
end
