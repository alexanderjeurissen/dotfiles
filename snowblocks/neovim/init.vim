" SETTINGS: General {{{
  set packpath+=$VIM_CONFIG_PATH                     " Make sure pack installs in the right directory
  set path=$PWD/**                                   " Make :find more usable by default
  set wildmenu                                       " Show all matches when tab completing
  set wildmode=longest:list,full                     " Show longest match first
  set re=1                                           " Better for ruby (https://tinyurl.com/ll948jk)
  set noswapfile                                     " Disable swapfile (https://tinyurl.com/y9t8frrs)
  set showmode                                       " show mode in bottom-left corner
  set synmaxcol=200                                  " Only syntax highlight 200 chars (performance)
  set autowrite                                      " Write before running commands.
  set shortmess=aAIsT                                " Reduce |hit-enter| prompts.
  set cmdheight=2                                    " Number of screen lines for the command-line.
  set nowrap                                         " Don't wrap lines as it makes j/k unintuitive.
  set smartcase                                      " Search case incensitive.
  set textwidth=100                                  " Set maximum number of characters per line
  set sessionoptions+=resize                         " Changes the effect of the |:mksession| command.
  set sessionoptions+=globals                        " Persist global variables in vim session
  set cc=+1                                          " Highlight first column after 'textwidth'
  " set iskeyword-=_                                   " Treat underscore as a word boundary.

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

  set tabstop=2                                      " Number of spaces existing <Tab> is rendered as.
  set shiftwidth=2                                   " Number of spaces that >> and << count for.
  set softtabstop=2                                  " Number of spaces of <Tab> while editing.
  set expandtab                                      " Use spaces instead of <Tab> for indentation.
  set number                                         " Enable line numbers
  set relativenumber                                 " Make line numbers relative
  set numberwidth=5                                  " Set width of number column
  set splitbelow                                     " Open new split panes at bottommost position
  set splitright                                     " Open new split panes at rightmost position
  set inccommand=nosplit                             " Show visual indication when using substitute.
  set nofoldenable                                   " collapse all folds.
  set foldmethod=syntax                              " Fold on the syntax
  set foldcolumn=0                                   " Don't indicate fold open/closed (redundant info)
  set foldlevel=10                                   " Autofold nothing by default
  set foldnestmax=1                                  " Only fold outer functions

  set modeline                                       " automatically settings options based on file comment
  set confirm                                        " Makes operations like qa ask for confirmation.
  set t_vb=                                          " Disable visual bell.
  set cursorline cursorcolumn                        " Enable cursorline and cursorcolumn by default
  set scrolloff=2                                    " Keep at least 2 lines above/below
  set sidescrolloff=5                                " Keep at least 5 lines left/right

  " Open help in a new split instead of vimbuffer
  cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'rightbelow help' : 'h'

  let python3_host_prog = "python3"
  let python_host_prog = "python"
" }}}

" SETTINGS: statusline {{{
  set laststatus=2
  set guioptions-=e

  set statusline=%!statusline#Init()
" }}}

" SETTINGS: terminal {{{
  tnoremap <leader><ESC> <C-\><C-n>
" }}}

" SETTINGS: Colorscheme {{{
  if (has("termguicolors"))
    set termguicolors
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum
  endif

  function! ActivateColorScheme()
    colorscheme desert " fallback incase no colorscheme plugin is installed
  endfunction
" }}}

" SETTINGS: Navigation {{{
  if executable("rg")
    set grepprg=rg\ -H\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    command! -nargs=+ -complete=file -bar Rg grep! <args>|cw

    " bind K to grep word under cursor
    nnoremap K :grep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>
  endif
" }}}

" SETTINGS: DiffMode {{{
  if &diff
    set nolist
    set nocursorcolumn
    set nocursorline
    set conceallevel=0
    set colorcolumn=0
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

  " session mappings
  noremap <leader>m :call general#WriteSession()<CR>

  " Open highlighted text with default program
  vnoremap o :call general#ExecVisualSelection()<cr>
" }}}

" KEYBINDINGS: Editing {{{
  " Macro related mappings
  command! Bufmacro bufdo execute "normal @a" | write
  command! Cmacro cdo execute "normal@a" | write
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  " Move visual block
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  " custom comma motion mapping
  nnoremap di, f,dT,
  nnoremap ci, f,cT,
  nnoremap da, f,ld2F,i,<ESC>l "delete argument
  nnoremap ca, f,ld7F,i,<ESC>a "delete arg and insert

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
  noremap <leader>cp :cprev<CR>

  noremap <leader>ln :lnext<CR>
  noremap <leader>lp :lprev<CR>

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
  imap <bs> <nop>

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  " Find merge conflict markers
  noremap <leader>gm /\v^[<\|=>]{7}( .*\|$)<CR>

  " default to very magic
  noremap / /\v
  noremap ? ?\v

  " auto-center on specific movement keys
  nnoremap G Gzz
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap } }zz
  nnoremap { {zz
" }}}

" KEYBINDINGS: File manipulation {{{
  " Save
  noremap <leader>fs :w<CR>

  " Open vimrc with <leader>fed
  nnoremap <leader>fed  :e $MYVIMRC<CR>
  nnoremap <leader>feR :source $MYVIMRC<CR>

  " Rename current file with <leader>fr
  noremap <leader>fr :call general#RenameFile()<CR>

  " Get a vimdiff of all approvals
  map <leader>v :!approvals verify -d vimdiff -a<cr>

  " Safely exit neovim
  nmap Q :confirm qall<CR>

  "w!! to save file with sudo
  cmap w!! w !sudo tee % > /dev/null

  " This copies current file path + line number to system clipboard
  " source: https://stackoverflow.com/questions/17498144/yank-file-path-with-line-no-from-vim-to-system-clipboard
  nnoremap <leader>fC :let @+=expand("%") . ':' . line(".")<CR>

  " cd to the directory of the current buffer
  map <Leader>cd :lcd %:p:h<CR>:pwd<CR>
" }}}

" AUTOCMD: General {{{
  augroup ALEXANDER_GENERAL
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute "normal g`\"" |
          \ endif

    " Disable linting and syntax highlighting for large files
    autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   endif

    " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
    autocmd Syntax * if 5000 < line('$') | syntax sync maxlines=200 | endif

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

    " let terminal resize scale the internal windows
    autocmd VimResized * :wincmd =

    " Set colorscheme if vim is loaded
    autocmd VimEnter * call ActivateColorScheme()

    autocmd User FzfStatusLine call fzf#Statusline()
  augroup END
" }}}

" EXTRA: Include local vim config {{{
  if filereadable(expand("~/.nvimrc.local"))
    source ~/.nvimrc.local
  endif
" }}}

" vim: foldmethod=marker:sw=2:foldlevel=10
