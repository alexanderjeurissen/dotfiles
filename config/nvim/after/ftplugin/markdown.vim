" Spell related settings
setlocal spell
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal complete+=kspell

imap <buffer><c-l> <Esc>[s1z=`]a

" Disable marking of margin (colorcolumn)
call general#MarkMargin(0)

" Allow for folding markdown headings
let g:markdown_folding = 1
