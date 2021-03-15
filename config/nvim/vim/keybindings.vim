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
  vnoremap o :call general#ExecVisualSelection()<cr>

  " NOTE: show the highlight group under the cursor  ighl
  nnoremap <leader>toh :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>"
" }}}

" KEYBINDINGS: Editing {{{
  " Macro related mappings
  command! Bufmacro bufdo execute "normal @a" | write
  command! Cmacro cdo execute "normal@a" | write
  xnoremap @ :<C-u>call general#ExecuteMacroOverVisualRange()<CR>

  " Move visual block
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  " custom comma motion mapping
  nnoremap di, f,dT,
  nnoremap ci, f,cT,
  "delete argument
  nnoremap da, f,ld2F,i,<ESC>l
  "delete arg and insert
  nnoremap ca, f,ld7F,i,<ESC>a

  "FIXME: Replace mappings
  nnoremap <leader>rp {ma}mb:'a,'bs/

  " (upper|lower)case word under cursor
  nnoremap g^ gUiW
  nnoremap gv guiW

  " Create newline before/after current row
  nnoremap go o<ESC>k
  nnoremap gO O<ESC>j

  " Paste and keep pasting same thing, don't take what was removed
  vnoremap <Leader>p "_dP

  " Make Y behave like other capital commands.
  " Hat-tip http://vimbits.com/bits/11
  nnoremap Y y$

  " keep selection after indent
  vnoremap < <gv
  vnoremap > >gv
" }}}

" KEYBINDINGS: Navigation/search {{{
  " Go to previous and next item in quickfix list
  noremap <leader>cw :cwindow<CR><C-w>J
  noremap <leader>cq <C-w><C-p>:cclose<CR>
  noremap <leader>cn :cnext<CR>
  noremap <leader>cN :cnfile<CR>
  noremap <leader>cp :cprev<CR>
  noremap <leader>cP :cpfile<CR>

  noremap <leader>ln :lnext<CR>
  noremap <leader>lN :lnfile<CR>
  noremap <leader>lp :lprev<CR>
  noremap <leader>lP :lpfile<CR>

  " Split creation
  noremap <silent> <leader>wv <C-w>v
  noremap <silent> <leader>ws <C-w>s

  " Split resizing
  nmap <left> <C-w>5<
  nmap <up> <C-w>5+
  nmap <down> <C-w>5-
  nmap <right> <C-w>5>

  " Split navigation
  noremap <silent> <c-h> <C-w><left>
  noremap <silent> <c-j> <C-w><down>
  noremap <silent> <c-k> <C-w><up>
  noremap <silent> <c-l> <C-w><right>
  noremap <silent> <c-\> <C-w><w>

  " NOTE: disable arrows and BS in insert mode
  imap <left> <nop>
  imap <up> <nop>
  imap <down> <nop>
  imap <right> <nop>
  imap <BS> <nop>
  imap <DEL> <nop>

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  " Find merge conflict markers
  noremap <leader>gm /\v^[<\|=>]{7}( .*\|$)<CR>

  " default to very magic
  noremap / /\v
  noremap ? ?\v

" bind <leader>/ to grep
  nmap <leader>/ :grep -F ""<LEFT>

" bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>

  " Repurpose the s and S key for search and replace
  nmap S  :%s//g<LEFT><LEFT>
  vmap s  :Blockwise s//g<LEFT><LEFT>

  " Repurpose the H and L keys to quickly switch buffers
  nnoremap H :bp<CR>
  nnoremap L :bn<CR>

  " Rebind the old H and L keyt to zh, zl
  nnoremap zh H
  nnoremap zm M
  nnoremap zl L

  " Create some additional fold movements
  " nnoremap zn :normal zj<CR>:normal za<CR>:normal zt<CR>

  nnoremap zN :normal zC<CR>/^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>
  nnoremap zP :normal zC<CR>?^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>

  nnoremap zn :normal zc<CR>/^@@<CR>:nohl<CR>:normal zv<CR>:normal zt<CR>
  nnoremap zp :normal zc<CR>?^@@<CR>:nohl<CR>:normal zv<CR>:normal zb<CR>

  nnoremap zgg :normal 100000000zk<CR>
  nnoremap zG :normal  100000000zj<CR>

  " auto-center on specific movement keys, and blink current search match
  nnoremap G Gzz
  nnoremap n nzz:call general#HLNext(0.1)<cr>
  nnoremap N Nzz:call general#HLNext(0.1)<cr>
  nnoremap } }zz
  nnoremap { {zz

  " NOTE: overload :help and :h to open in a floating window
  " command! -complete=help -nargs=? Help call general#FloatingWindowHelp(<q-args>)
  " cnoremap help Help
  " cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'Help' : 'h'
  " cnoremap h Help
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
  nnoremap <leader>fC :let @+=expand("%") . ':' . line(".")<CR>

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
