scriptencoding utf-8

" KEYBINDINGS: General {{{
  " Use <space> as leader
  let mapleader="\<Space>"

  " Fix annoying typo's of WQ, QA and Q, and report
  cnoreabbrev qw wq
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
  cnoreabbrev QA qa
  cnoreabbrev Qa qa
  cnoreabbrev W w
  cnoreabbrev WW w
  cnoreabbrev Q q

  inoreabbr <buffer> reprot report
  inoreabbr <buffer> Reprot Report

  " Open highlighted text with default program
  " vnoremap o :call general#ExecVisualSelection()<cr>

  " NOTE: show the highlight group under the cursor  ighl
  nnoremap <leader>toh :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>"
" }}}

" KEYBINDINGS: Editing {{{
  " Macro related mappings
  command! Bufmacro bufdo execute "normal @a" | write
  command! Cmacro cdo execute "normal@a" | write
" }}}

" KEYBINDINGS: File manipulation {{{
  " Save
  noremap <leader>fs :w<CR>

  " Open vimrc with <leader>fed
  nnoremap <leader>fed  :e $MYVIMRC<CR>
  nnoremap <leader>feR  :luafile $MYVIMRC<CR>

  " Rename current file with <leader>fr
  noremap <leader>fr :lua require('general').rename_file()<CR>

  " Get a vimdiff of all approvals
  map <leader>v :!approvals verify -d vimdiff -a<cr>

  "w!! to save file with sudo
  cmap w!! w !sudo tee % > /dev/null

  " This copies current file path + line number to system clipboard
  " source: https://stackoverflow.com/questions/17498144/yank-file-path-with-line-no-from-vim-to-system-clipboard
  nmap <leader>fC :let @+=expand("%") . ':' . line(".")<CR>

  " cd to the directory of the current buffer
  map <Leader>cd :lcd %:p:h<CR>:pwd<CR>
" }}}

" KEYBINDINGS: terminal {{{
  " NOTE: when trying to do movement commands using C-w
  " auto escape out of term mode
  tnoremap <C-w> <C-\><C-n><C-w>

  tnoremap <leader><ESC> <C-\><C-n>

  tnoremap <silent> <c-h> <C-\><C-n><C-w><left>
  tnoremap <silent> <c-j> <C-\><C-n><C-w><down>
  tnoremap <silent> <c-k> <C-\><C-n><C-w><up>
  tnoremap <silent> <c-l> <C-\><C-n><C-w><right>
  tnoremap <silent> <c-\> <C-\><C-n><C-w><w>
" }}}

" vim: foldmethod=marker:sw=2:foldlevel=10
