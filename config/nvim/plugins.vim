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
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neco-vim', { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'fishbullet/deoplete-ruby'
  " Plug 'MarcWeber/vim-addon-mw-utils'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ColorSchemes {{{
" ------------------------------------------------------------------------------
  Plug 'morhetz/gruvbox'
  " Plug 'zefei/cake16'
  " Plug 'joshdick/onedark.vim'
  " Plug 'icymind/NeoSolarized'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Core {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-dispatch'
  Plug 'xolox/vim-session' | Plug 'xolox/vim-misc'
  Plug 'sheerun/vim-polyglot' " Syntax highlighting, indent, etc. for various file types
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Editing {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-abolish', { 'on': ['Abolish', 'Subvert'] } " better search
  Plug 'tpope/vim-endwise' " insert end after certain keywords in ruby
  Plug 'tommcdo/vim-exchange'
  Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
  Plug 'benekastah/neomake' " syntax checking
  Plug 'vim-scripts/tComment' " easy commenting using vim motions
  " Plug 'editorconfig/editorconfig-vim'
  Plug 'AndrewRadev/splitjoin.vim' "switch between singel and multiline blocks
  Plug 'Yggdroot/indentLine' " adds indentation guides
  Plug 'takac/vim-hardtime' " forces efficient movement in vim
  Plug 'eugen0329/vim-esearch' " search replace project wide
  Plug 'pelodelfuego/vim-swoop' " search replace current buffers

" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Javascript {{{
" ------------------------------------------------------------------------------
  " Plug 'kchmck/vim-coffee-script'
  " Plug 'pangloss/vim-javascript', { 'for': 'Javascript' }
  " Plug 'othree/yajs.vim'
  " Plug 'isRuslan/vim-es6', { 'for': 'Javascript' }
  " Plug 'mxw/vim-jsx'
  Plug 'maksimr/vim-jsbeautify'
  Plug 'beautify-web/js-beautify'
  " Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'Javascript' }
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Navigation {{{
" ------------------------------------------------------------------------------

  "TODO: replace with vim-sneak
  Plug 'Lokaltog/vim-easymotion'

  Plug 'junegunn/fzf.vim' | Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

  " Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
  Plug 'dangerzone/ranger.vim' | Plug 'moll/vim-bbye'
  Plug 'airblade/vim-rooter'
  Plug 'mhinz/vim-signify'
  Plug 'christoomey/vim-tmux-navigator'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Ruby {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
  Plug 'tpope/vim-rails', { 'for': 'ruby' }

  Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
  Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
  Plug 'subbarao/vim-rubybeautifier', { 'for': 'ruby' }
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" VersionControl {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-git' " Vim runtime files and syntax highlighting
  Plug 'int3/vim-extradite'
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
  Plug 'zhaocai/GoldenView.Vim'

  " Smarts around killing buffers.
  " will close the split if it's the last buffer in
  " it, and close vim if it's the last buffer/split. Use ,w
  Plug 'aaronjensen/vim-command-w', { 'on': 'CommandW' }

  " Maximizes windows and restores them afterwards
  Plug 'szw/vim-maximizer', { 'on': 'MaximizerToggle' }
" }}}
" ------------------------------------------------------------------------------

" Add plugins to &runtimepath
call plug#end()
