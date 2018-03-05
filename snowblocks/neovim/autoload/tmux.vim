function! tmux#RunSpecAtLine()
  let current_line = expand("%") . ':' . line(".")
  execute 'silent !tmux send-keys -t bottom-right C-c'
  execute 'silent !tmux send-keys -t bottom-right "spec '.current_line.'" Enter'
endfunction
