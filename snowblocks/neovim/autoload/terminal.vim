function! terminal#Settings()
  " NOTE: Some vim things I'd rather disable
  " so that the terminal looks more distinct from regular buffers
  setlocal nonumber
  setlocal norelativenumber
  setlocal nocursorline
  setlocal nocursorcolumn

  " NOTE: make sure we start in insertmode
  " so we can get typing right away
  startinsert
endfunction
