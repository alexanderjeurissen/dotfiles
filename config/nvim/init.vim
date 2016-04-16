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
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
  " let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let python3_host_prog = "python3"
  let python_host_prog = "python"
  " let g:ruby_host_prog = "ruby"
  " runtime! plugin/python_setup.vim
endif

" Statusline {{{
    set laststatus=2
    set showtabline=1
    set guioptions-=e

    let g:currentmode={
        \ 'n'  : 'N ',
        \ 'no' : 'N·Operator Pending ',
        \ 'v'  : 'V ',
        \ 'V'  : 'V·Line ',
        \ '^V' : 'V·Block ',
        \ 's'  : 'Select ',
        \ 'S'  : 'S·Line ',
        \ '^S' : 'S·Block ',
        \ 'i'  : 'I ',
        \ 'R'  : 'R ',
        \ 'Rv' : 'V·Replace ',
        \ 'c'  : 'Command ',
        \ 'cv' : 'Vim Ex ',
        \ 'ce' : 'Ex ',
        \ 'r'  : 'Prompt ',
        \ 'rm' : 'More ',
        \ 'r?' : 'Confirm ',
        \ '!'  : 'Shell ',
        \ 't'  : 'Terminal '
        \}

    function! ReadOnly()
      if &readonly || !&modifiable
        return ''
      else
        return ''
      endif
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

    " Returns a warning flag if amount of added lines exceeds 20% of all lines
    function! CommitWarning()
      let [added, modified, removed] = sy#repo#get_stats()
      let lines=(line('$')+0)
      let changessum=(added+modified+removed) * 1.0
      if (changessum / lines) > 0.20
        return ' ⚠ COMMIT '
      else
        return ''
      endif
    endfunction

    let g:insert_mode = 0
    au InsertEnter * let g:insert_mode=1
    au InsertLeave * let g:insert_mode=0

    function! InsertWarning()
      if g:insert_mode == 1
        return ' ⚠ INSERT '
      else
        return ''
      endif
    endfunction

    function! Segment(colorgroup, content)
      return '%' . a:colorgroup . '*' . a:content . '%*'
    endfunction

    function! Flag(colorgroup, content)
      return '%' . a:colorgroup . '*' . a:content . '%*%2* %*'
    endfunction

    function! DoubleSegment(labelColor, contentColor, label, content)
      return ' %' . a:labelColor . '*' . a:label . '%*'.
              \'%' . a:contentColor . '*' . a:content . '%* '
    endfunction

    function! SetSegmentsColorGroups()

    if has_key(g:plugs, 'vim-gotham')
      " black on blue
      hi! User1 ctermfg=10 ctermbg=14

      " blue on black
      hi! User2 ctermfg=14 ctermbg=10

      " purple on black
      hi! User3 ctermfg=10 ctermbg=5

      " don't show at all with User0
      hi! statusline ctermbg=0

      "black on red
      hi! User4 ctermfg=10 ctermbg=9
      "black on green
      hi! User5 ctermfg=10 ctermbg=2
      "black on yellow
      hi! User6 ctermfg=10 ctermbg=3

      " red on black
      hi! User7 ctermfg=9 ctermbg=10
      " green on black
      hi! User8 ctermfg=2 ctermbg=10
      " yellow on black
      hi! User9 ctermfg=3 ctermbg=10
    elseif has_key(g:plugs, 'base16-vim')
      " don't show at all with User0
      hi! statusLine ctermfg=13 ctermbg=13

      " black on blue
      hi! User1 ctermfg=10 ctermbg=14

      " blue on statusbar
      hi! User2 ctermfg=4 ctermbg=13

      " purple status flag
      hi! User3 term=underline cterm=underline ctermfg=14 ctermbg=15

      " red status flag
      hi! User4 term=underline cterm=underline ctermfg=9 ctermbg=15

      " green status flag
      hi! User5 term=underline cterm=underline ctermfg=2 ctermbg=15

      " yellow status flag
      hi! User6 term=underline cterm=underline ctermfg=3 ctermbg=15

      " red on statusbar
      hi! User7 ctermfg=9 ctermbg=13

      " green on statusbar
      hi! User8 ctermfg=2 ctermbg=13

      " yellow on statusbar
      hi! User9 ctermfg=3 ctermbg=13
    endif
    endfunction

    let &statusline=''
    let &statusline.=Segment(8, ' %n ')                       " bufnr
    let &statusline.=Flag(4, '%{Paste()}')                    " paste warning
    " let &statusline.=Flag(5, '%{CommitWarning()}')            " paste warning
    " let &statusline.=Flag(6, '%{InsertWarning()}')          " insert mode warning
    let &statusline.=Flag(6, '%{Spell()}')                    " Spell warning
    let &statusline.=Segment(2, ' %<%F %{ReadOnly()} %m %w')   " File path
    let &statusline.=Segment(0, '%=')                            " Space
    " let &statusline.=DoubleSegment(3,4,' ⎇ ', ' %{GitInfo()}') " Git info
    let &statusline.=Segment(2, ' %{&ff}%y ')                    " FileType
    let &statusline.=Segment(8, ' %2c ')                         " Rownumber/total (%)

    autocmd ColorScheme * call SetSegmentsColorGroups()
  " }}}

" TabLine {{{
" segment functions are in the statusline fold
  function! FetchGitStatus()
    let projectroot=projectroot#get(expand('%'))
    let g:status=system('~/.config/nvim/vcs_status/status.sh '.projectroot)
    if g:status != ''
      let status_list=split(g:status,",")
      let g:vcs_staged=status_list[0]
      let g:vcs_modified=status_list[1]
      let g:vcs_others=status_list[2]
    else
      let g:vcs_staged=0
      let g:vcs_modified=0
      let g:vcs_others=0
    endif
  endfunction

  function! GitStaged()
    if g:vcs_staged != 0
      return DoubleSegment(5, 8,  ' ⊕ ', ' '.g:vcs_staged)
    else
      return ''
    endif
  endfunction

  function! GitModified()
    if g:vcs_modified != 0
      return Segment(6, ' + '.g:vcs_modified)
    else
     return ''
    endif
  endfunction

  function! GitOthers()
    if g:vcs_others != 0
      return Segment(4, ' ~ '.g:vcs_others)
    else
      return ''
    endif
  endfunction

  function! GitBranch()
    let git = fugitive#head()
    if git != ''
      return ''.Segment(7, ' ⎇ '.strpart(git, strlen(git)-30))
    else
      return ''
    endif
  endfunction

  function! MyTabLine()
      let s = ''
      let t = tabpagenr()
      let i = 1
      while i <= tabpagenr('$')
          let buflist = tabpagebuflist(i)
          let winnr = tabpagewinnr(i)
          let s .= '%' . i . 'T'
          let s .= (i == t ? '%1*' : '%2*')

          " let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
          " let s .= ' '
          let s .= (i == t ? '%#TabNumSel#' : '%#TabNum#')
          let s .= ' ' . i . ' '
          let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

          let bufnr = buflist[winnr - 1]
          let file = bufname(bufnr)
          let buftype = getbufvar(bufnr, '&buftype')

          if buftype == 'help'
              let file = 'help:' . fnamemodify(file, ':t:r')

          elseif buftype == 'quickfix'
              let file = 'quickfix'

          elseif buftype == 'nofile'
              if file =~ '\/.'
                  let file = substitute(file, '.*\/\ze.', '', '')
              endif

          else "show current working directory
              let file = pathshorten(fnamemodify(file, ':p:~:.:h'))
              if file == '.'
                let file = pathshorten(fnamemodify(getcwd(), ':~'))
              endif
              if getbufvar(bufnr, '&modified')
                  let file = '+' . file
              endif

          endif

          if file == ''
              let file = '[No Name]'
          endif

          let s .= ' ' . file

          let nwins = tabpagewinnr(i, '$')
          if nwins > 1
              let modified = ''
              for b in buflist
                  if getbufvar(b, '&modified') && b != bufnr
                      let modified = '*'
                      break
                  endif
              endfor
              let hl = (i == t ? '%#WinNumSel#' : '%#WinNum#')
              let nohl = (i == t ? '%#TabLineSel#' : '%#TabLine#')
              let s .= ' ' . modified . '(' . hl . winnr . nohl . '/' . nwins . ')'
          endif

          if i < tabpagenr('$')
              let s .= ' %#TabLine#%*'
          else
              let s .= ' '
          endif

          let i = i + 1

      endwhile

      call FetchGitStatus()

      let s .= '%T%#TabLineFill#%='
      " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
      " Right side esting
       " let s .= GitDiverge()
       let s .= GitStaged()
       let s .= ' '
       let s .= GitModified()
       let s .= ' '
       let s .= GitOthers()
       let s .= ' '
       let s .= GitBranch()
      return s
  endfunction

  set tabline=%!MyTabLine()

  function! SetTablineHighlights()
    highlight! TabNum term=bold cterm=bold ctermfg=4 ctermbg=15
    highlight! TabNumSel term=bold cterm=bold ctermfg=13 ctermbg=4
    highlight! TabLine ctermbg=15
    highlight! TabLineSel term=bold cterm=bold ctermfg=4 ctermbg=13
    highlight! WinNum term=bold cterm=bold ctermfg=7 ctermbg=15
    highlight! WinNumSel term=bold cterm=bold ctermfg=10 ctermbg=13
  endfunction

  autocmd Colorscheme * call SetTablineHighlights()
" }}}

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
command! Q q

command! QA qa
command! Qa qa

" Execute macro under key `a` for all buffers and write afterwards
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

" Toggle highlight search with <leader>hl
nnoremap <leader>hl :set hlsearch!<CR>

" close buffer with leader-q
" and safe & close buffer with leader-wq
nnoremap <leader>q :bd<CR>
nnoremap <leader>wq :w<CR>:bd<CR>

" Call ArcLint using :ArcLint
command! -nargs=* ArcLint call s:ArcLint("<args>")
command! PasteCode call s:PasteCode()
" }}}
" ==============================================================================

" ==============================================================================
" General AutoCommands {{{
" ============================================================================

" Automatically remove trailing whitespaces unless file is blacklisted
autocmd BufWritePre *.* :call Preserve("%s/\\s\\+$//e")
autocmd BufRead init.vim set foldmethod=marker
autocmd FileType gitcommit setlocal textwidth=70
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

  " Automatically wrap at 80 characters for Markdown, ruby, css and coffescript
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  autocmd BufRead,BufNewFile *.erb setlocal textwidth=100
  autocmd BufRead,BufNewFile *.rb setlocal textwidth=100
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

  " Automatically remove trailing whitespaces unless file is blacklisted
  autocmd BufWritePre *.* :call Preserve("%s/\\s\\+$//e")

  " Add coffeescript highlighting to coffee.cjsx files
  autocmd BufRead,BufNewFile *.coffee.cjsx set filetype=coffee.html

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
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

  silent exe ":UniteSessionSave " . fname
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
" Vim-Plug {{{
" ============================================================================

set nocompatible               " Be iMproved

"Note: install vim-plug if not present
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall
endif

"Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif
if has('vim_starting')
  set nocompatible               " Be iMproved
  " Required:
  call plug#begin()
endif

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
" statement that checks if the given plugin is enabled. Vim-Plug automatically
" adds enabled plugins to a dictionary `g:plugs`
" to check if a plugin is enabled use `has_key(g:plugs, 'plugin_name')`

" ------------------------------------------------------------------------------
" AutoCompletion {{{
" ------------------------------------------------------------------------------
  Plug 'mattn/emmet-vim' "{{{
  if has_key(g:plugs, 'emmet-vim')
    " Settings {{{
      let g:user_emmet_install_global = 1
      imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")
      let g:user_emmet_next_key='<C-n>'

      let g:user_emmet_settings = {
      \  'html.javascript' : {
      \    'extends' : 'html',
      \    'filters' : 'html',
      \  }
      \}
    "}}}
  endif "}}}
  " Plug 'Shougo/neocomplete' "{{{
  if has_key(g:plugs, 'neocomplete')
    " Settings {{{
      let g:acp_enableAtStartup = 0
      let g:neocomplete#enable_at_startup = 1
      let g:neocomplete#enable_smart_case = 1
      let g:neocomplete#enable_auto_delimiter = 1
      let g:neocomplete#max_list = 15
      let g:neocomplete#force_overwrite_completefunc = 1

      " Enable omni completion.
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

      " Enable heavy omni completion.
      if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
      endif

      " Define dictionary.
      let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

      " Define keyword.
      if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
      endif

      let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    "}}}
  endif "}}}
  Plug 'Shougo/deoplete.nvim' "{{{
  if has_key(g:plugs, 'deoplete.nvim')
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
  endif"}}}


  let g:monster#completion#rcodetools#backend = "async_rct_complete"
  Plug 'tpope/vim-repeat'
  Plug 'tomtom/tlib_vim'
  Plug 'SirVer/ultisnips' "{{{
  if has_key(g:plugs, 'ultisnips')
    " Settings {{{
      " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
      let g:UltiSnipsExpandTrigger="<tab>"
      let g:UltiSnipsJumpForwardTrigger="<c-n>"
      let g:UltiSnipsJumpBackwardTrigger="<c-p>"
      let g:UltiSnipsListSnippets="<c-tab>"

      " If you want :UltiSnipsEdit to split your window.
      let g:UltiSnipsEditSplit="vertical"
    "}}}
  endif "}}}
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'alexanderjeurissen/vim-react-snippets'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ColorSchemes {{{
" ------------------------------------------------------------------------------
  Plug 'chriskempson/base16-vim' "{{{
  if has_key(g:plugs, 'base16-vim')
      function! SolarizeCustomization()
        let g:solarized_visibility = "high"
        let g:solarized_contrast = "high"
        let g:solarized_termtrans = 1

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

        if g:solarized_flux == 1
          let hour = strftime("%H") " Set the background light from 7am to 7pm
          if 7 <= hour && hour < 17
            set background=light
          else " Set to dark from 7pm to 7am
            set background=dark
          endif
        endif

        hi! clear SignColumn
        hi! link SignColumn CursorColumn
      endfunction

      function! ActivateColorScheme()
        colorscheme base16-solarized
        let g:solarized_flux = 0
        call SolarizeCustomization()
        set background=light
      endfunction
  endif "}}}
  " Plug 'whatyouhide/vim-gotham' "{{{
  if has_key(g:plugs, 'vim-gotham')
      function! ActivateColorScheme()
        colorscheme gotham
        set background=dark
      endfunction
  endif "}}}
  " Plug 'morhetz/gruvbox' "{{{
  if has_key(g:plugs, 'gruvbox')
    " Settings {{{
      let g:airline_theme = 'gruvbox'
      let g:gruvbox_contrast_light = 'medium'
    "}}}
  endif "}}}
  " Plug 'junegunn/seoul256.vim' "{{{
  if has_key(g:plugs, 'seoul256.vim')
    " Settings {{{
      let g:airline_theme = 'bubblegum'
    "}}}
  endif "}}}
  Plug 'ryanoasis/vim-devicons'
Plug 'vheon/vim-cursormode' "{{{
if has_key(g:plugs, 'vim-cursormode')
let cursormode_color_map = {
      \   "n":      "#8bbebb",
      \   "i":      "#edb442",
      \   "v":      "#888ca6",
      \   "V":      "#888ca6",
      \   "\<C-V>": "#888ca6",
      \   "R":      "#d26936",
      \ }
endif "}}}
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Core {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-fugitive' "{{{
  if has_key(g:plugs, 'vim-fugitive')
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd  :Gvdiff<CR>
    nnoremap <silent> <leader>gc  :Gcommit<CR>
    nnoremap <silent> <leader>gb  :Gblame<CR>
    nnoremap <silent> <leader>gl  :Glog<CR>
    nnoremap <silent> <leader>gp  :Git push<CR>
    nnoremap <silent> <leader>gr  :Gread<CR>
    nnoremap <silent> <leader>gw  :Gwrite<CR>
    nnoremap <silent> <leader>gwq  :Gwrite<CR>:qa<CR>
    nnoremap <silent> <leader>ge  :Gedit<CR>

    " Automatically remove fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete
  endif "}}}
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-dispatch'
  Plug 'radenling/vim-dispatch-neovim'
  Plug 'MarcWeber/vim-addon-local-vimrc'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Editing {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-endwise'
  Plug 'tommcdo/vim-exchange'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'tpope/vim-surround'
  Plug 'benekastah/neomake' "{{{
  if has_key(g:plugs, 'neomake')
    " Settings {{{
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
    "}}}
  endif "}}}
  Plug 'vim-scripts/tComment'
  Plug 'osyo-manga/vim-over' "{{{
  if has_key(g:plugs, 'vim-over')
    let g:over#command_line#paste_escape_chars = '/.*$^~'
    command! Replace OverCommandLine %s/
  endif "}}}
  Plug 'editorconfig/editorconfig-vim'
  " Plug '907th/vim-auto-save' "{{{
  if has_key(g:plugs, 'vim-auto-save')
    let g:auto_save = 0
    let g:auto_save_silent = 1
    let g:auto_save_in_insert_mode = 0
  endif "}}}
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Javascript {{{
" ------------------------------------------------------------------------------
  Plug 'burnettk/vim-angular'
  Plug 'kchmck/vim-coffee-script'
  Plug 'Raimondi/delimitMate'
  Plug 'dsawardekar/ember.vim'
  Plug 'pangloss/vim-javascript' "{{{
  if has_key(g:plugs, 'vim-javascript')
    let g:javascript_conceal_function   = "ƒ"
    let g:javascript_conceal_null       = "ø"
    let g:javascript_conceal_this       = "@"
    let g:javascript_conceal_return     = "⇚"
    let g:javascript_conceal_undefined  = "¿"
    let g:javascript_conceal_NaN        = "ℕ"
    let g:javascript_conceal_prototype  = "¶"
    let g:javascript_conceal_static     = "•"
    let g:javascript_conceal_super      = "Ω"
  endif "}}}
  Plug 'JarrodCTaylor/vim-ember-cli-test-runner'
  Plug 'isRuslan/vim-es6'
  Plug 'mxw/vim-jsx'
  Plug 'maksimr/vim-jsbeautify' | Plug 'beautify-web/js-beautify' "{{{
  if has_key(g:plugs, 'vim-jsbeautify')
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
  Plug 'othree/javascript-libraries-syntax.vim' "{{{
  if has_key(g:plugs, 'javascript-libraries-syntax.vim')
    let g:used_javascript_libs = 'underscore,backbone,react,flux'
  endif
  "}}}
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Navigation {{{
" ------------------------------------------------------------------------------
  Plug 'rking/ag.vim' "{{{
  if has_key(g:plugs, 'ag.vim')
    " Keybindings {{{
      "map Silver Searcher
        noremap <leader>ag :Ag!<space>
      "search for word under cursor with Silver Searcher
        noremap <leader>Ag :Ag! "<C-r>=expand('<cword>')<CR>"

      " quick go to next match in quickfix window
        noremap <leader>cn :cnext<CR>
        noremap <leader>cp :cprev<CR>
    "}}}
  endif "}}}

  " Plug 'ctrlpvim/ctrlp.vim' "{{{
  if has_key(g:plugs, 'ctrlp.vim')
    Plug 'FelikZ/ctrlp-py-matcher' "faster matcher for ctrlp
    Plug 'sgur/ctrlp-extensions.vim' "provides yankring and CMDline history
    Plug 'iurifq/ctrlp-rails.vim' "provides rails.vim modes

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

  " Plug 'Lokaltog/vim-easymotion' "{{{
  if has_key(g:plugs, 'vim-easymotion')
    " Keybindings {{{
      "change leader leader defaults to just leader
      map <Leader> <Plug>(easymotion-prefix)
      "use s to activate easymotion
      nmap <leader><leader> <Plug>(easymotion-s)
    "}}}
  endif "}}}

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "{{{
  if has_key(g:plugs, 'fzf')
    Plug 'junegunn/fzf.vim'

    " Functions {{{
      function! SearchWordWithAg()
        execute 'Ag' expand('<cword>')
      endfunction

      function! SearchVisualSelectionWithAg() range
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        let old_clipboard = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', old_reg, old_regtype)
        let &clipboard = old_clipboard
        execute 'Ag' selection
      endfunction
    " }}}

    " Keybindings {{{
      nnoremap <silent> <leader>fm :<C-u>Files<CR>
      nnoremap <silent> <leader>b :<C-u>Buffers<CR>
      nnoremap <silent> <leader>s :<C-u>Windows<CR>
      nnoremap <silent> <leader>; :<C-u>BLines<CR>
      nnoremap <silent> <leader>. :<C-u>Lines<CR>
      nnoremap <silent> <leader>o :<C-u>BTags<CR>
      nnoremap <silent> <leader>O :<C-u>Tags<CR>
      nnoremap <silent> <leader>: :<C-u>Commands<CR>
      nnoremap <silent> <leader>? :<C-u>History<CR>
      nnoremap <silent> <leader>/ :<C-u>Ag<CR>
      nnoremap <silent> K :call SearchWordWithAg()<CR>
      vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
      nnoremap <silent> <leader>gl :<C-u>Commits<CR>
      nnoremap <silent> <leader>ga :<C-u>BCommits<CR>

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

  Plug 'dangerzone/ranger.vim' | Plug 'moll/vim-bbye' "{{{
  if has_key(g:plugs, 'ranger.vim')
    nmap <silent> <leader>f <C-u>:call OpenRanger()<CR>
    command! Ranger call OpenRanger()
  endif "}}}
  Plug 'danro/rename.vim'
  Plug 'airblade/vim-rooter'
  " Plug 'mhinz/vim-signify' "{{{
  if has_key(g:plugs, 'vim-signify')
    let g:signify_vcs_list = ['git']
    let g:signify_sign_add               = '+'
    let g:signify_sign_delete            = '_'
    let g:signify_sign_delete_first_line = '‾'
    let g:signify_sign_change            = '!'
    let g:signify_sign_changedelete      = g:signify_sign_change
  endif "}}}
  Plug 'christoomey/vim-tmux-navigator'
  " Plug 'scrooloose/nerdtree' "{{{
  if has_key(g:plugs, 'nerdtree')
    let NERDTreeCascadeOpenSingleChildDir=1
    let NERDTreeQuitOnOpen=1
    nnoremap <leader>fe :NERDTreeFind<cr>
  endif "}}}

" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Ruby {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-cucumber'
  Plug 'tpope/vim-rails' "{{{
  if has_key(g:plugs, 'vim-rails')
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
    \}
  endif "}}}

  Plug 'thoughtbot/vim-rspec'
  Plug 'Trevoke/ultisnips-rspec'
  Plug 'ngmy/vim-rubocop'
  Plug 'vim-ruby/vim-ruby' "{{{
  if has_key(g:plugs, 'vim-ruby')
    "autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  endif "}}}
  Plug 'subbarao/vim-rubybeautifier'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" VersionControl {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-git' " Vim runtime files and syntax highlighting
  Plug 'int3/vim-extradite' "{{{
  if has_key(g:plugs, 'vim-extradite')
    let g:gitgutter_eager=0
  endif "}}}

  Plug 'mattn/gist-vim' , { 'on': 'Gist' } "{{{
  if has_key(g:plugs, 'gist-vim')
    let g:gist_clip_command = 'pbcopy'
    let g:gist_detect_filetype = 1
    " let g:gist_open_browser_after_post = 1
    let g:gist_show_privates = 1
    " :w and :w! update a gist.
    let g:gist_update_on_write = 1
  endif "}}}
  Plug 'dbakker/vim-projectroot'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Web {{{
" ------------------------------------------------------------------------------
  Plug 'mattn/webapi-vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'
  Plug 'rizzatti/dash.vim'
  Plug 'tpope/vim-haml'
  Plug 'aquach/vim-http-client'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Window Managers {{{
" ------------------------------------------------------------------------------
  " Plug 'spolu/dwm.vim'
  Plug 'zhaocai/GoldenView.Vim' "{{{
  if has_key(g:plugs, 'GoldenView.Vim')
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
      \    'unite'
      \  ],
      \  'buftype': [
      \    'nofile',
      \    'nerd',
      \    'nerdtree',
      \    'terminal'
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

      " 3. move between splits
      nmap <leader>wl :<c-u>TmuxNavigateRight<cr>
      nmap <leader>wh :<c-u>TmuxNavigateLeft<cr>
      nmap <leader>wk :<c-u>TmuxNavigateUp<cr>
      nmap <leader>wj :<c-u>TmuxNavigateDown<cr>

      " 4. manipulate splits
      nmap <leader>wt <C-W>T

      " nmap <leader>wj
      " 4. toggle auto resize
      nmap <silent> <leader>tg :ToggleGoldenViewAutoResize<CR>
    " }}}
  endif "}}}

  Plug 'aaronjensen/vim-command-w' "{{{
  " Smarts around killing buffers.
  " will close the split if it's the last buffer in
  " it, and close vim if it's the last buffer/split. Use ,w
  if has_key(g:plugs, 'vim-command-w')
    nmap <leader>wc :CommandW<CR>
  endif
  "}}}
  "
" Plug 'simeji/winresizer' "{{{
if has_key(g:plugs, 'winresizer')
  nnoremap <leader>wr :call WinResizerStartResize()<cr>
  " let g:winresizer_start_key='<c-s>'
  let g:winresizer_finish_with_escape=1
  let g:winresizer_vert_resize=10
  let g:winresizer_horiz_resize=3
endif "}}}

" Plug 'Shougo/denite.nvim'
if has_key(g:plugs, 'denite.nvim')

endif
" }}}
" ------------------------------------------------------------------------------

call plug#end()
call ActivateColorScheme()
" }}}
" ==============================================================================

" ==============================================================================
" Start replacing tmux with nvim terminal splits {{{
" ==============================================================================
  let g:maximized=0
  func! MaximizeWindow()
    if g:maximized == 0
      let g:maximized=1
      exe "normal! \<C-w>_"
      exe "normal! \<C-w>|"
    else
      let g:maximized=0
      exe "normal! \<C-w>="
    endif
  endfunc

  nnoremap <leader>st :botright split<cr>:terminal<cr>
  nnoremap <leader>stv :botright vsplit<cr>:terminal<cr>
  nnoremap <leader>wz :call MaximizeWindow()<cr>
  tnoremap <leader><ESC> <C-\><C-n>

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

  " nnoremap <up> :call ResizeSplits('up')<CR><ESC>
  " nnoremap <down> :call ResizeSplits('down')<CR><ESC>
  " nnoremap <left> :call ResizeSplits('left')<CR><ESC>
  " nnoremap <right> :call ResizeSplits('right')<CR><ESC>

  " Window navigation between terminal and nonterminal
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  tnoremap <silent> <leader>wh <C-\><C-n><C-w>h
  tnoremap <silent> <leader>wj <C-\><C-n><C-w>j
  tnoremap <silent> <leader>wk <C-\><C-n><C-w>k
  tnoremap <silent> <leader>wl <C-\><C-n><C-w>l

  " Default workspace
  function! DefaultWorkspace()
    tabnew term://~/.dotfiles/scripts/startBackend
    file Backend:daemon

    vsp term://~/.dotfiles/scripts/startServices
    file Services:daemon

    vsp term://~/.dotfiles/scripts/startFrontend
    file Frontend:daemon
  endfunction

  command! -register StartAll call DefaultWorkspace()
" }}}
" ==============================================================================

" ==============================================================================
" Include user's local vim config {{{
" ==============================================================================
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.vimrc.local
  endif
" }}}
" ==============================================================================
