
     " E      888                                             888                  d88b
    " d8b     888  e88~~8e  Y88b  /    /~~~8e  888-~88e  e88~\888  e88~~8e  888-~\ Y88P  d88~\
   " /Y88b    888 d888  88b  Y88b/         88b 888  888 d888  888 d888  88b 888    __/  C888
  " /  Y88b   888 8888__888   Y88b    e88~-888 888  888 8888  888 8888__888 888          Y88b
"  /____Y88b  888 Y888    ,   /Y88b  C888  888 888  888 Y888  888 Y888    , 888           888D
" /      Y88b 888  '88___/   /  Y88b  `88_-888 888  888  '88_/888  "88___/  888         \_88P

" Y88b      / ,e,
"  Y88b    /   "  888-~88e-~88e 888-~\  e88~~\
  " Y88b  /   888 888  888  888 888    d888
   " Y888/    888 888  888  888 888    8888
    " Y8/     888 888  888  888 888    Y888
     " Y      888 888  888  888 888     "88__/





"                                            _   _   _
"   _____ _____ _____ _____ _____   ___  ___| |_| |_(_)_ __   __ _ ___   _____ _____ _____ _____ _____
"  |_____|_____|_____|_____|_____| / __|/ _ \ __| __| | '_ \ / _` / __| |_____|_____|_____|_____|_____|
"  |_____|_____|_____|_____|_____| \__ \  __/ |_| |_| | | | | (_| \__ \ |_____|_____|_____|_____|_____|
"                                  |___/\___|\__|\__|_|_| |_|\__, |___/
"                                                            |___/
"section:settings

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
let maplocalleader="\<Space>"
let g:maplocalleader="\<Space>"

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

set rtp+=/usr/local/opt/fzf

"open help in a new tab instead of vimbuffer
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'vert help' : 'h'

"set terminal colors if gui isn't running
if !has("gui_running") && !has('nvim')
  set t_Co=256
  set term=screen-256color
  "Access colors present in 256 colorspace"
  " let base16colorspace=256
endif

if has('nvim')
  " fix issue where <c-h> would result in <BS>
  " issue: neovim/issues/2048
     " nmap <BS> <C-W>h
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif

augroup vimrcEx
  autocmd!
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

  " Enable spellchecking for Markdown and git commit
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell

  " Automatically wrap at 80 characters for Markdown, ruby, css and coffescript
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  autocmd BufRead,BufNewFile *.erb setlocal textwidth=80
  autocmd BufRead,BufNewFile *.rb setlocal textwidth=80
  autocmd BufRead,BufNewFile *.css setlocal textwidth=80
  autocmd BufRead,BufNewFile *.coffee setlocal textwidth=80

  " Automatically wrap at 150 characters for javascript files
  autocmd BufRead,BufNewFile *.js setlocal textwidth=80

  " Add html highlighting when editing rails views & handlebar templates
  autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
  autocmd BufRead,BufNewFile *.hbs set filetype=handlebars.html

  " Add javascript highlighting when embeded in HTML file
  autocmd BufRead,BufNewFile *.html set filetype=html.javascript

  " Add javascript highlighting when embeded in erb file
  autocmd BufRead,BufNewFile *.js.erb set filetype=eruby.javascript

  " Add javascript highlighting when editing ecmascript 6 files
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript

  " Automatically remove trailing whitespaces
  autocmd BufWritePre *.* :call Preserve("%s/\\s\\+$//e")

  autocmd BufRead,BufNewFile *.plugin set filetype=vim
  autocmd BufRead,BufNewFile *.plugingroup set filetype=vim
  autocmd BufRead,BufNewFile *.colorscheme set filetype=vim

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

autocmd FileType gitcommit setlocal textwidth=70
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif


source $HOME/.vim/settings/plugins.vim
call ActivateColorScheme()

"                                   _____                 _   _
"   _____ _____ _____ _____ _____  |  ___|   _ _ __   ___| |_(_) ___  _ __  ___   _____ _____ _____ _____ _____
"  |_____|_____|_____|_____|_____| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __| |_____|_____|_____|_____|_____|
"  |_____|_____|_____|_____|_____| |  _|| |_| | | | | (__| |_| | (_) | | | \__ \ |_____|_____|_____|_____|_____|
"                                  |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
"
"section:functions

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

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-e>"
    endif
endfunction

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
    function! Stab()
      let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
      if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
      endif
      call SummarizeTabs()
    endfunction

    function! SummarizeTabs()
      try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
          echon ' expandtab'
        else
          echon ' noexpandtab'
        endif
      finally
        echohl None
      endtry
    endfunction

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" save session
fun! WriteSession()
  let cwd = fnamemodify('.', ':p:h:t')
  let dateStamp = strftime("%d-%m-%Y_%H:%M")
  let extension = ".session"
  let fname = cwd . "_" . dateStamp . extension

  silent exe ":UniteSessionSave " . fname
  echo "Wrote " . fname
endfun

" Use ranger as vim file manager
fun! Ranger()
  let tmpfile = tempname()
  if a:0 > 0 && a:1 != ""
    let dir = a:1
  elseif expand("%")
    let dir = "."
  else
    let dir = expand("%:p:h")
  endif

  exe 'silent !ranger --choosefile='.tmpfile dir
  if filereadable(tmpfile)
    exe 'edit' readfile(tmpfile)[0]
    call delete(tmpfile)
  endif
  redraw!

  let result = 0
  if filereadable(tmpfile)
      silent let result = system('cat '. tmpfile)
  endif
  silent call system('rm -rf ' . tmpfile)
  return result
endfun

  "                                                              _
  "  _____ _____ _____ _____ _____   _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___   _____ _____ _____ _____ _____
  " |_____|_____|_____|_____|_____| | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __| |_____|_____|_____|_____|_____|
  " |_____|_____|_____|_____|_____| | | | | | | (_| | |_) | |_) | | | | | (_| \__ \ |_____|_____|_____|_____|_____|
  "                                 |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
  "                                                 |_|   |_|            |___/
  "section:mappings

  " Unnoremap the arrow keys
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

  " Fix annoying typo's of WQ, QA and Q
  command! WQ wq
  command! Wq wq

  command! W w
  command! Q q

  command! QA qa
  command! Qa qa
  command! Bufmacro bufdo execute "normal @a" | write

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  "use up and dow arrow to move line
  noremap <up> ddkP
  noremap <down> ddp

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

  " Find merge conflict markers
  noremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
  "
  "Spelling mapping
  inoremap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u

  " Map <Leader>ff to display all lines with keyword under cursor
  " and ask which one to jump to
  " nnoremap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>"

  "open current buffer in chrome or safari
  " nnoremap <c-p> :!open -a Safari %<CR><CR>
  " nnoremap <c-p> :!open -a Google\ Chrome %<CR><CR>

  "vimdiff mappings
  nnoremap <leader>d :Gdiff<CR>
  nnoremap <leader>dh :diffget //2 <CR>:diffupdate<CR>
  nnoremap <leader>dt :diffget //3 <CR>:diffupdate<CR>
  nnoremap <leader>dw :only <CR>:Gwrite<CR>

  "get from REMOTE
  nnoremap <leader>dgr :diffg RE<CR>
  "get from BASE
  nnoremap <leader>dgb :diffg BA<CR>
  "get from LOCAL
  nnoremap <leader>dgl :diffg LO<CR>

  " tabpage mappings
  noremap <Leader>tn :tabnext<CR>

  noremap <Leader>t :tabnew<CR>

  " noremap <leader>m :call WriteSession()<CR>
  " noremap <leader>cm :!rm -f ~/.vim/session/*.*<CR>

  "custom comma motion mapping
  nnoremap di, f,dT,
  nnoremap ci, f,cT,
  nnoremap da, f,ld2F,i,<ESC>l "delete argument
  nnoremap ca, f,ld7F,i,<ESC>a "delete arg and insert

  "Ranger mapping
  nnoremap <leader>r :call Ranger()<CR>

  "Replace mappings
  nnoremap <leader>rl 0:s/
  nnoremap <leader>rp {ma}mb:'a,'bs/

  "awesomeness make jj in insertmode escape to normal. never press <esc> again!
  inoremap jj <Esc>

  " upper or lowercase the current word
  nnoremap g^ gUiW
  nnoremap gv guiW

  " diff
  nnoremap >c ]czz
  nnoremap <c [czz

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

  "open tag in new tab
  noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
  "retab everything
  noremap <leader>rt :set expandtab<CR>:retab<CR>

  " Make Y behave like other capital commands.
  " Hat-tip http://vimbits.com/bits/11
  nnoremap Y y$

  " Just to beginning and end of lines easier. From http://vimbits.com/bits/16
  noremap H ^
  noremap L $

  " Use ; for : in normal and visual mode, less keystrokes
  nnoremap ; :
  vnoremap ; :

  " Open vimrc with leader->v
  nnoremap <leader>v  :vsplit $MYVIMRC<CR>
  nnoremap <leader>gv  :vsplit $MYGVIMRC<CR>
  nnoremap <leader>vr :source $MYVIMRC<CR>

  noremap <leader>n :call RenameFile()<CR>

  " nnoremap <C-m> :MaximizerToggle<CR>
  nnoremap <leader>hl :set hlsearch!<CR>


  " close buffer with leader-q
  " and safe & close buffer with leader-wq
  nnoremap <leader>q :bd<CR>
  nnoremap <leader>wq :w<CR>:bd<CR>

  " go to next and previous bufferj
  nmap <C-B> :bn<CR>

  " set background=light


"
" Layer specific functions
" TODO: a layer should register using following object:
" {name:string, filetypes, callback}
" calling register should return a UID so that the layer function can deactivate
" itself easily etc.
"

let g:layers = []

fun! RegisterLayer(layer)
  call add(g:layers, {'text': a:layer, 'filetypes': ['*.hello'], 'callback': 'ActiveLayers'})
endfun

fun! RemoveLayer(layer)
  let index = index(g:layers, layer)
  call remove(g:layers, index)
endfun


" initialize all layers this has to take place after adding
" all layers to the runtime using runtime commands
" autocmd BufRead,BufNewFile *.* :call InitializeLayers()
"
" fun! InitializeLayers()
"   augroup vimrcEx
"     autocmd!
"     for layer in g:layers
"       for ftype in layer.filetypes
"         autocmd BufRead,BufNewFile ftype :call eval(layer.callback)
"       endfor
"     endfor
"   augroup END
" endfun
"
" fun! ActiveLayers()
"   echo "Active Layers:"
"   for layer in g:layers
"     echo "* " layer.text
"   endfor
" endfun

    function! PasteCode()
      set paste
      execute "normal! o\<esc>\]p"
      set nopaste
    endfunction

    nmap <leader>pp :call PasteCode()<CR>
