# Defined in - @ line 1
function routes --wraps='rails_routes | fzf | pbcopy' --description 'alias routes=rails_routes | fzf | pbcopy'
  rails_routes | fzf | pbcopy $argv;
end
