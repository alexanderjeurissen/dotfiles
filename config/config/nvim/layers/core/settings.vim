"                                _   _   _
"   _____ _____ _____   ___  ___| |_| |_(_)_ __   __ _ ___   _____ _____ _____
"  |_____|_____|_____| / __|/ _ \ __| __| | '_ \ / _` / __| |_____|_____|_____|
"  |_____|_____|_____| \__ \  __/ |_| |_| | | | | (_| \__ \ |_____|_____|_____|
"                      |___/\___|\__|\__|_|_| |_|\__, |___/
"                                                 |___/

" Sets the character encoding for the file of this buffer.
set fileencoding=utf-8

" Don't use swapfiles.. use a vcs like git instead
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

" Automatically :write before running commands
set autowrite

" This option helps to avoid all the |hit-enter| prompts caused by file messages
set shortmess=aAIsT

" Number of screen lines to use for the command-line.
set cmdheight=2

" Don't wrap lines as it behaves acqward while moving between lines
set nowrap

" search case incensitive with /
set smartcase

" Maximum width of text that is being inserted.  A longer line will be
" broken after white space to get this width.
set textwidth=80

" Changes the effect of the |:mksession| command.
set sessionoptions-=options  " Don't save options
set sessionoptions+=resize

" Use a popup menu to show the possible completions in Insert mode
set completeopt=menu

" popup  Right mouse button pops up a menu.  The shifted left
" mouse button extends a selection.  This works like
" with Microsoft Windows.
set mousemodel=popup

" Characters to fill the statuslines and vertical separators.
set fillchars=vert:¦

" unknown
set cc=+1,+2

" Strings to use in 'list' mode and for the |:list| command.
set list
" set listchars=tab:▸\ ,trail:-,extends:>,precedes:<,eol:¬
set listchars=tab:▸\ ,trail:-,extends:>,precedes:<

" location to store tags
set tags=./tags

" unknown
set re=1

" Indicates a fast terminal connection.  More characters will be sent to
" the screen for redrawing
set ttyfast

" When this option is set, the screen will not be redrawn while
" executing macros, registers and other commands that have not been
" typed
set lazyredraw

" Use <space> as leader
let mapleader="\<Space>"
let g:mapleader="\<Space>"

"Undo & backup
set undofile                        " Save undo's after file closes
set undodir=$HOME/.vim/UndoHistory/ " where to save undo histories
set undolevels=1000                 " How many undos
set undoreload=10000                " number of lines to save for undo

set backup "
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Numbers
set number
set relativenumber
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set clipboard=unnamed


" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif


set rtp+=/usr/local/opt/fzf

"open help in a new tab instead of vimbuffer
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'vert help' : 'h'

"set terminal colors if gui isn't running
if !has("gui_running") && !has('nvim')
  set t_Co=256
  set term=screen-256color
  "Access colors present in 256 colorspace"
  let base16colorspace=256
endif

if has('nvim')
  " fix issue where <c-h> would result in <BS>
  " issue: neovim/issues/2048
     " nmap <BS> <C-W>h
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif
