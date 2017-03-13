" ==============================================================================
" General settings {{{
" ============================================================================

" Sets the character encoding for the file of this buffer.
if !&readonly
  set fileencoding=utf-8
endif

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

" highlight incremental matches when searching /
set incsearch

" Maximum width of text that is being inserted.  A longer line will be
" broken after white space to get this width.
set textwidth=100

" Changes the effect of the |:mksession| command.
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
set tags=./TAGS

" unknown
set re=1

" fix suggested in a neovim issue where buffer switching was slow
" in combination with vim-airline and neovim
set hid

" When this option is set, the screen will not be redrawn while
" executing macros, registers and other commands that have not been
" typed
set lazyredraw

" Use <space> as leader
let mapleader="\<Space>"
let g:mapleader="\<Space>"

"Undo & backup
set undofile                        " Save undo's after file closes
set undodir=$HOME/.config/nvim/UndoHistory/ " where to save undo histories
set undolevels=1000                 " How many undos
set undoreload=10000                " number of lines to save for undo

set backup "
set backupdir=$HOME/.config/nvim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=$HOME/.config/nvim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp

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

" Show visual indication if your using substitute command
set inccommand=split

" Disable visual bell
set t_vb=
autocmd GUIEnter * set t_vb=

"open help in a new split instead of vimbuffer
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'rightbelow help' : 'h'

let python3_host_prog = "python3"
let python_host_prog = "python"

if (has("termguicolors"))
  set termguicolors
  set t_8f=^[[38;2;%lu;%lu;%lum
  set t_8b=^[[48;2;%lu;%lu;%lum
endif

" }}}
" ==============================================================================

" ==============================================================================
" General Keybindings {{{
" ============================================================================

" Fix annoying typo's of WQ, QA and Q
command! WQ wq
command! Wq wq

command! W w
command! WW w

command! Q q

command! QA qa
command! Qa qa

"w!! to save file with sudo
cmap w!! w !sudo tee % > /dev/null

" toggle background
nnoremap <leader>tb :call <SID>toggleBG()<cr>

" Execute macro under key `a` for all buffers and write afterwards
command! Bufmacro bufdo execute "normal @a" | write
command! Cmacro cdo execute "normal@a" | write

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Find merge conflict markers
noremap <leader>gm /\v^[<\|=>]{7}( .*\|$)<CR>

" Spelling mapping
inoremap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" tabpage mappings
noremap <Leader>tn :tabnew<CR>

" session mappings
noremap <leader>m :call WriteSession()<CR>

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

" Call ArcLint using :ArcLint
command! -nargs=* ArcLint call s:ArcLint("<args>")

" Paste and keep indent
command! PasteCode call s:PasteCode()

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
func! ExecVisualSelection()
  let selection=s:get_visual_selection()
  call jobstart("open ".selection)
endfunc
vnoremap o :call ExecVisualSelection()<cr>
" }}}
" ==============================================================================

" ==============================================================================
" File Keybindings {{{
" ============================================================================
" Save
noremap <leader>fs :w<CR>

" Open vimrc with <leader>fed
nnoremap <leader>fed  :e $MYVIMRC<CR>
nnoremap <leader>feR :source $MYVIMRC<CR>

" Rename current file with <leader>fr
noremap <leader>fr :call RenameFile()<CR>

" Get a vimdiff of all approvals
map <leader>v :!approvals verify -d vimdiff -a<cr>
" }}}
" ==============================================================================

" ==============================================================================
" General AutoCommands {{{
" ============================================================================

augroup ALEXANDER_BASIC
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

  " Enable spellchecking for Markdown and git commit
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell

  " Add html highlighting when editing rails views & handlebar templates
  autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
  autocmd BufRead,BufNewFile *.hbs set filetype=handlebars.html

  " Add javascript highlighting when embeded in HTML file
  autocmd BufRead,BufNewFile *.html set filetype=html.javascript

  " Add javascript highlighting when embeded in erb file
  autocmd BufRead,BufNewFile *.js.erb set filetype=eruby.javascript

  " Add coffeescript highlighting to coffee.cjsx files
  autocmd BufRead,BufNewFile *.coffee.cjsx set filetype=coffee.html

  " Automatically remove trailing whitespaces unless file is blacklisted
  autocmd BufWritePre *.* :call Preserve("%s/\\s\\+$//e")

  " Run specs under cursor if saving a rspec or cucumber file
  autocmd BufWritePost *_spec.rb :.Rrunner
  autocmd BufWritePost *.feature :.Rrunner

  " Enable omni completion {{{
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  " }}}

  " Fold settings {{{
    autocmd FileType vim setl foldmethod=marker
    autocmd FileType zsh setl foldmethod=marker
    autocmd FileType tmux setl foldmethod=marker
    autocmd FileType sh setl foldmethod=marker
    autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent foldlevel=2
    autocmd BufNewFile,BufReadPost *.feature setl foldmethod=indent foldlevel=1
    autocmd BufNewFile,BufReadPost *.rb setl foldmethod=syntax foldlevel=1
    autocmd BufNewFile,BufReadPost *.js setl foldmethod=syntax foldlevel=1
  " }}}

  " set text_width for git buffers
  autocmd FileType gitcommit setlocal textwidth=70

  " Only have cursorline/cursorcolumn in current window and in normal window
  autocmd WinLeave * set nocursorline nocursorcolumn
  autocmd WinEnter * set cursorline cursorcolumn
  autocmd InsertEnter * set nocursorcolumn nocursorline
  autocmd InsertLeave * set cursorcolumn cursorline
augroup END
" }}}
" ==============================================================================

" ==============================================================================
" General functions {{{
" ============================================================================

" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Do the business unless filetype is blacklisted
  let blacklist = ['sql']

  if index(blacklist, &ft) < 0
    execute a:command
  endif

  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" save session
fun! WriteSession()
  let cwd = fnamemodify('.', ':p:h:t')
  " let dateStamp = strftime("%d-%m-%Y_%H:%M")
  let extension = ".session"
  " let fname = cwd . "_" . dateStamp . extension
  let fname = cwd . extension
  silent exe ":Obsession " . fname
  echo "Wrote " . fname
endfun

func! s:colorSchemeOverides()
  hi! link Search PMenu
  hi! link IncSearch PMenuSel
  hi! link Folded Visual
endfunc

function! s:toggleBG()
  " swap background
  let &background = (&background == "dark"? "light" : "dark")

  " set colorscheme
  exec 'colorscheme '.(&background == "dark"? g:dark_colorscheme : g:light_colorscheme)

  " set tmux status and iterm
  if &background == "light"
    "tmux fg and bg
    if exists('$TMUX')
      call jobstart("tmux set -g status-fg 'black'")
      call jobstart("tmux set -g status-bg 'brightwhite'")
      call jobstart('echo -e "\033Ptmux;\033\033]50;SetProfile=Light\a\033\\"')
    else
      call jobstart('echo -e "\033]50;SetProfile=Light\a"')
    endif

  elseif &background == "dark"
    "tmux fg and bg
    if exists('$TMUX')
      call jobstart("tmux set -g status-fg 'brightblack'")
      call jobstart("tmux set -g status-bg 'black'")
      call jobstart('zsh toggleBG')
    else
      call jobstart('zsh toggleBG')
    endif
  endif

  " call overwrites
  call s:colorSchemeOverides()
endfunc

"FIXME: output is borked.
function! s:ArcLint(args)
    let olderrorformat = &errorformat
    let oldmakeprg = &makeprg

    set errorformat=%f:%l:%m
    let &makeprg="arc lint --output compiler ".a:args
    silent make
    redraw!

    let &errorformat = olderrorformat
    let &makeprg = oldmakeprg
    copen
endfunction

" source: http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript#6271254
" original author of this function: xolox
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
" }}}
" ==============================================================================

" ==============================================================================
" statusline settings {{{
" ==============================================================================
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
  let &statusline .= "%{PasteFlag()}"
  let &statusline .= "%{SpellFlag()}"
  let &statusline .= "%{HardTimeFlag()}"
  let &statusline .= "%=%{&filetype == '' ? 'unknown' : &filetype}"
  let &statusline .= " %2c "

  function! PasteFlag()
    if &paste
      return '  '
    else
      return ''
    endif
  endfunction

  function! SpellFlag()
    if &spell
      return ' Ꞩ '
    else
      return ''
    endif
  endfunction

  function! SyntaxFlag()
    if dein#tap('ale')
      let l:res = ale#statusline#Status()
      if l:res ==# 'OK'
        return '  '
      else
        return '  '
      end
    else
      return ''
    endif
  endfunction

  function! HardTimeFlag()
    if exists("b:hardtime_on") && b:hardtime_on == 1
      return ' '
    else
      return ''
    endif
  endfunction
" }}}
" ==============================================================================

" ==============================================================================
" terminal settings {{{
" ==============================================================================
  tnoremap <leader><ESC> <C-\><C-n>
" }}}
" ==============================================================================

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plugin_configuration.vim
" ==============================================================================
" Include local vim config {{{
" ==============================================================================
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
" }}}
" ==============================================================================
