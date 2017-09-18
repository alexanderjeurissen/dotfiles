" PLUGIN_GROUP: AutoCompletion {{{
  Plug 'SirVer/ultisnips'
" }}}


" PLUGIN_GROUP: ColorSchemes {{{
  Plug 'morhetz/gruvbox'

  " Plug 'mhartington/oceanic-next', {
  "       \ 'hook_post_source': "
  "       \    syntax enable\n
  "       \    let g:oceanic_next_terminal_bold = 1\n
  "       \    let g:oceanic_next_terminal_italic = 1\n
  "       \    colorscheme OceanicNext\n
  "       \ "
  "       \ }

  " Plug 'zefei/cake16', {
  "       \ 'hook_post_source': "
  "       \   colorscheme cake16\n
  "       \   set background=light\n
  "       \   hi! User1 ctermfg=15 ctermbg=10 guifg=bg guibg=#82a3b3\n
  "       \   hi! User2 ctermfg=10 ctermbg=12 guifg=#82a3b3 guibg=#678797\n
  "       \   hi! link TabLineSel Diffdelete\n
  "       \   hi! link QuickFixMenuLine PMenuSel\n
  "       \ "
  "       \}

  " Plug 'sonph/onehalf', {
  "       \ 'rtp': 'vim/',
  "       \ 'hook_post_source': "
  "       \   colorscheme onehalfdark\n
  "       \
  "       \   let &background='dark'\n
  "       \
  "       \   hi! link Search PMenu\n
  "       \   hi! link IncSearch PMenuSel\n
  "       \   hi! link Folded Visual\n
  "       \ "
  "       \}

  " Plug 'whatyouhide/vim-gotham', {
  "       \ 'hook_post_source': "
  "       \    colorscheme gotham\n
  "       \    set background=dark\n
  "       \ "
  "       \ }
  "
" }}}


" PLUGIN_GROUP: Core {{{
  Plug 'tpope/vim-dispatch' " run tasks in a tmux split to not block vim
  " Plug 'radenling/vim-dispatch-neovim'
  "   Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-obsession' " improve vim session handling
  Plug 'tpope/vim-scriptease' " a Vim plugin for making Vim plugins.
  Plug 'sheerun/vim-polyglot' " Syntax highlighting, indent, etc. for various file types
" }}}


" PLUGIN_GROUP: Editing {{{
  " Plug 'tpope/vim-abolish', { 'on_cmd': ['Abolish', 'Subvert'] } " better search
  Plug 'tpope/vim-endwise' " insert end after certain keywords in ruby
  Plug 'tommcdo/vim-exchange'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
  Plug 'w0rp/ale' " new async syntax checker for neovim
  Plug 'tpope/vim-commentary' " easy commenting using vim motions
  " Plug 'takac/vim-hardtime' " forces efficient movement in vim
  Plug 'bogado/file-line' " allow opening files with line number e.g. file.txt:30
  Plug 'tpope/vim-sleuth' " smart indent width based on buffer and neigbouring files
  Plug 'godlygeek/tabular' " re-allignment of text
" }}}


" PLUGIN_GROUP: Navigation {{{
  "   Plug 'justinmk/vim-sneak' " diagonal movements using S + 2 charaters
  Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'mhinz/vim-grepper' " add grepper for ag/ack etc.
  Plug 'moll/vim-bbye' " buffer deleting
  Plug 'airblade/vim-rooter' " change vim root to vcs root when editing a file
  Plug 'mhinz/vim-signify' " vcs changes sign column indicators
  Plug 'christoomey/vim-tmux-navigator' " tmux <-> vim navigation
  Plug 'tpope/vim-unimpaired' " Handy bracket mappings
  Plug 'thinca/vim-visualstar'  " Allows * motion in visual mode
  Plug 'tpope/vim-vinegar'  " improve ntrw
" }}}


" PLUGIN_GROUP: Ruby {{{
  Plug 'tpope/vim-bundler' " Run bundler commands
  " Plug 'tpope/vim-cucumber', { 'for': 'cucumber' } " Cucumber highlighting
  Plug 'tpope/vim-rails', { 'for': ['ruby', 'cucumber'] } " rails specific config and highlight
" }}}


" PLUGIN_GROUP: VersionControl {{{
  Plug 'tpope/vim-fugitive' " adds git commands for checking git status, commit etc.
  Plug 'tpope/vim-git' " Vim runtime files and syntax highlighting
" }}}


" PLUGIN_GROUP: Web {{{
  " Plug 'cakebaker/scss-syntax.vim', {'for': ['scss', 'css']}
  "
  " Plug 'pangloss/vim-javascript', {'for': ['js', 'jsx']}
  " Plug 'othree/yajs.vim'
  Plug 'ap/vim-css-color', {'for': ['css', 'scss']}
" }}}


" PLUGIN_GROUP: Window Management {{{
  Plug 'szw/vim-maximizer'
  Plug 'zefei/vim-wintabs'
" }}}
