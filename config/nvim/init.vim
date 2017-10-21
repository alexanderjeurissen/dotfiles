" SETTINGS: General {{{
  set re=1                                           " Better for ruby (https://tinyurl.com/ll948jk)
  set noswapfile                                     " Disable swapfile (https://tinyurl.com/y9t8frrs)
  set noshowmode                                     " No to showing mode in bottom-left corner
  set synmaxcol=200                                  " Only syntax highlight 200 chars (performance)
  set autowrite                                      " Write before running commands.
  set shortmess=aAIsT                                " Reduce |hit-enter| prompts.
  set cmdheight=2                                    " Number of screen lines for the command-line.
  set nowrap                                         " Don't wrap lines as it makes j/k unintuitive.
  set smartcase                                      " Search case incensitive.
  set textwidth=100                                  " Set maximum number of characters per line
  set sessionoptions+=resize                         " Changes the effect of the |:mksession| command.
  set completeopt=menu                               " Use popup menu for insert mode completion
  set cc=+1,+2                                       " Highlight first 2 columns after 'textwidth'
  set iskeyword-=_                                   " Treat underscore as a word boundary.

  set list                                           " TODO: not sure why this is required.
  set listchars=tab:▸\ ,trail:-,extends:>,precedes:< " Strings in 'list' mode.
  set fillchars=vert:¦                               " Strings in statuslines and vert separators.

  set hid                                            " Allow for more then one unsaved buffer.
  set nolazyredraw                                   " Disable lazy redraw due to issues neovim#6366
  " set lazyredraw                                   " Don't unnecessarily redraw screen.

  set undofile                                       " Save undo's after file closes.
  set undodir=$HOME/.config/nvim/undo/               " Location of Undo files.
  set undolevels=1000                                " Number of changes to be saved.
  set undoreload=10000                               " Save whole buffer to undohist when reloading.

  set tabstop=2                                      " Number of spaces existing <Tab> is rendered as.
  set shiftwidth=2                                   " Number of spaces that >> and << count for.
  set softtabstop=2                                  " Number of spaces of <Tab> while editing.
  set expandtab                                      " Use spaces instead of <Tab> for indentation.
  set number                                         " Enable line numbers
  set relativenumber                                 " Make line numbers relative
  set numberwidth=5                                  " Set width of number column
  set splitbelow                                     " Open new split panes at bottommost position
  set splitright                                     " Open new split panes at rightmost position
  set inccommand=split                               " Show visual indication when using substitute.
  set nofoldenable                                   " collapse all folds.

  set confirm                                        " Makes operations like qa ask for confirmation.
  set t_vb=                                          " Disable visual bell.

  " Open help in a new split instead of vimbuffer
  cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'rightbelow help' : 'h'

  " Use <space> as leader
  let mapleader="\<Space>"
  let g:mapleader="\<Space>"

  let python3_host_prog = "python3"
  let python_host_prog = "python"

  if (has("termguicolors"))
    set termguicolors
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum
  endif
" }}}


" SETTINGS: statusline {{{
  set laststatus=2
  set guioptions-=e

  " additional symbols:
  "Ξ Whitespace
  "☰ max line number
  "∄ not exist
  "¶ line numberz
  "␤ line number r2

  set statusline=
  let &statusline = " %{winnr()}"
  let &statusline .= " %<%f"
  let &statusline .= "%{&readonly ? '  ' : &modified ? '  ' : ''}"
  let &statusline .= "%{status_line#PasteFlag()}"
  let &statusline .= "%{status_line#SpellFlag()}"
  " let &statusline .= \"%{status_line#HardTimeFlag()}"
  let &statusline .= "%=%{&filetype == '' ? 'unknown' : &filetype}"
  let &statusline .= " %2c "
" }}}


" SETTINGS: terminal {{{
  tnoremap <leader><ESC> <C-\><C-n>
" }}}


" KEYBINDINGS: General {{{
  " Fix annoying typo's of WQ, QA and Q
  command! WQ wq
  command! Wq wq

  command! W w
  command! WW w

  command! Q q

  command! QA qall
  command! Qa qall

  " Safely exit neovim
  noremap <C-q> :confirm qall<CR>

  "w!! to save file with sudo
  cmap w!! w !sudo tee % > /dev/null

  " Execute macro under key `a` for all buffers and write afterwards
  command! Bufmacro bufdo execute "normal @a" | write
  command! Cmacro cdo execute "normal@a" | write

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  " Move visual block
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  " Find merge conflict markers
  noremap <leader>gm /\v^[<\|=>]{7}( .*\|$)<CR>

  " Spelling mapping
  " imap <c-c> <c-g>u<Esc>[s1z=`]a<c-g>u

  " tabpage mappings
  noremap <Leader>t :tabnew<CR>
  noremap <Leader>tn :tabnext<CR>

  " session mappings
  noremap <leader>m :call general#WriteSession()<CR>

  " custom comma motion mapping {{{
    nnoremap di, f,dT,
    nnoremap ci, f,cT,
    nnoremap da, f,ld2F,i,<ESC>l "delete argument
    nnoremap ca, f,ld7F,i,<ESC>a "delete arg and insert
  " }}}

  "FIXME: Replace mappings
  nnoremap <leader>rl 0:s/
  nnoremap <leader>rp {ma}mb:'a,'bs/

  " upper or lowercase the current word
  nnoremap g^ gUiW
  nnoremap gv guiW

  " default to very magic
  no / /\v
  no ? ?\v

  " gO to create a new line below cursor in normal mode
  nnoremap go o<ESC>k

  " go to create a new line above cursor
  nnoremap gO O<ESC>j

  " I really hate that things don't auto-center {{{
    nnoremap G Gzz
    nnoremap n nzz
    nnoremap N Nzz
    nnoremap } }zz
    nnoremap { {zz
  " }}}

  " open tag in new tab with <C-\>
  noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

  " Make Y behave like other capital commands.
  " Hat-tip http://vimbits.com/bits/11
  nnoremap Y y$

  " Toggle highlight search with <leader>thl
  nnoremap <leader>thl :set hlsearch!<CR>

  " Toggle relative line number
  nnoremap <leader>trn :set relativenumber!<CR>

  " Toggle cursor column
  nnoremap <leader>tcc :set cursorcolumn!<CR>

  " Toggle cursor line
  nnoremap <leader>tcl :set cursorline!<CR>

  " close buffer with leader-q
  " and safe & close buffer with leader-wq
  nnoremap <leader>q :Bdelete<CR>
  nnoremap <leader>wq :w<CR>:bd<CR>

  " Paste and keep pasting same thing, don't take what was removed
  vnoremap <Leader>p "_dP

  " keep selection after indent
  vnoremap < <gv
  vnoremap > >gv

  " Go to previous and next item in quickfix list
  noremap <leader>cn :cnext<CR>
  noremap <leader>cp :cprev<CR>

  " window resizing
  nmap <left> <C-w>5<
  nmap <up> <C-w>5+
  nmap <down> <C-w>5-
  nmap <right> <C-w>5>

  " Open highlighted text with default program
  vnoremap o :call general#ExecVisualSelection()<cr>
" }}}


" KEYBINDINGS: File {{{
  " Save
  noremap <leader>fs :w<CR>

  " Open vimrc with <leader>fed
  nnoremap <leader>fed  :e $MYVIMRC<CR>
  nnoremap <leader>feR :source $MYVIMRC<CR>

  " Rename current file with <leader>fr
  noremap <leader>fr :call general#RenameFile()<CR>

  " Get a vimdiff of all approvals
  map <leader>v :!approvals verify -d vimdiff -a<cr>

  " Get a vimdiff of structure.sql compared to develop
  nnoremap <leader>db :!git diff develop -- db/structure.sql -d vimdiff -a<cr>
" }}}


" AUTOCMD: General {{{
  augroup ALEXANDER_GENERAL
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

    " Disable linting and syntax highlighting for large files
    autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   endif

    " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
    autocmd BufEnter * :syntax sync maxlines=200

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile Appraisals set filetype=ruby
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    " Add html highlighting when editing rails views & handlebar templates
    autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
    autocmd BufRead,BufNewFile *.hbs set filetype=handlebars.html

    " Add javascript highlighting when embeded in HTML file
    autocmd BufRead,BufNewFile *.html set filetype=html.javascript

    " Automatically remove trailing whitespaces unless file is blacklisted
    autocmd BufWritePre *.* :call general#Preserve("%s/\\s\\+$//e")

    nnoremap <leader>fR :.Runner<cr>

    " This copies current file path + line number to system clipboard
    " source: https://stackoverflow.com/questions/17498144/yank-file-path-with-line-no-from-vim-to-system-clipboard
    nnoremap <leader>fC :let @+=expand("%") . ':' . line(".")<CR>

    " Fold settings {{{
      autocmd FileType vim setl foldmethod=marker
      autocmd FileType zsh setl foldmethod=marker
      autocmd FileType tmux setl foldmethod=marker
      autocmd FileType sh setl foldmethod=marker
      autocmd FileType sql setl nofoldenable foldmethod=manual
    " }}}

    " Only have cursorline/cursorcolumn in current window and in normal window
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
  augroup END
" }}}


" PLUGGINS: Initialise vimplug and plugins {{{
call vimplug#CheckInstall()
call plug#begin()
  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/plugin_configuration.vim
call plug#end()

colo desert " fallback incase colorscheme can't be found
call ActivateColorScheme()
" }}}


" EXTRA: Include local vim config {{{
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
" }}}
