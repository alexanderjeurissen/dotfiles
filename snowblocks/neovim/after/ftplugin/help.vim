" Snippets from vim-help
" Credits:
" - https://github.com/dahu/vim-help
" - https://github.com/rafi/vim-config/blob/master/ftplugin/help.vim

setlocal nospell

setlocal nohidden
setlocal iskeyword+=:
setlocal iskeyword+=#
setlocal iskeyword+=-
setlocal nocursorline
setlocal nocursorcolumn
call general#MarkMargin(0)

" Jump to links with o
nmap <buffer> o <C-]>

" Jump back with H
nmap <buffer> H <C-T>

" Maximize help buffer to a separate tab
" execute "normal \<C-W>T"
" setlocal hidden
" call general#FloatingWindow(bufnr('%'))
" set hidden
" NOTE: change highlighting of help to distinguish it from regular buffers
" setlocal winhl=Normal:HelpNormal
