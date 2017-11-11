" PLUGIN_GROUP: AutoCompletion {{{
  Plug 'SirVer/ultisnips'
  Plug 'roxma/nvim-completion-manager'
    Plug 'calebeby/ncm-css', { 'for': ['css', 'scss']}
    Plug 'roxma/nvim-cm-tern',  {'for': 'javascript', 'do': 'npm install'}
    Plug 'Shougo/neco-vim', { 'for': 'vim' }
" }}}


" PLUGIN_GROUP: ColorSchemes {{{
  " Plug 'morhetz/gruvbox'
  " Plug 'Zabanaa/neuromancer.vim'
  Plug 'ajmwagar/vim-deus'
  " Plug 'zefei/cake16'
  Plug 'zefei/vim-colortuner'

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
  Plug 'arithran/vim-delete-hidden-buffers' " delete all hidden buffers
  Plug 'airblade/vim-rooter' " change vim root to vcs root when editing a file
  Plug 'mhinz/vim-signify' " vcs changes sign column indicators
  Plug 'christoomey/vim-tmux-navigator' " tmux <-> vim navigation
  Plug 'tpope/vim-unimpaired' " Handy bracket mappings
  Plug 'thinca/vim-visualstar'  " Allows * motion in visual mode
  Plug 'justinmk/vim-dirvish' " file browser
  Plug 'tpope/vim-eunuch' " UNIX file helpers
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
  Plug 'ap/vim-css-color', {'for': ['css', 'scss', 'vim']}
" }}}


" PLUGIN_GROUP: Window Management {{{
  Plug 'szw/vim-maximizer'
  " Plug 'zefei/vim-wintabs'
" }}}
