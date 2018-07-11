scriptencoding utf-8

" SETTINGS: General {{{
  set packpath+=$VIM_CONFIG_PATH                     " Make sure pack installs in the right dir
  set path=$PWD,$PWD/app/**                          " Make :find more usable by default
  set wildmenu                                       " Show all matches when tab completing
  set wildmode=longest:list,full                     " Show longest match first
  set regexpengine=1                                 " Better for ruby (https://tinyurl.com/ll948jk)
  set noswapfile                                     " Disable swap (https://tinyurl.com/y9t8frrs)
  set showmode                                       " show mode in bottom-left corner
  set synmaxcol=200                                  " Only syntax highlight 200 chars (performance)
  set autowrite                                      " Write before running commands.
  set shortmess=aAIsT                                " Reduce |hit-enter| prompts.
  set cmdheight=2                                    " Number of screen lines for the command-line.
  set nowrap                                         " Don't wrap lines as it makes j/k unintuitive.
  set smartcase                                      " Search case incensitive.
  " FIXME: temp disabled to test out Conway's cc approach to text width
  " set textwidth=100                                  " Set maximum number of characters per line
  set sessionoptions+=resize                         " Changes the effect of the |:mksession| cmd.
  set sessionoptions+=globals                        " Persist global variables in vim session
  " set colorcolumn=+1                               " Highlight first column after 'textwidth'
  " set iskeyword-=_                                 " Treat underscore as a word boundary.

  set nolist
  set listchars=tab:▸\ ,trail:-,extends:>,precedes:<,space:·,eol:¬ " Strings in 'list' mode.
  set fillchars=vert:\                               " Strings in statuslines and vert separators.

  set hidden                                         " Allow for more then one unsaved buffer.
  set nolazyredraw                                   " Disable lazy redraw due to issues neovim#6366
  " set lazyredraw                                   " Don't unnecessarily redraw screen.

  set undofile                                       " Save undo's after file closes.
  set undodir=$HOME/.config/nvim/undo/               " Location of Undo files.
  set undolevels=1000                                " Number of changes to be saved.
  set undoreload=10000                               " Save whole buffer to undohist when reloading.

  set tabstop=2                                      " Number of spaces a <Tab> char is rendered as.
  set shiftwidth=2                                   " Number of spaces that >> and << count for.
  set softtabstop=2                                  " Number of spaces of <Tab> while editing.
  set expandtab                                      " Use spaces instead of <Tab> for indentation.
  set number                                         " Enable line numbers
  set relativenumber                                 " Make line numbers relative
  set numberwidth=4                                  " Set width of number column
  set splitbelow                                     " Open new split panes at bottommost position
  set splitright                                     " Open new split panes at rightmost position
  set inccommand=nosplit                             " Show visual indication when using substitute.
  set nofoldenable                                   " collapse all folds.
  set foldmethod=syntax                              " Fold on the syntax
  set foldcolumn=0                                   " Don't indicate fold open/closed
  set foldlevel=1                                    " Autofold nothing by default
  set foldnestmax=3                                  " Only fold outer functions

  set modeline                                       " load vim settings from magic file comment
  set confirm                                        " Makes operations like qa ask for confirmation
  set t_vb=                                          " Disable visual bell.
  set scrolloff=2                                    " Keep at least 2 lines above/below
  set sidescrolloff=5                                " Keep at least 5 lines left/right
  set smartindent

  " FIXME temp disabling this to test tabnew help
  " Open help in a new split instead of vimbuffer
  " cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'rightbelow help' : 'h'

  let python3_host_prog = "python3"
  let python_host_prog = "python"
  let g:snappy_dev = 1
  " let g:lumiere_low_contrast_mode = 1
" }}}

" SETTINGS: statusline {{{
  set laststatus=2
  set guioptions-=e

  set statusline=%!statusline#Init()
" }}}

" SETTINGS: Colorscheme {{{
  if (has('termguicolors'))
    set termguicolors
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum
    set t_Cs =^[[6m"
    set t_Ce =^[[24m"
    let &t_Cs = "\e[6m"
    let &t_Ce = "\e[24m"
  endif

  function! ActivateColorScheme()
    colorscheme default " fallback incase no colorscheme plugin is installed
  endfunction
" }}}

" SETTINGS: Navigation {{{
  if executable('rg')
    set grepprg=rg\ -H\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif

  " NOTE: This makes it so that gx opens the url under cursor
  " in Google Chrome
  let g:netrw_browsex_viewer = "open -a '/Applications/Google Chrome.app'"
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

  " Fix annoying typo's of WQ, QA and Q
  cnoreabbrev qw wq
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
  cnoreabbrev QA qa
  cnoreabbrev Qa qa
  cnoreabbrev W w
  cnoreabbrev WW w
  cnoreabbrev Q q

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
  nnoremap <leader>/ :grep -F ""<LEFT>

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
    autocmd  BufNewFile  *  :call general#EnsureDirExists()

    " NOTE: Makes sure we don't end up with double completions
    autocmd CompleteDone * :call general#UndoubleCompletions()

    " let terminal resize scale the internal windows
    autocmd VimResized * :wincmd =

    " Set colorscheme if vim is loaded
    autocmd VimEnter * call ActivateColorScheme()

    autocmd User FzfStatusLine call fzf#Statusline()
  augroup END " }}}

  augroup ALEXANDER_TERM " {{{
    autocmd!
    " NOTE: set some terminal buffer local overrrides
    " such as no number, no relative number, no cursorline etc.
    autocmd TermOpen * call terminal#Settings()

    " NOTE: leave and start insertmode when entering/leaving term buf
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  augroup END " }}}

  " NOTE: reload init.vim when saving it to disk
  augroup ALEXANDER_VIMRC_RELOAD " {{{
    autocmd!
    autocmd BufWritePost init.vim source %
  augroup END " }}}

  " NOTE: copied from Damian Conway's vimrc
  " SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
  augroup ALEXANDER_COLOR_COLUMN " {{{
    autocmd!
    autocmd  BufEnter * :call general#MarkMargin(1)
  augroup END " }}}

  "FIXME: temporarily disabled as it's quite intrusive
  augroup ALEXANDER_ALE_BG "{{{
    autocmd!
    autocmd User ALELintPost call general#ErrorMode()
    autocmd User ALEFixPost call general#ErrorMode()
  augroup END
  ""}}}

" }}}

" EXTRA: Include local vim config {{{
  if filereadable(expand('~/.nvimrc.local'))
    source ~/.nvimrc.local
  endif
" }}}
" vim: foldmethod=marker:sw=2:foldlevel=10
