"                                            _
"  _____ _____   _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___   _____ _____
" |_____|_____| | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __| |_____|_____|
" |_____|_____| | | | | | | (_| | |_) | |_) | | | | | (_| \__ \ |_____|_____|
"               |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                               |_|   |_|            |___/


" unmap the arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

"use up and dow arrow to move line
noremap <up> ddkP
noremap <down> ddp

" Fix annoying typo's of WQ, QA and Q
command! WQ wq
command! Wq wq

command! W w
command! Q q

command! QA qa
command! Qa qa

" Execute macro under key `a` for alle buffers and write afterwards
command! Bufmacro bufdo execute "normal @a" | write

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Code folding options
nnoremap <leader>f0 :set foldlevel=0<CR>
nnoremap <leader>f1 :set foldlevel=1<CR>
nnoremap <leader>f2 :set foldlevel=2<CR>
nnoremap <leader>f3 :set foldlevel=3<CR>
nnoremap <leader>f4 :set foldlevel=4<CR>
nnoremap <leader>f5 :set foldlevel=5<CR>
nnoremap <leader>f6 :set foldlevel=6<CR>
nnoremap <leader>f7 :set foldlevel=7<CR>
nnoremap <leader>f8 :set foldlevel=8<CR>
nnoremap <leader>f9 :set foldlevel=9<CR>

"Spelling mapping
inoremap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" tabpage mappings
noremap <Leader>tn :tabnext<CR>

noremap <Leader>t :tabnew<CR>

" session mappings
noremap <leader>m :call WriteSession()<CR>
noremap <leader>cm :!rm -f ~/.vim/session/*.*<CR>

"custom comma motion mapping
nnoremap di, f,dT,
nnoremap ci, f,cT,
nnoremap da, f,ld2F,i,<ESC>l "delete argument
nnoremap ca, f,ld7F,i,<ESC>a "delete arg and insert

"Replace mappings
nnoremap <leader>rl 0:s/
nnoremap <leader>rp {ma}mb:'a,'bs/

" upper or lowercase the current word
nnoremap g^ gUiW
nnoremap gv guiW

" default to very magic
no / /\v

" gO to create a new line below cursor in normal mode
nnoremap go o<ESC>k
" go to create a new line above cursor
nnoremap gO O<ESC>j

"I really hate that things don't auto-center
nnoremap G Gzz
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz

"open tag in new tab with <C-\>
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"retab everything with <leader>rt
noremap <leader>rt :set expandtab<CR>:retab<CR>

" Make Y behave like other capital commands.
" Hat-tip http://vimbits.com/bits/11
nnoremap Y y$

" Go to beginning and end of lines easier. From http://vimbits.com/bits/16
noremap H ^
noremap L $

" Use ; for : in normal and visual mode, less keystrokes
nnoremap ; :
vnoremap ; :

" Open vimrc with leader->v
nnoremap <leader>v  :vsplit $MYVIMRC<CR>
nnoremap <leader>gv  :vsplit $MYGVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" Rename current file with <leader>n
noremap <leader>n :call RenameFile()<CR>

" Toggle highlight search with <leader>hl
nnoremap <leader>hl :set hlsearch!<CR>

" close buffer with leader-q
" and safe & close buffer with leader-wq
nnoremap <leader>q :bd<CR>
nnoremap <leader>wq :w<CR>:bd<CR>
