" Snippets from vim-qf
" Credits: https://github.com/romainl/vim-qf

nnoremap <silent><buffer> p  :call <SID>preview_file()<CR>
nnoremap <silent><buffer> q  :pclose!<CR>:quit<CR>
nnoremap <buffer> o  <CR><C-w>p
nnoremap <buffer> o  <CR><C-w>p

let b:qf_isLoc = ! empty(getloclist(0))
if b:qf_isLoc == 1
  nnoremap <buffer> O <CR>:lclose<CR>
else
  nnoremap <buffer> O <CR>:cclose<CR>
endif

function! s:preview_file()
  let winwidth = &columns
  let cur_list = b:qf_isLoc == 1 ? getloclist('.') : getqflist()
  let cur_line = getline(line('.'))
  let cur_file = fnameescape(substitute(cur_line, '|.*$', '', ''))
  if cur_line =~# '|\d\+'
    let cur_pos  = substitute(cur_line, '^\(.\{-}|\)\(\d\+\)\(.*\)', '\2', '')
    execute 'vertical pedit! +'.cur_pos.' '.cur_file
  else
    execute 'vertical pedit! '.cur_file
  endif
  wincmd P
  execute 'vert resize '.(winwidth / 2)
  wincmd p
endfunction

call general#MarkMargin(0)
autocmd BufEnter qf :call general#MarkMargin(0)
