"
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

" ==============================================================================
" General settings {{{
" ============================================================================
"
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

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif


set rtp+=/usr/local/opt/fzf

"open help in a new ventical split instead of vimbuffer
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'vert help' : 'h'

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    let python3_host_prog = "python3"
    let python_host_prog = "python"
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    " set termguicolors
  endif
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

" Execute macro under key `a` for all buffers and write afterwards
command! Bufmacro bufdo execute "normal @a" | write

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Find merge conflict markers
noremap <leader>gm /\v^[<\|=>]{7}( .*\|$)<CR>

" Spelling mapping
inoremap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" tabpage mappings
noremap <Leader>tn :tabnext<CR>
noremap <Leader>t :tabnew<CR>

" session mappings
noremap <leader>m :call WriteSession()<CR>

" custom comma motion mapping
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
no / :Subvert/

" gO to create a new line below cursor in normal mode
nnoremap go o<ESC>k

" go to create a new line above cursor
nnoremap gO O<ESC>j

" I really hate that things don't auto-center
nnoremap G Gzz
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz

" open tag in new tab with <C-\>
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Make Y behave like other capital commands.
" Hat-tip http://vimbits.com/bits/11
nnoremap Y y$

" Toggle highlight search with <leader>thl
nnoremap <leader>thl :set hlsearch!<CR>

" close buffer with leader-q
" and safe & close buffer with leader-wq
nnoremap <leader>q :bd<CR>
nnoremap <leader>wq :w<CR>:bd<CR>

" Call ArcLint using :ArcLint
command! -nargs=* ArcLint call s:ArcLint("<args>")
command! PasteCode call s:PasteCode()

" Go to previous and next item in quickfix list
noremap <leader>cn :cnext<CR>
noremap <leader>cp :cprev<CR>
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

" }}}
" ==============================================================================

" ==============================================================================
" General AutoCommands {{{
" ============================================================================

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

augroup vimrcEx
  autocmd!
  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

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

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " set foldmethod for vim files
  autocmd FileType vim set foldmethod=marker

  " set text_width for git buffers
  autocmd FileType gitcommit setlocal textwidth=70

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
  let dateStamp = strftime("%d-%m-%Y_%H:%M")
  let extension = ".session"
  let fname = cwd . "_" . dateStamp . extension

  silent exe ":SaveSession " . fname
  echo "Wrote " . fname
endfun

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

function! s:PasteCode()
  set paste
  execute "normal! o\<esc>\]p"
  set nopaste
endfunction
" }}}
" ==============================================================================

" ==============================================================================
" Start replacing tmux with nvim terminal splits {{{
" ==============================================================================
  nnoremap <leader>st :botright split<cr>:terminal<cr>
  nnoremap <leader>stv :botright vsplit<cr>:terminal<cr>
  tnoremap <leader><ESC> <C-\><C-n>
  tnoremap <leader>tn <C-\><C-n>:tabnext<CR>

  command! -nargs=* T terminal

  " Window navigation between terminal and nonterminal {{{
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif
    tnoremap <silent> <leader>wh <C-\><C-n><C-w>h
    tnoremap <silent> <leader>wj <C-\><C-n><C-w>j
    tnoremap <silent> <leader>wk <C-\><C-n><C-w>k
    tnoremap <silent> <leader>wl <C-\><C-n><C-w>l

    nmap <silent> <leader>wh <C-w>h
    nmap <silent> <leader>wj <C-w>j
    nmap <silent> <leader>wk <C-w>k
    nmap <silent> <leader>wl <C-w>l
  "}}}

  " split to tiled windows {{{
    nmap <silent> <leader>wv :vs<cr>
    nmap <silent> <leader>ws :split<cr>
    tnoremap <silent> <leader>wv <C-\><C-n>:vs<cr>:startinsert<cr>
    tnoremap <silent> <leader>ws <C-\><C-n>:split<cr>:startinsert<cr>
  "}}}

 function! s:default_workspace()
    " let g:jobs['zeus'] = a:Shell.new('zeus', 'zeus start')
    " let g:jobs['frontend'] = a:Shell.new('frontend', 'foreman start -c all=0,sass=1,webpack=1,uidocs=1,karma=1 ; read')
    " let g:jobs['services'] = a:Shell.new('services', 'foreman start -c all=0,redis=1,postgresql=1,mailcatcher=1 ; read')

    tabnew term://~/.dotfiles/scripts/startBackend
    file Backend:daemon
    "
    split term://~/.dotfiles/scripts/startServices
    file Services:daemon
    "
    vsp term://~/.dotfiles/scripts/startFrontend
    file Frontend:daemon
 endfunction

 command! -nargs=* StartAll call s:default_workspace()
" }}}
" ==============================================================================

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plugin_configuration.vim

" ==============================================================================
" Statusline {{{
" ==============================================================================
"
" additional symbols that might be usefull in the future:
"   paste mode  
"   fzf symbol:   
"   wifi: 
"   direction: 
"   labeled file or sesison?  
"   warnings:   
"   info: 
"   inbox: 
"   hot: 
"   time: 

    set laststatus=2
    set guioptions-=e

    autocmd BufEnter,WinEnter,VimEnter,BufRead * let w:getcwd = getcwd()
    let &statusline = " %{SessionFlag()} "
    let &statusline .= " %<%f "
    let &statusline .= "%{&readonly ? ' ' : &modified ? ' ' : ''}"
    let &statusline .= "%{PasteFlag()}"
    let &statusline .= "%{SpellFlag()}"
    let &statusline .= "%{HardTimeFlag()}"
    let &statusline .= "%=╱ %{&filetype == '' ? 'unknown' : &filetype} "
    let &statusline .= "╱ %p%% ╱ col %c "

    function! SessionFlag()
      if has_key(g:plugs, 'vim-session')
        let session = xolox#session#find_current_session()
      else
        let session = ''
      endif

      if empty(session) || session == 'default'
        return ' '.fnamemodify(getwinvar(0, 'getcwd', getcwd()), ':t')
      else
        return ' '.session
      endif
    endfunction

    function! GitFlag()
      let git = fugitive#head()
      if git != '' && winwidth(0) > 70
        return "  ".strpart(git, strlen(git)-30)." "
      else
        return ""
      endif
    endfunction

    function! FiletypeFlag()
      let filename = expand('%F')
      return WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
    endfunction

    function! PasteFlag()
      if &paste
        return '  '
      else
        return ''
      endif
    endfunction

    function! SpellFlag()
      if &spell
        return '  '
      else
        return ''
      endif
    endfunction

    function! SyntaxFlag()
      if has_key(g:plugs, 'neomake')
        return ' ⚠ '
      else
        return ''
      endif
    endfunction

    function! HardTimeFlag()
      if exists("b:hardtime_on") && b:hardtime_on == 1
        return '  '
      else
        return ''
      endif
    endfunction
  " }}}
" ==============================================================================

" autocmd BufRead,BufNewFile *.* call ActivateColorScheme()
call ActivateColorScheme()
" ==============================================================================
" Include user's local vim config {{{
" ==============================================================================
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
" }}}
" ==============================================================================
