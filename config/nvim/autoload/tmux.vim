function! tmux#RunSpecAtLine()
  let current_line = expand("%") . ':' . line(".")
  exec 'silent !tmux send-keys -t bottom-right C-c'
  exec 'silent !tmux send-keys -t bottom-right "spec '.current_line.'" Enter'
endfunction
