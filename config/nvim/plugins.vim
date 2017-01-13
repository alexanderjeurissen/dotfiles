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
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neco-vim', { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  " Plug 'fishbullet/deoplete-ruby'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ColorSchemes {{{
" ------------------------------------------------------------------------------
  " Plug 'morhetz/gruvbox'
  Plug 'zefei/cake16'
  Plug 'zefei/vim-colortuner'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Core {{{
" ------------------------------------------------------------------------------
  Plug 'tpope/vim-dispatch'
  Plug 'xolox/vim-session' | Plug 'xolox/vim-misc' " save current vim session
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
  " Plug 'neomake/neomake' " syntax checking, TODO: evaluate if can be replaced with ale
  Plug 'w0rp/ale' " new async syntax checker for neovim
  Plug 'vim-scripts/tComment' " easy commenting using vim motions
  Plug 'AndrewRadev/splitjoin.vim' "switch between singel and multiline blocks
  Plug 'Yggdroot/indentLine' " adds indentation guides
  Plug 'takac/vim-hardtime' " forces efficient movement in vim
  Plug 'pelodelfuego/vim-swoop' " search replace current buffers
  Plug 'bogado/file-line' " allow opening files with line number e.g. file.txt:30
	Plug 'terryma/vim-expand-region' " allow expanding visual selection region
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Javascript {{{
" ------------------------------------------------------------------------------
  Plug 'maksimr/vim-jsbeautify'
  Plug 'beautify-web/js-beautify'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Navigation {{{
" ------------------------------------------------------------------------------
  Plug 'justinmk/vim-sneak' " diagonal movements using S + 2 charaters
  Plug 'junegunn/fzf.vim' | Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'dangerzone/ranger.vim' | Plug 'moll/vim-bbye' " add ranger as file browser
  Plug 'airblade/vim-rooter' " change vim root to vcs root when editing a file
  Plug 'mhinz/vim-signify' " Adds signs in the gutter to indicate vcs changes
  Plug 'christoomey/vim-tmux-navigator' " easy navigation between tmux and vim splits
  Plug 'eugen0329/vim-esearch' " project wide search and replace
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

" Add plugins to &runtimepath
call plug#end()
