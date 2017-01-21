" ==============================================================================
" setup vim-plug {{{
" ==============================================================================
"
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

" ------------------------------------------------------------------------------
" AutoCompletion {{{
" ------------------------------------------------------------------------------
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neco-vim', { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  " Plug 'fishbullet/deoplete-ruby'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ColorSchemes {{{
" ------------------------------------------------------------------------------
  " Plug 'morhetz/gruvbox'
  " Plug 'zefei/cake16'
  " Plug 'NLKNguyen/papercolor-theme'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'sonph/onehalf', {'rtp': 'vim/'}
  " Plug 'zefei/vim-colortuner'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Core {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-dispatch' " run tasks in a tmux split to not block vim
  Plug 'tpope/vim-obsession' " improve vim session handling
  Plug 'sheerun/vim-polyglot' " Syntax highlighting, indent, etc. for various file types
  Plug 'vim-airline/vim-airline'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Editing {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-abolish', { 'on': ['Abolish', 'Subvert'] } " better search
  Plug 'tpope/vim-endwise' " insert end after certain keywords in ruby
  Plug 'tommcdo/vim-exchange'
  Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
  Plug 'w0rp/ale' " new async syntax checker for neovim
  Plug 'tpope/vim-commentary' " easy commenting using vim motions
  Plug 'AndrewRadev/splitjoin.vim' "switch between singel and multiline blocks
  Plug 'nathanaelkane/vim-indent-guides' " adds indentation guides
  Plug 'takac/vim-hardtime' " forces efficient movement in vim
  Plug 'pelodelfuego/vim-swoop' "TODO: search replace current buffers
  Plug 'bogado/file-line' " allow opening files with line number e.g. file.txt:30
  Plug 'terryma/vim-expand-region' " allow expanding visual selection region
  Plug 'tpope/vim-sleuth' " smart indent width based on buffer and neigbouring files
  Plug 'godlygeek/tabular' " re-allignment of text
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Navigation {{{
" ------------------------------------------------------------------------------
  Plug 'justinmk/vim-sneak' " diagonal movements using S + 2 charaters
  " Plug 'junegunn/fzf.vim' | Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'vim-ctrlspace/vim-ctrlspace'
  Plug 'dangerzone/ranger.vim' | Plug 'moll/vim-bbye' " add ranger as file browser
  Plug 'airblade/vim-rooter' " change vim root to vcs root when editing a file
  Plug 'mhinz/vim-signify' " Adds signs in the gutter to indicate vcs changes
  Plug 'christoomey/vim-tmux-navigator' " easy navigation between tmux and vim splits
  Plug 'eugen0329/vim-esearch' " project wide search and replace
  Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings like [f and ]f for file switching
  Plug 'thinca/vim-visualstar' " allows to use the * motion in visual mode
  Plug 'tpope/vim-vinegar' " improve default ntrw file explorer
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Ruby {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-bundler' " run bundler commands in Vim
  Plug 'tpope/vim-cucumber', { 'for': 'cucumber' } " fancy cucumber highlighting
  Plug 'tpope/vim-rails', { 'for': 'ruby' } " rails specific config and highlight
  Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' } " rspec commands and highlight
  Plug 'subbarao/vim-rubybeautifier', { 'for': 'ruby' } " ruby beautification
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" VersionControl {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-fugitive' " adds git commands for checking git status, commit etc.
  Plug 'tpope/vim-git' " Vim runtime files and syntax highlighting
  Plug 'int3/vim-extradite' "TODO: evaluate usefulness of this plugin
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Web {{{
" ------------------------------------------------------------------------------
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" TODO:Window Management {{{
" ------------------------------------------------------------------------------
  Plug 'zhaocai/GoldenView.Vim' " dynamic window tiling

  " Smarts around killing buffers.
  " will close the split if it's the last buffer in
  " it, and close vim if it's the last buffer/split.
  Plug 'aaronjensen/vim-command-w', { 'on': 'CommandW' } " Maximising windows
  Plug 'szw/vim-maximizer', { 'on': 'MaximizerToggle' }
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Misc {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-speeddating' " allows inc and dec of dates etc using C-a and C-x
" }}}
" ------------------------------------------------------------------------------


" Add plugins to &runtimepath
call plug#end()
