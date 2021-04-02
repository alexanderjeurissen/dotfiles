# Removes the original file of a symbolic link
function rmlink --wraps='rm' --description 'rm "(readlink -f $argv)"'
  set original (greadlink -f $argv)
  rm "$original" && unlink $argv
end
