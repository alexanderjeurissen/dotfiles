" hi! NormalFloat ctermbg=7

hi  CurrentSearchMatch ctermbg=1
hi! rubyDefine cterm=bold ctermbg=NONE ctermfg=8

hi! link LspDiagnosticsSignError Error
hi! link LspDiagnosticsSignWarning WarningMsg
hi! link LspDiagnosticsSignInformation MoreMsg
hi! link LspDiagnosticsSignHint Question

hi! netrwSymLink  ctermfg=5 guifg=#d33682

hi! MsgArea ctermbg=NONE ctermfg=5

" hi! clear StatusLine
hi! StatusLine ctermfg=14 ctermbg=7 guifg=#93a1a1 guibg=#eee8d5
hi! StatusLineNC cterm=reverse ctermfg=7 ctermbg=14 gui=reverse guifg=#eee8d5 guibg=#93a1a1
hi! StatusFiller ctermfg=14 ctermbg=7 guifg=#93a1a1 guibg=#eee8d5

hi! StatusSegment cterm=reverse ctermfg=0 ctermbg=7 gui=reverse guifg=#073642 guibg=#eee8d5
hi! StatusArrow ctermfg=0 ctermbg=7 guifg=#073642 guibg=#eee8d5

hi! VertSplit ctermfg=NONE ctermbg=NONE

hi! cursor cterm=reverse gui=reverse guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
" Set Alacritty theme accordingly
call system("sed -i.bak 's/\*solarized_dark/*solarized_light/g' ~/.dotfiles/config/alacritty/alacritty.yml")
