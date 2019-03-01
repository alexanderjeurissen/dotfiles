function! ActivateColorScheme()
  let g:solarized_term_italics = 1
  colorscheme solarized8_high
  hi CurrentSearchMatch gui=reverse guifg=#073642 guibg=#eee8d5
endfunction
