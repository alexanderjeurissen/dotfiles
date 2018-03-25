function! terminal#Settings()
  " NOTE: Some vim things I'd rather disable
  " so that the terminal looks more distinct from regular buffers
  setlocal nonumber
  setlocal norelativenumber
  setlocal nocursorline
  setlocal nocursorcolumn

  call general#MarkMargin(0)

  " NOTE: make sure we start in insertmode
  " so we can get typing right away
  startinsert

  " NOTE: make C-d terminate the terminal like
  " in other terminals
  noremap <buffer> <C-d> :q<CR>

endfunction
