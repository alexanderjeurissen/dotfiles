function! ActivateColorScheme()
 set background=dark
 colorscheme deus
 hi! link SignColumn LineNr
 hi! VertSplit guibg=#242a32
 hi! StatusLine guifg=#242a32 guibg=#ebdab2
 hi! StatusLineNC guifg=#242a32 guibg=#ebdab2
 hi! CursorLineNr guibg=#242a32 guifg=#ebdab2

 hi! SignColumn guibg=#242a32
 hi! SignifySignAdd guibg=#242a32 guifg=#99c379
 hi! SignifySignDelete guibg=#242a32 guifg=#fb4733
 hi! SignifySignChange guibg=#242a32 guifg=#8ec07b

 hi! AleWarningSign guibg=#242a32 guifg=#ebdab2

 hi! CursorLine guibg=#292f37
 hi! ColorColumn guibg=#292f37
 hi! link WhiteSpace AleErrorSign
 hi! link QuickFixLine DiffText
endfunction
