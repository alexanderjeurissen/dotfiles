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

"set terminal colors if gui isn't running
if !has("gui_running") && !has('nvim')
  set t_Co=256
  " set term=screen-256color
  "Access colors present in 256 colorspace"
  " let base16colorspace=256
endif

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let python3_host_prog = "python3"
  let python_host_prog = "python"
endif
" }}}
" ==============================================================================

" ==============================================================================
" General Keybindings {{{
" ============================================================================

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

" Go to beginning and end of lines easier. From http://vimbits.com/bits/16
noremap H ^
noremap L $

" Open vimrc with <leader>v
nnoremap <leader>v  :vsplit $MYVIMRC<CR>
nnoremap <leader>gv :vsplit $MYGVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" Rename current file with <leader>n
noremap <leader>n :call RenameFile()<CR>

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

  " resize splits
  function! IsMost(direction)
    let oldw = winnr()
    silent! exe "normal! \<c-w>".a:direction
    let neww = winnr()
    silent! exe oldw.'wincmd w'
    return oldw == neww
  endfunction

  function! ResizeSplits(direction)
    let oldw = winnr()
    let leftMost=IsMost('h')
    let bottomMost=IsMost('j')

    if a:direction == 'left'
      if IsMost('h')
        silent! exe 'vertical resize -5'
      else
        silent! exe "normal! \<c-w>h"
        silent! exe "vertical resize +5"
        silent! exe oldw.'wincmd w'
      endif
    elseif a:direction == 'right'
      if IsMost('h')
        silent! exe 'vertical resize +5'
      else
        silent! exe "normal! \<c-w>h"
        silent! exe "vertical resize +5"
        silent! exe oldw.'wincmd w'
      endif
    elseif a:direction == 'up'
      if bottomMost
        silent! exe 'resize +5'
      else
        silent! exe "normal! \<c-w>j"
        silent! exe "resize +5"
        silent! exe oldw.'wincmd w'
      endif
    elseif a:direction == 'down'
      if bottomMost
        silent! exe 'resize -5'
      else
        let oldw = winnr()
        silent! exe "normal! \<c-w>k"
        silent! exe "resize +5"
        silent! exe oldw.'wincmd w'
      endif
    endif
  endfunction

  nnoremap <up> :call ResizeSplits('up')<CR><ESC>
  nnoremap <down> :call ResizeSplits('down')<CR><ESC>
  nnoremap <left> :call ResizeSplits('left')<CR><ESC>
  nnoremap <right> :call ResizeSplits('right')<CR><ESC>

  " Window navigation between terminal and nonterminal
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  tnoremap <silent> <leader>wh <C-\><C-n><C-w>h
  tnoremap <silent> <leader>wj <C-\><C-n><C-w>j
  tnoremap <silent> <leader>wk <C-\><C-n><C-w>k
  tnoremap <silent> <leader>wl <C-\><C-n><C-w>l

  nmap <silent> <leader>wh <C-w>h
  nmap <silent> <leader>wj <C-w>j
  nmap <silent> <leader>wk <C-w>k
  nmap <silent> <leader>wl <C-w>l

  if !exists('g:jobs')
    let Shell = {}
    let g:Shell = {}
    let g:jobs = {}

    function Shell.on_stdout(job_id, data)
      let self.output .= ' stdout: '.join(a:data).'\n'
    endfunction

    function Shell.on_stderr(job_id, data)
      let self.output .= ' stderr: '.join(a:data).'\n'
    endfunction

    function Shell.on_exit(job_id, data)
      let self.output .= ' exited\n'
    endfunction

    function Shell.get_name()
      return 'shell '.self.name
    endfunction


    function Shell.get_output()
      let lines = split(self.output, '\\n')
      call fzf#run({
      \ 'source':  lines,
      \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 3.. '.
      \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
      \            '--color hl:68,hl+:110',
      \ 'down':    '90%'
      \ })
    endfunction

    function Shell.new(name, ...)
      let instance = extend(copy(g:Shell), {'name': a:name})
      let argv = 'zsh'
      if a:0 > 0
        let argv = a:1
      endif
      let instance.id = jobstart(argv, instance)
      let instance.output = ''
      return instance
    endfunction
  endif

 function! s:default_workspace(Shell)
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

 command! -nargs=* StartAll call s:default_workspace(Shell)

" }}}
" ==============================================================================

" ==============================================================================
" Plugins {{{
" ==============================================================================
"                      ____  _             _
"  _____ _____ _____  |  _ \| |_   _  __ _(_)_ __  ___   _____ _____ _____
" |_____|_____|_____| | |_) | | | | |/ _` | | '_ \/ __| |_____|_____|_____|
" |_____|_____|_____| |  __/| | |_| | (_| | | | | \__ \ |_____|_____|_____|
"                     |_|   |_|\__,_|\__, |_|_| |_|___/
"                                    |___/
" Some plugins conflict with each other, those plugins are wrapped in a if
" statement that checks if the given plugin is enabled.
" to check if a plugin is enabled use `dein#tap('plugin_name')`
" to disable a plugin use `dein#disable('plugin')`

" ------------------------------------------------------------------------------
" Dein.vim {{{
" ------------------------------------------------------------------------------
"Note: install dein if not present
let g:dein_path='$HOME/.config/nvim/dein'

if !filereadable(expand(g:dein_path) . '/repos/github.com/Shougo/dein.vim/README.md')
  if executable('git')
    exec '!git clone https://github.com/Shougo/dein.vim ' . g:dein_path . '/repos/github.com/Shougo/dein.vim'
  else
    echohl WarningMsg | echom "You need install git!" | echohl None
  endif

  autocmd VimEnter * source $MYVIMRC
endif

if &compatible
  set nocompatible
endif

" Add dein.vim to runtimepath
set runtimepath^=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

let g:plugin_path='$HOME/.config/nvim/dein'

if dein#load_state(expand(g:plugin_path))
  " tell dein where the plugins live
  call dein#begin(
        \ expand(g:plugin_path),
        \ [expand('$HOME/.config/nvim/init.vim')]
        \)
  call dein#add('Shougo/dein.vim') " Let dein manage dein

" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" TODO:AutoCompletion {{{
" ------------------------------------------------------------------------------
  "call dein#add('mattn/emmet-vim', { 'lazy' : 1, 'on_i' : 1 })

  "call dein#add('Shougo/deoplete.nvim', { 'lazy': 1, 'on_i': 1 })

  " add ultisnips or neosnippets
  call dein#add('SirVer/ultisnips', {
        \ "hook_add": "
        \   let g:UltiSnipsUsePythonVersion = 3\n
        \   let g:UltiSnipsExpandTrigger='<tab>'\n
        \   let g:UltiSnipsJumpForwardTrigger='<c-n>'\n
        \   let g:UltiSnipsJumpBackwardTrigger='<c-p>'\n
        \   let g:UltiSnipsEditSplit='vertical'
        \"})

  call dein#add('tpope/vim-repeat')

  call dein#add('tomtom/tlib_vim')
  call dein#add('MarcWeber/vim-addon-mw-utils')
  call dein#add('alexanderjeurissen/vim-react-snippets')
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ColorSchemes {{{
" ------------------------------------------------------------------------------
  " call dein#add('chriskempson/base16-vim', {
  "     \ 'hook_add': "
  "     \   colorscheme base16-solarized\n
  "     \   set background=dark
  "     \"})

  " call dein#add('mhartington/oceanic-next', {
  "     \ 'hook_add': "
  "     \   colorscheme OceanicNext\n
  "     \   set background=dark
  "     \"})

  " call dein#add('morhetz/gruvbox', {
  "     \ 'hook_add': "
  "     \   let g:gruvbox_italic=1\n
  "     \   let g:gruvbox_italicize_strings=1\n
  "     \   let g:gruvbox_contrast_dark='soft'\n
  "     \   colorscheme gruvbox\n
  "     \   set background=dark
  "     \"})

  " call dein#add('zefei/cake16', {
  "     \ 'hook_add': "
  "     \   colorscheme cake16\n
  "     \   set background=light
  "     \"})

  " call dein#add('junegunn/seoul256.vim', {
  "     \ 'hook_add': "
  "     \   colorscheme seoul256\n
  "     \   set background=dark
  "     \"})

  " call dein#add('romainl/flattened', {
  "     \ 'hook_add': "
  "     \   colorscheme flattened_dark\n
  "     \   set background=dark
  "     \"})


  " \   set termguicolors\n
  call dein#add('Samuel-Phillips/nvim-colors-solarized', {
      \ 'rev': '3618276',
      \ 'hook_add': "
      \   colorscheme solarized\n
      \   set background=dark\n
      \"})


 function! HighlightCustomization()
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
    let g:solarized_termtrans = 1

    " hi! Search ctermfg=10 ctermbg=3
    hi! vimfilerNormalFile  ctermfg=13
    hi! vimfilerClosedFile  ctermfg=4
    hi! vimfilerOpenedFile  ctermfg=13
    hi! vimfilerCurrentDirectory  ctermfg=9
    hi! vimfilerNonMark     ctermfg=4
    hi! vimfilerLeaf        ctermfg=11

    hi! link txtBold Identifier
    hi! link zshVariableDef Identifier
    hi! link zshFunction Function

    hi! link rubyControl Statement
    hi! link rspecGroupMethods rubyControl
    hi! link rspecMocks Identifier
    hi! link rspecKeywords Identifier
    hi! link rubyLocalVariableOrMethod Normal
    hi! link rubyStringDelimiter Constant
    hi! link rubyString Constant
    hi! link rubyAccess Todo
    hi! link rubySymbol Identifier
    hi! link rubyPseudoVariable Type
    hi! link rubyRailsARAssociationMethod Title
    hi! link rubyRailsARValidationMethod Title
    hi! link rubyRailsMethod Title
    hi! link rubyDoBlock Normal
    hi! link MatchParen DiffText

    hi! link CTagsModule Type
    hi! link CTagsClass Type
    hi! link CTagsMethod Identifier
    hi! link CTagsSingleton Identifier

    hi! link javascriptFuncName Type
    hi! link jsFuncCall jsFuncName
    hi! link javascriptFunction Statement
    hi! link javascriptThis Statement
    hi! link javascriptParens Normal
    hi! link jOperators javascriptStringD
    hi! link jId Title
    hi! link jClass Title

    hi! link sassMixinName Function
    hi! link sassDefinition Function
    hi! link sassProperty Type
    hi! link htmlTagName Type
    hi! PreProc gui=bold

    exec ':highlight clear SignColumn'
    exec ':highlight link SignColumn CursorColumn'
  endfunction

  autocmd Colorscheme * call HighlightCustomization()
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Core {{{
" ------------------------------------------------------------------------------
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-sensible')
  call dein#add('tpope/vim-dispatch')
  call dein#add('radenling/vim-dispatch-neovim', {'depends': 'vim-dispatch'})
  call dein#add('MarcWeber/vim-addon-local-vimrc')
  call dein#add('xolox/vim-misc')
  call dein#add('xolox/vim-session', {
        \ 'on_cmd': [
        \   'SaveSession',
        \   'OpenSession',
        \   'RestartVim',
        \   'CloseSession',
        \   'DeleteSession',
        \   'ViewSession'
        \ ],
        \ 'depends': 'vim-misc',
        \ 'hook_add': "
        \  let g:session_autoload = 'no'\n
        \  let g:session_autosave = 'yes'\n
        \  let g:session_autosave_periodic = 30\n
        \  let g:session_default_to_last = 0\n
        \  let g:session_persist_font = 1\n
        \  let g:session_persist_colors = 1\n
        \  let g:session_directory = '~/.config/nvim/sessions'
        \"})
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Editing {{{
" ------------------------------------------------------------------------------
  call dein#add('tpope/vim-abolish', { 'on_cmd': ['Abolish', 'Subvert'] })
  call dein#add('tpope/vim-endwise')
  call dein#add('tommcdo/vim-exchange')
  call dein#add('tpope/vim-surround', {
        \ 'depends': 'vim-repeat',
        \ 'on_map': 'cs'
        \})

  call dein#add('benekastah/neomake')

  call dein#add('vim-scripts/tComment', {
        \ 'on_map': ['gc', 'gcc', 'g<', 'g>']
        \})

  call dein#add('osyo-manga/vim-over', {
        \ 'on_cmd': 'Replace',
        \ 'hook_add': "
        \   let g:over#command_line#paste_escape_chars = '/.*$^~'\n
        \   command! Replace OverCommandLine %s/
        \"})

  call dein#add('editorconfig/editorconfig-vim')

  " makes it easy to switch between single line and multi line blocks
  call dein#add('AndrewRadev/splitjoin.vim', {
        \ 'on_map': ['gS','gJ']
        \})

  call dein#add('Yggdroot/indentLine', {
        \ 'hook_add': "
        \  let g:indentLine_char = '┆'\n
        \  let g:indentLine_indentLevel = 20\n
        \  let g:indentLine_bufNameExclude = ['terminal']
        \"})
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Javascript {{{
" ------------------------------------------------------------------------------
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('Raimondi/delimitMate')
  call dein#add('dsawardekar/ember.vim')
  call dein#add('pangloss/vim-javascript')
  " call dein#add('othree/yajs.vim')
  call dein#add('JarrodCTaylor/vim-ember-cli-test-runner', {
        \'on_cmd': [
        \  'RunAllEmberTests',
        \  'RunSingleEmberTest',
        \  'RunSingleEmberTestModule',
        \  'RerunLastEmberTests'
        \]})
  call dein#add('isRuslan/vim-es6')
  call dein#add('mxw/vim-jsx')
  call dein#add('maksimr/vim-jsbeautify')
  call dein#add('beautify-web/js-beautify')
  call dein#add('othree/javascript-libraries-syntax.vim', {
        \ 'hook_add': "
        \   let g:used_javascript_libs = 'underscore,backbone,react,flux'
        \"})
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Navigation {{{
" ------------------------------------------------------------------------------
   "TODO: replace with vim-sneak
   call dein#add('Lokaltog/vim-easymotion', {
        \ 'on_map': [['n', '<plug>']],
        \ 'hook_add': "
        \   map <Leader> <plug>(easymotion-prefix)\n
        \   nmap <leader><leader> <Plug>(easymotion-s)
        \"})

  call dein#add('junegunn/fzf', { 'build': './install --all', 'rtp': '' })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  " unite / denite
  " call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  " call dein#add('Shougo/unite.vim')
  " call dein#add('Shougo/neoyank.vim')
  " call dein#add('basyura/unite-rails')
  " call dein#add('Shougo/unite-session')
  " call dein#add('osyo-manga/unite-quickfix')
  " call dein#add('Shougo/neomru.vim')
  " call dein#add('Shougo/unite-help')
  " call dein#add('Shougo/vimfiler.vim', {
  "       \ 'lazy': 1,
  "       \ 'on_cmd': 'VimFiler',
  "       \ 'hook_source': "
  "       \  let g:vimfiler_as_default_explorer = 1\n
  "       \  let g:vimfiler_tree_opened_icon = ' '\n
  "       \  let g:vimfiler_tree_closed_icon = ' '\n
  "       \  let g:vimfiler_marked_file_icon = ' ✓'\n
  "       \  let g:vimfiler_readonly_file_icon = ' '\n
  "       \  call vimfiler#custom#profile('default', 'context', { 'safe' : 0 })
  "       \"})

  " call dein#add('scrooloose/nerdtree', {
  "       \ 'on_cmd': 'NERDTree',
  "       \ 'hook_add': "
  "       \   let g:NERDTreeDirArrowExpandable = ''\n
  "       \   let g:NERDTreeDirArrowCollapsible = ''
  "       \"})
  " call dein#add('Xuyuanp/nerdtree-git-plugin', { 'depends': 'nerdtree' })

  call dein#add('moll/vim-bbye')

  call dein#add('dangerzone/ranger.vim', {
        \ 'depends': 'vim-bbye',
        \ 'on_func': 'OpenRanger',
        \ 'hook_add': "
        \   command! Ranger call OpenRanger()\n
        \   no <silent> <leader>fe :call OpenRanger()<CR>\n
        \"})

  call dein#add('airblade/vim-rooter')
  " call dein#add('mhinz/vim-signify')
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Ruby {{{
" ------------------------------------------------------------------------------
  call dein#add('tpope/vim-bundler')
  call dein#add('tpope/vim-cucumber')
  call dein#add('tpope/vim-rails')

  call dein#add('thoughtbot/vim-rspec')
  call dein#add('ngmy/vim-rubocop')
  call dein#add('vim-ruby/vim-ruby', {
        \ 'hook_add': "
        \   let g:rubycomplete_classes_in_global = 1\n
        \   let g:rubycomplete_rails = 1\n
        \"})
  call dein#add('subbarao/vim-rubybeautifier')
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" TODO:VersionControl {{{
" ------------------------------------------------------------------------------
  call dein#add('tpope/vim-git') " Vim runtime files and syntax highlighting
  call dein#add('int3/vim-extradite', {
        \ 'hook_add': 'let g:gitgutter_eager=0'
        \})

  call dein#add('mattn/gist-vim', {
        \ 'on_cmd': 'Gist',
        \ 'hook_add': "
        \   let g:gist_clip_command = 'pbcopy'\n
        \   let g:gist_detect_filetype = 1\n
        \   let g:gist_show_privates = 1\n
        \   let g:gist_update_on_write = 1
        \"})
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Web {{{
" ------------------------------------------------------------------------------
  call dein#add('mattn/webapi-vim')
  call dein#add('cakebaker/scss-syntax.vim')
  call dein#add('hail2u/vim-css3-syntax')
  call dein#add('ap/vim-css-color')
  call dein#add('rizzatti/dash.vim', { 'on_cmd': 'Dash' })
  call dein#add('tpope/vim-haml')
  call dein#add('aquach/vim-http-client')
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" TODO:Window Management {{{
" ------------------------------------------------------------------------------
  call dein#add('zhaocai/GoldenView.Vim')


  " Smarts around killing buffers.
  " will close the split if it's the last buffer in
  " it, and close vim if it's the last buffer/split. Use ,w
  call dein#add('aaronjensen/vim-command-w', {
        \ 'on_cmd': 'CommandW',
        \ 'hook_add': 'nnoremap <silent><leader>wc :CommandW<CR>'
        \})

  " Maximizes windows and restores them afterwards
  call dein#add('szw/vim-maximizer', {
        \ 'on_cmd': 'MaximizerToggle',
        \ 'hook_add': 'nnoremap <silent><leader>wz :MaximizerToggle<CR>'
        \})

  call dein#add('zefei/vim-wintabs', {
        \ 'hook_add': "
        \   let g:wintabs_ui_sep_leftmost = ' '\n
        \   let g:wintabs_ui_sep_inbetween = '|'\n
        \   let g:wintabs_ui_sep_rightmost = ' '\n
        \   let g:wintabs_ui_active_left = ' '\n
        \   let g:wintabs_ui_active_right = ' '\n
        \"})
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Misc {{{
" ------------------------------------------------------------------------------

  call dein#add('chrisbra/CheckAttach', {
        \ 'hook_add': "
        \   let g:attach_check_keywords = ',bijlage,bijlagen,pdf,word,docx'\n
        \   let g:checkattach_filebrowser = 'ranger --choosefiles=%s'
        \"})
  call dein#add('junegunn/limelight.vim')
  call dein#add('junegunn/goyo.vim', {
        \ 'depends': 'limelight.vim',
        \ 'hook_add': "
        \   nnoremap <leader>tw :Goyo<cr>\n
        \   let g:goyo_width = 110
        \"})

  function! s:goyo_enter()
    " silent !tmux set status off
    " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
    " ...
  endfunction

  function! s:goyo_leave()
    " silent !tmux set status on
    " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
    " ...
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Misc {{{
" ------------------------------------------------------------------------------
 call dein#add('ryanoasis/vim-devicons')
" }}}
" ------------------------------------------------------------------------------

  call dein#end()
  call dein#call_hook('source') " call hooks of non lazy plugins
  call dein#save_state() " Save dein state (cache)
endif

filetype plugin indent on

if !has('vim_starting') && dein#check_install()
  " Installation check.
  let g:dein#types#git#default_protocol = "ssh"
  call dein#install() " install plugins that aren't installed yet
  call dein#remote_plugins() " Install remote plugins
  call dein#check_lazy_plugins() " check for lazy plugins that don't have /plugin

  source $MYVIMRC
endif

"call map(dein#check_clean(), "delete(v:val, 'rf')") " remove unused/disabled plugins

" }}}
"==============================================================================

" ==============================================================================
" taps {{{
" ==============================================================================

if dein#tap('vim-rails') "{{{
    nnoremap <leader>r <c-u>:Rrunner<CR>
    let g:rails_projections = {
      \"app/models/*.rb": {
      \  "alternate": ["spec/integration/models/%s_spec.rb"],
      \},
      \"app/controllers/*.rb": {
      \  "alternate": ["spec/integration/controllers/%s_spec.rb"],
      \},
      \"spec/integration/models/*_spec.rb": {
      \  "alternate": ["app/models/%s.rb"],
      \},
      \"spec/integration/controllers/*_spec.rb": {
      \  "alternate": ["app/controllers/%s.rb"],
      \},
      \"lib/support/app/controllers/support/*.rb": {
      \  "alternate": ["lib/support/spec/controllers/support/%s_spec.rb"]
      \},
      \"lib/support/spec/controllers/support/*_spec.rb": {
      \  "alternate": ["lib/support/app/controllers/support/%s.rb"]
      \},
    \}
  endif "}}}

if dein#tap('GoldenView.Vim') "{{{
    " Settings {{{
      let g:goldenview__enable_default_mapping = 0
      let g:goldenview__enable_at_startup = 0
      let g:goldenview__ignore_urule = {
      \  'filetype': [
      \    'nerdtree',
      \    'nerd',
      \    'unite'
      \  ],
      \  'buftype': [
      \    'nofile',
      \    'nerd',
      \    'nerdtree',
      \    'terminal'
      \  ]
      \}

      let g:goldenview__restore_urule= {
      \  'filetype': [
      \    'nerdtree',
      \    'nerd',
      \    'unite',
      \    'gitcommit'
      \  ],
      \  'buftype': [
      \    'nofile',
      \    'nerd',
      \    'nerdtree',
      \    'terminal',
      \    'gitcommit'
      \  ]
      \}
    " }}}

    " Functions {{{
      function! GoldenViewNext()
        execute "normal \<Plug>GoldenViewNext"
      endfunction

      function! GoldenViewPrevious()
        execute "normal \<Plug>GoldenViewPrevious"
      endfunction
    " }}}

    " Keybindings {{{
      " 1. split to tiled windows
      " nmap <silent> <leader>wv <plug>GoldenViewSplit
      nmap <silent> <leader>wv :vs<cr>
      nmap <silent> <leader>ws :split<cr>

      " 2. quickly switch current window with the main pane and toggle back
      nmap <silent> <leader>wm <Plug>GoldenViewSwitchMain
      nmap <silent> <leader>wt <Plug>GoldenViewSwitchToggle

      " 4. manipulate splits
      nmap <leader>wt <C-W>T

      " nmap <leader>wj
      " 4. toggle auto resize
      nmap <silent> <leader>tg :ToggleGoldenViewAutoResize<CR>
    " }}}
  endif "}}}

if dein#tap('vim-signify') "{{{
  let g:signify_vcs_list = ['git']
  let g:signify_sign_add               = '+'
  let g:signify_sign_delete            = '_'
  let g:signify_sign_delete_first_line = '‾'
  let g:signify_sign_change            = '!'
  let g:signify_sign_changedelete      = g:signify_sign_change
endif "}}}

if dein#tap('fzf.vim') "{{{
  " Color/display options {{{
    " Default fzf layout
    " - down / up / left / right
    " - window (nvim only)
    let g:fzf_layout = { 'window': 'rightbelow 30new' }

    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

      function! s:fzf_statusline()
        " Override statusline as you like
        highlight fzf1 ctermfg=161 ctermbg=251
        highlight fzf2 ctermfg=23 ctermbg=251
        highlight fzf3 ctermfg=237 ctermbg=251
        setlocal statusline=%#fzf1#
      endfunction

      autocmd! User FzfStatusLine call <SID>fzf_statusline()
  " }}}

  " Ag search {{{
    function! s:ag_to_qf(line)
      let parts = split(a:line, ':')
      return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
            \ 'text': join(parts[3:], ':')}
    endfunction

    function! s:ag_handler(lines)
      if len(a:lines) < 2 | return | endif

      let cmd = get({'ctrl-s': 'split',
                   \ 'ctrl-v': 'vertical split',
                   \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
      let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

      let first = list[0]
      execute cmd escape(first.filename, ' %#\')
      execute first.lnum
      execute 'normal!' first.col.'|zz'

      if len(list) > 1
        call setqflist(list)
        copen
        wincmd p
      endif
    endfunction

    command! -nargs=* Agsearch call fzf#run({
    \ 'source':  printf('ag --nogroup --column --color "%s"',
    \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
    \ 'sink*':    function('<sid>ag_handler'),
    \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
    \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
    \            '--color hl:68,hl+:110',
    \ 'down':    '50%'
    \ })

  " }}}

  " rails routes {{{
    command! -nargs=* RailsRoutes call fzf#run({
    \ 'source':  'rails_routes',
    \ 'sink*':    function('<sid>ag_handler'),
    \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 3.. '.
    \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
    \            '--color hl:68,hl+:110',
    \ 'down':    '50%'
    \ })
  " }}}
  "

  " Jobs {{{

    function! s:jobs()
      if len(keys(g:jobs)) > 0
        return keys(g:jobs)
      else
        return []
      endif
    endfunction

    function! s:show_output(job)
      call g:jobs[''.a:job].get_output()
      wincmd j
      exec 'startinsert'
    endfunction

    command! -nargs=* Jobs call fzf#run({
    \ 'source':  <sid>jobs(),
    \ 'sink':    function('s:show_output'),
    \ 'options': '-m -x +s',
    \ 'down':    '50%'
    \ })
  "}}}

  " Files + devicons {{{
    function! Fzf_dev()
      function! s:files()
        let files = split(system($FZF_DEFAULT_COMMAND), '\n')
        return s:prepend_icon(files)
      endfunction

      function! s:prepend_icon(candidates)
        let result = []
        for candidate in a:candidates
          let filename = fnamemodify(candidate, ':p:t')
          let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
          call add(result, printf("%s %s", icon, candidate))
        endfor

        return result
      endfunction

      function! s:edit_file(item)
        let parts = split(a:item, ' ')
        let file_path = get(parts, 1, '')
        execute 'silent e' file_path
      endfunction

      call fzf#run({
            \ 'source': <sid>files(),
            \ 'sink':   function('s:edit_file'),
            \ 'options': '-m -x +s',
            \ 'window':  'rightbelow 20new' })
    endfunction
  " }}}

  " Keybindings {{{
    nnoremap <silent> <leader>fm :<C-u>call Fzf_dev()<CR>
    nnoremap <silent> <leader>b :<C-u>Buffers<CR>
    nnoremap <silent> <leader>s :<C-u>Windows<CR>
    nnoremap <silent> <leader>; :<C-u>BLines<CR>
    nnoremap <silent> <leader>. :<C-u>Lines<CR>
    nnoremap <silent> <leader>o :<C-u>BTags<CR>
    nnoremap <silent> <leader>O :<C-u>Tags<CR>
    nnoremap <silent> <leader>: :<C-u>Commands<CR>
    nnoremap <silent> <leader>? :<C-u>History<CR>
    nnoremap <silent> <leader>/ :<C-u>Agsearch<CR>
    nnoremap <silent> <leader>gl :<C-u>Commits<CR>
    nnoremap <silent> <leader>ga :<C-u>BCommits<CR>
    nnoremap <silent> <leader>gf :<C-u>GitFiles?<CR>

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)

    nnoremap <silent> <leader>rm :<C-u>FZF app/models<CR>
    nnoremap <silent> <leader>rc :<C-u>FZF app/controllers<CR>
    nnoremap <silent> <leader>rv :<C-u>FZF app/views<CR>
    nnoremap <silent> <leader>rl :<C-u>FZF ./lib<CR>

    nnoremap <silent> <leader>rs :<C-u>FZF spec<CR>
    nnoremap <silent> <leader>rsm :<C-u>FZF spec/integration/models<CR>
    nnoremap <silent> <leader>rsc :<C-u>FZF spec/integration/controllers<CR>

    nnoremap <silent> <leader>rf :<C-u>FZF spec/factories<CR>
    nnoremap <silent> <leader>rfi :<C-u>FZF spec/fixtures<CR>

    nnoremap <silent> <leader>rmi :FZF db/migrate<CR>
  " }}}
endif "}}}

if dein#tap('ctrlp.vim') "{{{
    "call dein#add('FelikZ/ctrlp-py-matcher') "faster matcher for ctrlp
    "call dein#add('sgur/ctrlp-extensions.vim') "provides yankring and CMDline history
    "call dein#add('iurifq/ctrlp-rails.vim') "provides rails.vim modes

    " Settings {{{
      let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
      let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'

      " let g:ctrlp_regexp = 1
      "
      let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'some_bad_symbolic_links',
        \ }

      let g:ctrlp_prompt_mappings = {
        \ 'PrtSelectMove("j")':   ['<c-n>'],
        \ 'PrtSelectMove("k")':   ['<c-p>'],
        \ 'PrtHistory(-1)':       ['<down>'],
        \ 'PrtHistory(1)':        ['<up>'],
        \}
    "}}}

    " Keybindings {{{
      nnoremap <leader>fm :<C-u>CtrlPMixed<CR>
      nnoremap <leader>ff :<C-u>CtrlP<CR>
      nnoremap <leader>b :<C-u>CtrlPBuffer<CR>
      nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

      nnoremap <leader>y :<C-u>CtrlPYankring<CR>
      nnoremap <leader>u :<C-u>CtrlPUndo<CR>
      nnoremap <leader>l :<C-u>CtrlPLine<CR>

      " CtrlP-Rails.vim bindings
      nnoremap <leader>rm :<C-u>CtrlPModels<CR>
      nnoremap <leader>rmi :<C-u>CtrlPMigrations<CR>
      nnoremap <leader>rc :<C-u>CtrlPControllers<CR>
      nnoremap <leader>rv :<C-u>CtrlPViews<CR>
      nnoremap <leader>rs :<C-u>CtrlPSpecs<CR>
      nnoremap <leader>rl :<C-u>CtrlPLibs<CR>
    "}}}
  endif "}}}

if dein#tap('vim-jsbeautify') "{{{
  "for Javascript
  autocmd FileType javascript,eruby.javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  autocmd FileType javascript,eruby.javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>

  "for html
  autocmd FileType html,html.javascript,eruby.html,handlebars noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  autocmd FileType html,html.javascript,eruby.html,handlebars vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>

  "for css or scss
  autocmd FileType css,scss noremap <buffer> <c-f> :call CSSBeautify()<cr>
  autocmd FileType css,scss vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
  endif "}}}

if dein#tap('neomake') "{{{
  autocmd! BufWritePost * Neomake

  let g:neomake_warning_sign = {
    \ 'text': '⚠',
    \ 'texthl': 'WarningMsg',
    \ }

  let g:neomake_error_sign = {
    \ 'text': '✖',
    \ 'texthl': 'ErrorMsg',
    \ }

  let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
  let g:neomake_javascript_enabled_makers = ['eslint']
endif "}}}

if dein#tap('vim-fugitive') "{{{
  nnoremap <silent> <leader>gs  :Gstatus<CR>
  nnoremap <silent> <leader>gd  :Gvdiff<CR>
  nnoremap <silent> <leader>gc  :Gcommit<CR>
  nnoremap <silent> <leader>gb  :Gblame<CR>
  nnoremap <silent> <leader>gp  :Git push<CR>
  nnoremap <silent> <leader>gr  :Gread<CR>
  nnoremap <silent> <leader>gw  :Gwrite<CR>
  nnoremap <silent> <leader>gwq :Gwrite<CR>:qa<CR>
  nnoremap <silent> <leader>ge  :Gedit<CR>

  " Automatically remove fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif


if dein#tap('emmet-vim')
  imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")
  let g:user_emmet_next_key='<C-n>'
  let g:user_emmet_install_global = 1
  let g:user_emmet_settings = {
        \'html.javascript' : {
          \'extends' : 'html',
          \'filters' : 'html'
        \}
      \}
endif "}}}

if dein#tap('deoplete.nvim') "{{{
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#omni#input_patterns = {}
  let g:deoplete#omni#input_patterns.ruby =
  \ ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
  let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'

  let g:deoplete#enable_smart_case = 1

  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
endif "}}}

if dein#tap('unite.vim') "{{{

  call dein#disable('fzf')
  call dein#disable('fzf.vim')

  let g:unite_data_directory='~/.nvim/.cache/unite'
  let g:unite_source_history_yank_enable=1
  let g:unite_prompt='❯ '
  let g:unite_source_menu_menus = {}

  " Using ag as recursive command.
  " let g:unite_source_rec_async_command =
  "       \ ['ag', '--follow', '--nocolor', '--nogroup',
  "       \  '--hidden', '-g', '']
  let g:unite_source_rec_async_command=
        \ ['ag', '--nocolor', '--nogroup',
        \  '--ignore', '.hg', '--ignore', '.svn', '--ignore', '.git', '--ignore', '.bzr',
        \  '--hidden', '-g', '']

  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore-dir .git --ignore *.log'
  let g:unite_source_grep_recursive_opt=''

  " bindings {{{
    nmap <leader>f [unite]
    nmap [unite] <nop>

    nnoremap <silent> [unite]e  :<C-u>VimFiler -no-split<CR>

    nnoremap <silent> [unite]m  :<C-u>Unite
          \ -start-insert -no-split file_rec/neovim:! buffer file_mru<CR>

    nnoremap <silent> [unite]r  :<C-u>Unite
          \ -no-split -buffer-name=recent file_mru<CR>

    nnoremap <silent> [unite]g  :<C-u>Unite
          \ file_rec/git:--cached:--others:--exclude-standard<CR>

    nnoremap <silenT> <leader>ur :<Plug>(unite_redraw)

    nnoremap <silent> <leader>y :<C-u>Unite
          \ -auto-resize -direction=botright
          \ -buffer-name=yanks history/yank<CR>

    nnoremap <silent> <leader>b :<C-u>Unite
          \ -no-split -buffer-name=buffers buffer<CR>

    nnoremap <silent> <Leader>h :<C-u>Unite
          \ -auto-resize -buffer-name=help help<CR>

    nnoremap <silent> <leader>/ :<C-u>Unite -no-quit -buffer-name=search grep:.<CR>

  " }}}

  " Git fugitive menu {{{
    let g:unite_source_menu_menus.git = {
      \ 'description' : '            Manage Git repositories
          \                            ⌘ [space]g',
      \}
    let g:unite_source_menu_menus.git.command_candidates = [
      \['▷ tig                                                        ⌘ ,gt',
          \'normal ,gt'],
      \['▷ git status       (Fugitive)                                ⌘ ,gs',
          \'Gstatus'],
      \['▷ git diff         (Fugitive)                                ⌘ ,gd',
          \'Gdiff'],
      \['▷ git commit       (Fugitive)                                ⌘ ,gc',
          \'Gcommit'],
      \['▷ git log          (Fugitive)                                ⌘ ,gl',
          \'exe "silent Glog | Unite quickfix"'],
      \['▷ git blame        (Fugitive)                                ⌘ ,gb',
          \'Gblame'],
      \['▷ git stage        (Fugitive)                                ⌘ ,gw',
          \'Gwrite'],
      \['▷ git checkout     (Fugitive)                                ⌘ ,go',
          \'Gread'],
      \['▷ git rm           (Fugitive)                                ⌘ ,gr',
          \'Gremove'],
      \['▷ git mv           (Fugitive)                                ⌘ ,gm',
          \'exe "Gmove " input("destination: ")'],
      \['▷ git push         (Fugitive, output buffer)                 ⌘ ,gp',
          \'Git! push'],
      \['▷ git pull         (Fugitive, output buffer)                 ⌘ ,gP',
          \'Git! pull'],
      \['▷ git prompt       (Fugitive, output buffer)                 ⌘ ,gi',
          \'exe "Git! " input("git command: ")'],
      \['▷ git cd           (Fugitive)',
          \'Gcd'],
      \]
    nnoremap <silent><leader>g :Unite -silent -start-insert menu:git<CR>
  " }}}

  " Custom mappings for the unite buffer
  autocmd FileType unite call s:unite_settings()

  function! s:unite_settings() "{{{
    " Enable navigation with control-n and control-p in insert mode
    imap <buffer> <C-n>       <Plug>(unite_select_next_line)
    imap <buffer> <C-p>       <Plug>(unite_select_previous_line)

    imap <buffer> <esc>       <Plug>(unite_exit)
    nmap <buffer> <esc>       <Plug>(unite_exit)

    nmap <buffer> <left>      <Plug>(unite_exit)
    nmap <buffer> <right>     <Plug>(unite_do_default_action)

    nmap <buffer><expr> <C-h> unite#do_action('split')
    imap <buffer><expr> <C-h> unite#do_action('split')

    nmap <buffer><expr> <C-v> unite#do_action('vsplit')
    imap <buffer><expr> <C-v> unite#do_action('vsplit')

    nmap <buffer><expr> <C-t> unite#do_action('tabopen')
    imap <buffer><expr> <C-t> unite#do_action('tabopen')

    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '(\.meta$|\.tmp)')
  endfunction "}}}

endif "}}}

if dein#tap('vimfiler.vim') "{{{
  autocmd FileType vimfiler call <SID>VimfilerSetup()
  function! s:VimfilerSetup()
    nnoremap <buffer> <silent> <Esc> :bd<CR>
    nmap <buffer> <silent> f <Plug>(vimfiler_find)

    nnoremap <silent><buffer><expr> v
          \ vimfiler#do_switch_action('vsplit')
    nnoremap <silent><buffer><expr> s
          \ vimfiler#do_switch_action('split')
  endfunction
endif "}}}

" }}}
" ==============================================================================

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
    " set showtabline=2
    set guioptions-=e

    autocmd BufEnter,WinEnter,VimEnter,BufRead * let w:getcwd = getcwd()
    let &statusline = " %{SessionFlag()} "
    let &statusline .= "\ue0b1 %<%f "
    let &statusline .= "%{&readonly ? \"\ue0a2 \" : &modified ? ' ' : ''}"
    let &statusline .= "%=\u2571 %{&filetype == '' ? 'unknown' : &filetype} "
    let &statusline .= "\u2571 %p%% \u2571 col %c "

    function! SessionFlag()
      if dein#is_sourced('vim-session')
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
        return "\ue0b1  ".strpart(git, strlen(git)-30)." "
      else
        return ""
      endif
    endfunction

    function! FiletypeFlag()
      let filename = expand('%F')
      return WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
    endfunction

    function! Paste()
      if &paste
        return ' ⚠ PASTE '
      else
        return ''
      endif
    endfunction

    function! Spell()
      if &spell
        return ' ⚠ SPELL '
      else
        return ''
      endif
    endfunction
  " }}}
" ==============================================================================

autocmd BufRead,BufNewFile *.* IndentLinesReset
" ==============================================================================
" Include user's local vim config {{{
" ==============================================================================
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
" }}}
" ==============================================================================
