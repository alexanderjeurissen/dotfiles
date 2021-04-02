hi! NormalFloat ctermbg=8

hi  CurrentSearchMatch ctermbg=1
hi! Normal ctermfg=12  ctermbg=0
hi! rubyDefine cterm=bold ctermbg=NONE ctermfg=14

hi! IdoCursor         ctermfg=8 ctermbg=12 guifg=#002b36 guibg=#839496
hi! IdoSelected       cterm=bold,undercurl ctermfg=3 guifg=#b58900
hi! IdoPrefix         cterm=standout ctermfg=3 guifg=#b58900
hi! IdoUXElements     cterm=bold ctermfg=7 guifg=#eee8d5
hi! IdoPrompt         ctermfg=4 guifg=#268bd2
hi! IdoWindow         ctermbg=0 guibg=#073642

hi! link LspDiagnosticsSignError Error
hi! link LspDiagnosticsSignWarning WarningMsg
hi! link LspDiagnosticsSignInformation MoreMsg
hi! link LspDiagnosticsSignHint Question

hi! MsgArea ctermbg=8 ctermfg=3

hi! netrwSymLink  ctermfg=5 guifg=#d33682
hi! StatusLine cterm=reverse ctermfg=8 ctermbg=12
hi! StatusLineNC cterm=reverse ctermfg=8 ctermbg=10
hi! VertSplit ctermfg=8 ctermbg=8

" Set Alacritty theme accordingly
call system("sed -i.bak 's/\*light/*dark/g' ~/.dotfiles/config/alacritty/alacritty.yml")

" Set tmux colors accordingly
call system("tmux set -g status-style bg='brightblack',fg='brightgreen'")
call system("tmux set -g window-status-current-style fg='brightblue, bold'")

call system("tmux set -g pane-border-style fg='black',bg='black'")
call system("tmux set -g pane-active-border-style fg='black',bg='black'")
