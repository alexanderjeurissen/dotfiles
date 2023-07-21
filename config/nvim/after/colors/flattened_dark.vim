hi! NormalFloat ctermbg=8

hi  CurrentSearchMatch ctermbg=1
hi! Normal ctermfg=12  ctermbg=0
hi! rubyDefine cterm=bold ctermbg=NONE ctermfg=14

hi! link LspDiagnosticsSignError Error
hi! link LspDiagnosticsSignWarning WarningMsg
hi! link LspDiagnosticsSignInformation MoreMsg
hi! link LspDiagnosticsSignHint Question

hi! netrwSymLink  ctermfg=5 guifg=#d33682

hi! MsgArea ctermbg=0 ctermfg=3
hi! StatusLine ctermfg=0 ctermbg=0
hi! StatusLineNC ctermfg=0 ctermbg=0
hi! winbar cterm=none ctermbg=8 ctermfg=10
hi! VertSplit ctermfg=8 ctermbg=0

hi! cursorline ctermbg=8
hi! cursorcolumn ctermbg=8
hi! cursor cterm=reverse gui=reverse guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE

" Set Alacritty theme accordingly
call system("sed -i.bak 's/\*solarized_light/*solarized_dark/g' ~/.dotfiles/config/alacritty/alacritty.yml")

" Set tmux colors accordingly
call system("tmux set -g status-style bg='brightblack',fg='brightgreen'")
call system("tmux set -g window-status-current-style fg='brightblue, bold'")

call system("tmux set -g pane-border-style fg='black',bg='black'")
call system("tmux set -g pane-active-border-style fg='black',bg='black'")
