# Defined in - @ line 1
function upd --wraps='git pull origin develop:develop --rebase --ff-only' --description 'alias upd=git pull origin develop:develop --rebase --ff-only'
  git pull origin develop:develop --rebase --ff-only $argv;
end
