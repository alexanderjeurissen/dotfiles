function! tmux#RunSpecAtLine()
  let l:current_line = expand('%') . ':' . line('.')
  execute 'silent !tmux send-keys -t bottom-right C-c'
  execute 'silent !tmux send-keys -t bottom-right "spec '. l:current_line .'" Enter'
endfunction
