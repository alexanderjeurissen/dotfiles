function! ActivateColorScheme()
  set background=dark
  colorscheme deus
  highlight! VertSplit guibg=#242a32
  highlight! StatusLine guifg=#242a32 guibg=#ebdab2
  highlight! StatusLineNC guifg=#242a32 guibg=#ebdab2
  highlight! CursorLineNr guibg=#242a32 guifg=#ebdab2

  highlight! SignColumn guibg=#242a32
  highlight! SignifySignAdd guibg=#242a32 guifg=#99c379
  highlight! SignifySignDelete guibg=#242a32 guifg=#fb4733
  highlight! SignifySignChange guibg=#242a32 guifg=#8ec07b

  highlight! AleWarningSign guibg=#242a32 guifg=#ebdab2

  highlight! CursorLine guibg=#292f37
  highlight! ColorColumn guibg=#292f37
  " highlight! link WhiteSpace AleErrorSign
  highlight! link QuickFixLine DiffText
endfunction
