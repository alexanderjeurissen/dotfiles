" Snippets from vim-help
" Credits:
" - https://github.com/dahu/vim-help
" - https://github.com/rafi/vim-config/blob/master/ftplugin/help.vim

setlocal nospell

setlocal nohidden
setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-

" Jump to links with o
nmap <buffer> o <C-]>

" Jump back with H
" nmap <buffer> H <C-T>
