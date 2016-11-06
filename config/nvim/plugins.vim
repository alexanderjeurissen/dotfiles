"                      ____  _             _
"  _____ _____ _____  |  _ \| |_   _  __ _(_)_ __  ___   _____ _____ _____
" |_____|_____|_____| | |_) | | | | |/ _` | | '_ \/ __| |_____|_____|_____|
" |_____|_____|_____| |  __/| | |_| | (_| | | | | \__ \ |_____|_____|_____|
"                     |_|   |_|\__,_|\__, |_|_| |_|___/
"                                    |___/
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

  " Plug 'mattn/emmet-vim'
  " Plug 'Shougo/deoplete.nvim'
  Plug 'SirVer/ultisnips'
  Plug 'tomtom/tlib_vim'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'alexanderjeurissen/vim-react-snippets'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ColorSchemes {{{
" ------------------------------------------------------------------------------
  " Plug 'chriskempson/base16-vim'
  " Plug 'mhartington/oceanic-next'
  " Plug 'morhetz/gruvbox'
  " Plug 'zefei/cake16'
  Plug 'joshdick/onedark.vim'
  Plug 'atelierbram/Base2Tone-vim'
  " Plug 'junegunn/seoul256.vim'
  " Plug 'romainl/flattened'
  " Plug 'Samuel-Phillips/nvim-colors-solarized', { 'commit': '3618276' }
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Core {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-sensible'
  Plug 'radenling/vim-dispatch-neovim' | Plug 'tpope/vim-dispatch'
  Plug 'MarcWeber/vim-addon-local-vimrc'
  Plug 'xolox/vim-session' | Plug 'xolox/vim-misc'
  Plug 'sheerun/vim-polyglot' " Syntax highlighting, indent, etc. for various file types
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Editing {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-abolish', { 'on': ['Abolish', 'Subvert'] }
  Plug 'tpope/vim-endwise'
  Plug 'tommcdo/vim-exchange'
  Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
  Plug 'benekastah/neomake'
  Plug 'vim-scripts/tComment'
  Plug 'osyo-manga/vim-over', { 'on': 'Replace' }
  Plug 'editorconfig/editorconfig-vim'
  Plug 'AndrewRadev/splitjoin.vim' "switch between singel and multiline blocks
  Plug 'Yggdroot/indentLine' " adds indentation guides
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Javascript {{{
" ------------------------------------------------------------------------------
  " Plug 'kchmck/vim-coffee-script'
  Plug 'Raimondi/delimitMate'
  Plug 'dsawardekar/ember.vim', { 'for': 'Javascript' }
  " Plug 'pangloss/vim-javascript', { 'for': 'Javascript' }
  " Plug 'othree/yajs.vim'
  Plug 'JarrodCTaylor/vim-ember-cli-test-runner', {
        \'on': [
        \  'RunAllEmberTests',
        \  'RunSingleEmberTest',
        \  'RunSingleEmberTestModule',
        \  'RerunLastEmberTests'
        \]}
  " Plug 'isRuslan/vim-es6', { 'for': 'Javascript' }
  " Plug 'mxw/vim-jsx'
  Plug 'maksimr/vim-jsbeautify', { 'for': 'Javascript' }
  Plug 'beautify-web/js-beautify', { 'for': 'Javascript' }
  Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'Javascript' }
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Navigation {{{
" ------------------------------------------------------------------------------

  "TODO: replace with vim-sneak
  Plug 'Lokaltog/vim-easymotion'

  Plug 'junegunn/fzf.vim' | Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

  " unite / denite
  Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  " Plug 'Shougo/unite.vim'
  " Plug 'Shougo/neoyank.vim'
  " Plug 'basyura/unite-rails'
  " Plug 'Shougo/unite-session'
  " Plug 'osyo-manga/unite-quickfix'
  Plug 'Shougo/neomru.vim'
  Plug 'Shougo/denite.nvim'
  " Plug 'Shougo/unite-help'
  " Plug 'Shougo/vimfiler.vim', { 'on': 'VimFiler' }

  " Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
  " Plug kien/ctrlp.vim
  Plug 'dangerzone/ranger.vim' | Plug 'moll/vim-bbye'
  Plug 'airblade/vim-rooter'
  Plug 'mhinz/vim-signify'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Ruby {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-cucumber'
  Plug 'tpope/vim-rails', { 'for': 'ruby' }

  Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
  " Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
  Plug 'subbarao/vim-rubybeautifier', { 'for': 'ruby' }
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" VersionControl {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-git' " Vim runtime files and syntax highlighting
  Plug 'int3/vim-extradite'
  Plug 'mattn/gist-vim', { 'on': 'Gist' }
  Plug 'jreybert/vimagit', { 'on': 'Magit' }
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Web {{{
" ------------------------------------------------------------------------------
  Plug 'mattn/webapi-vim'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'
  Plug 'rizzatti/dash.vim', { 'on': 'Dash' }
  Plug 'tpope/vim-haml'
  Plug 'aquach/vim-http-client'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" TODO:Window Management {{{
" ------------------------------------------------------------------------------
  Plug 'zhaocai/GoldenView.Vim'

  " Smarts around killing buffers.
  " will close the split if it's the last buffer in
  " it, and close vim if it's the last buffer/split. Use ,w
  Plug 'aaronjensen/vim-command-w', { 'on': 'CommandW' }

  " Maximizes windows and restores them afterwards
  Plug 'szw/vim-maximizer', { 'on': 'MaximizerToggle' }

  Plug 'zefei/vim-wintabs'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Misc {{{
" ------------------------------------------------------------------------------
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'ryanoasis/vim-devicons'
" }}}
" ------------------------------------------------------------------------------

" Add plugins to &runtimepath
call plug#end()
