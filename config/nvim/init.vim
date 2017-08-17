" ==============================================================================
" General settings {{{
" ============================================================================

" Sets the character encoding for the file of this buffer.
if !&readonly
  set fileencoding=utf-8
endif


" set re=1 " what regexpengine to use TODO: probably don't need this
set noswapfile                                     " Disable swapfile (https://tinyurl.com/y9t8frrs)
set autowrite                                      " Write before running commands.
set shortmess=aAIsT                                " Reduce |hit-enter| prompts.
set cmdheight=2                                    " Number of screen lines for the command-line.
set nowrap                                         " Don't wrap lines as it makes j/k unintuitive.
set smartcase                                      " Search case incensitive.
set incsearch                                      " Highlight incremental matches.
set textwidth=100                                  " Set maximum number of characters per line
set sessionoptions+=resize                         " Changes the effect of the |:mksession| command.
set completeopt=menu                               " Use popup menu for insert mode completion
set cc=+1,+2                                       " Highlight first 2 columns after 'textwidth'

set list                                           " TODO: not sure why this is required.
set listchars=tab:▸\ ,trail:-,extends:>,precedes:< " Strings in 'list' mode.
set fillchars=vert:¦                               " Strings in statuslines and vert separators.

set tags=./TAGS                                    " Location to store tags.

set hid                                            " Allow for more then one unsaved buffer.
set lazyredraw                                     " Don't unnecessarily redraw screen.

set undofile                                       " Save undo's after file closes.
set undodir=$HOME/.config/nvim/undo/               " Location of Undo files.
set undolevels=1000                                " Number of changes to be saved.
set undoreload=10000                               " Save whole buffer to undohist when reloading.
set backup                                         " enable backupcopy.
set backupdir=$HOME/.config/nvim/tmp               " directory to save backup files.

set tabstop=2 shiftwidth=2 softtabstop=2           " set softtabs and width of 2.
set expandtab                                      " use spaces instead of tabs for indentation.
set number relativenumber numberwidth=5            " Numbers + relative numbers.
set splitbelow splitright                          " Open new split panes to right and bottom.
set inccommand=split                               " Show visual indication when using substitute.
set nofoldenable                                   " collapse all folds.
" set backspace=indent,eol,start                     " Proper backspace behavior.

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
noremap <Leader>t :tabnew<CR>
noremap <Leader>tn :tabnext<CR>

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

  nnoremap <leader>fR :.Runner<cr>

  " This copies current file path + line number to system clipboard
  " source: https://stackoverflow.com/questions/17498144/yank-file-path-with-line-no-from-vim-to-system-clipboard
  nnoremap <leader>fC :let @+=expand("%") . ':' . line(".")<CR>

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
    autocmd FileType sql setl nofoldenable foldmethod=manual
  " }}}

  " set text_width for git buffers
  autocmd FileType gitcommit setlocal textwidth=70
  autocmd FileType vimdiff setlocal nocursorcolumn

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
