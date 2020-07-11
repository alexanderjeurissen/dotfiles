scriptencoding utf-8
  let g:python_host_prog="python3"

" SETTINGS: Dein.vim {{{
  "Note: install dein if not present
  let g:dein_path='$HOME/.config/nvim/dein'
  let g:dein#auto_recache=1

  if !filereadable(expand(g:dein_path) . '/repos/github.com/Shougo/dein.vim/README.md')
   if executable('git')
     exec '!git clone https://github.com/Shougo/dein.vim ' . g:dein_path . '/repos/github.com/Shougo/dein.vim'
   else
     echohl WarningMsg | echom 'You need install git!' | echohl None
   endif

   autocmd VimEnter * source $MYVIMRC
  endif

  " Add dein.vim to runtimepath
  set runtimepath^=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim


let s:plugin_path='$HOME/.config/nvim/dein'
let s:dein_toml='$HOME/.config/nvim/plugin/dein.toml'

  if dein#load_state(expand(s:plugin_path))
   " tell dein where the plugins live
   call dein#begin(
         \ expand(s:plugin_path),
         \ expand(s:dein_toml),
         \ [expand('$HOME/.config/nvim/init.vim')]
         \)

   call dein#load_toml(s:dein_toml)

   call dein#end()
   call dein#call_hook('source') " call hooks of non lazy plugins
   call dein#save_state() " Save dein state (cache)
  endif

  filetype plugin indent on

  if dein#check_install()
    " Installation check.
    let g:dein#types#git#default_protocol = 'ssh'
    call dein#install() " install plugins that aren't installed yet
    call dein#remote_plugins() " Install remote plugins
    call dein#check_lazy_plugins() " check for lazy plugins that don't have /plugin

    call map(dein#check_clean(), "delete(v:val, 'rf')") " remove unused plugins
  endif

  " Execute post_source hooks after plugins are sourced
  autocmd VimEnter * call dein#call_hook('post_source')
" }}}

" SETTINGS: statusline {{{
  set laststatus=2
  set guioptions-=e

  set statusline=%!statusline#Init()
" }}}

" SETTINGS: Colorscheme {{{
  if (has('termguicolors'))
    " NOTE: temp disabled for iterm tmux integration
    " set t_8f=^[[38;2;%lu;%lu;%lum
    " set t_8b=^[[48;2;%lu;%lu;%lum

    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

    set t_Cs =^[[6m"
    set t_Ce =^[[24m"
    let &t_Cs = "\e[6m"
    let &t_Ce = "\e[24m"

    set termguicolors
  endif
" }}}

" SETTINGS: Navigation {{{
  if executable('rg')
    set grepprg=rg\ -H\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif

  " NOTE: This makes it so that gx opens the url under cursor
  " in Google Chrome
  let g:netrw_browsex_viewer = "open -a '/Applications/Firefox Developer Edition.app'"
  let g:netrw_keepdir=0
" }}}

" SETTINGS: DiffMode {{{
  if &diff
    set nolist
    set nocursorcolumn
    set nocursorline
    set conceallevel=0
    set colorcolumn=0

    call general#MarkMargin(0)
  endif
" }}}

" KEYBINDINGS: General {{{
  " Use <space> as leader
  let mapleader="\<Space>"
  let g:mapleader="\<Space>"
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

  " session mappings
  noremap <leader>m :call general#WriteSession()<CR>

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
  nnoremap gb :Buffers<CR>

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
  command! -complete=help -nargs=? Help call general#FloatingWindowHelp(<q-args>)
  cnoremap help Help
  cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'Help' : 'h'
  " cnoremap h Help
" }}}

" KEYBINDINGS: File manipulation {{{
  " Save
  noremap <leader>fs :w<CR>

  " Open vimrc with <leader>fed
  nnoremap <leader>fed  :e $MYVIMRC<CR>
  nnoremap <leader>feR  :source $MYVIMRC<CR>

  " Rename current file with <leader>fr
  noremap <leader>fr :call general#RenameFile()<CR>

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

" AUTOCMD: Autocmd groups  {{{
  augroup ALEXANDER_GENERAL " {{{
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    " In addition open folds till the cursor is visible
    autocmd BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute "normal g`\"" |
          \   execute "normal zv" |
          \ endif

    " Disable linting and syntax highlighting for large files
    autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   let g:ale_enabled=0 |
                \   endif

    " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
    autocmd Syntax * if 2000 < line('$') | syntax sync maxlines=200 | endif

    " Automatically remove fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile Appraisals setlocal filetype=ruby

    " Add html highlighting when editing rails views & handlebar templates
    autocmd BufRead,BufNewFile *.html setlocal filetype=html.javascript
    autocmd BufRead,BufNewFile *.erb setlocal filetype=eruby.html
    autocmd BufRead,BufNewFile *.arb setlocal filetype=ruby
    autocmd BufRead,BufNewFile *.hbs setlocal filetype=handlebars.html

    " Automatically remove trailing whitespaces unless file is blacklisted
    autocmd BufWritePre *.* :call general#Preserve("%s/\\s\\+$//e")

    " Update filetype on save if empty
    autocmd BufWritePost * nested
      \ if &l:filetype ==# '' || exists('b:ftdetect')
      \ |   unlet! b:ftdetect
      \ |   filetype detect
      \ | endif

    " NOTE: Ensure directory structure exists when opening a new file
    autocmd  BufNewFile  *  :lua require('general').EnsureDirExists()

    " let terminal resize scale the internal windows
    autocmd VimResized * :wincmd =

    " autocmd TermOpen,TermEnter * :call terminal#Init()
    " autocmd TermLeave * :call terminal#Cleanup()

    " Start in terminal
    " autocmd VimEnter *
    "       \ if v:vim_did_enter |
    "       \ exec ':terminal' |
    "       \ exec ':startinsert' |
    "       \ endif

  augroup END " }}}

  " NOTE: reload init.vim when saving it to disk
  augroup ALEXANDER_VIMRC_RELOAD " {{{
    autocmd!
    autocmd BufWritePost init.vim source %
  augroup END " }}}

  " NOTE: open quickfix window after vim grep
  " ref: https://www.reddit.com/r/vim/comments/bmh977/automatically_open_quickfix_window_after/
  augroup quickfix
      autocmd!
      autocmd QuickFixCmdPost [^l]* cwindow
      autocmd QuickFixCmdPost l* lwindow
  augroup END

" EXTRA: Include lua config {{{
  if filereadable(expand('~/.config/nvim/lua/init.lua'))
    lua require('init').init()
  endif
" }}}


" vim: foldmethod=marker:sw=2:foldlevel=10
