" PLUGIN_GROUP: AutoCompletion / language servers {{{
  call minpac#add('SirVer/ultisnips')
  call minpac#add('roxma/nvim-completion-manager')
  call minpac#add('autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' })
" }}}


" PLUGIN_GROUP: ColorSchemes {{{
  " call minpac#add('morhetz/gruvbox')
  " call minpac#add('Zabanaa/neuromancer.vim')
  " call minpac#add('zefei/cake16')
  " call minpac#add('ajmwagar/vim-deus')
  call minpac#add('KeitaNakamura/neodark.vim')
  " call minpac#add('arcticicestudio/nord-vim')
  call minpac#add('zefei/vim-colortuner')
" }}}


" PLUGIN_GROUP: Core {{{
  call minpac#add('radenling/vim-dispatch-neovim')
    call minpac#add('tpope/vim-dispatch')
  call minpac#add('tpope/vim-obsession') " improve vim session handling
  call minpac#add('tpope/vim-scriptease') " a Vim plugin for making Vim plugins.
  call minpac#add('sheerun/vim-polyglot') " Syntax highlighting, indent, etc. for various file types
" }}}


" PLUGIN_GROUP: Editing {{{
  call minpac#add('tpope/vim-endwise') " insert end after certain keywords in ruby
  call minpac#add('tommcdo/vim-exchange') " Exchange visual selections
  call minpac#add('tpope/vim-surround') " modify surrounding text
    call minpac#add('tpope/vim-repeat')
  call minpac#add('w0rp/ale') " new async syntax checker for neovim
  call minpac#add('tpope/vim-commentary') " easy commenting using vim motions
  call minpac#add('machakann/vim-highlightedyank') " make yank movements visible
  call minpac#add('bogado/file-line') " allow opening files with line number e.g. file.txt:30
  call minpac#add('tpope/vim-sleuth') " smart indent width based on buffer and neigbouring files
  call minpac#add('godlygeek/tabular') " re-allignment of text
" }}}


" PLUGIN_GROUP: Navigation {{{
  call minpac#add('justinmk/vim-sneak') " diagonal movements using S + 2 charaters
  call minpac#add('junegunn/fzf.vim')
    call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
  call minpac#add('mhinz/vim-grepper') " add grepper for ag/ack etc.
  call minpac#add('moll/vim-bbye') " buffer deleting
  call minpac#add('arithran/vim-delete-hidden-buffers') " delete all hidden buffers
  call minpac#add('airblade/vim-rooter') " change vim root to vcs root when editing a file
  call minpac#add('mhinz/vim-signify') " vcs changes sign column indicators
  call minpac#add('christoomey/vim-tmux-navigator') " tmux <-> vim navigation
  call minpac#add('tpope/vim-unimpaired') " Handy bracket mappings
  call minpac#add('thinca/vim-visualstar')  " Allows * motion in visual mode
  call minpac#add('justinmk/vim-dirvish') " file browser
  call minpac#add('tpope/vim-eunuch') " UNIX file helpers
  " call minpac#add('hkupty/nvimux', { 'type': 'opt', 'do': ':UpdateRemotePlugins' }) " TODO: evaluate if this can replace tmux on local machine.
  call minpac#add('tpope/vim-projectionist') " Allows defining projections using .projections.json
" }}}


" PLUGIN_GROUP: Ruby {{{
  call minpac#add('tpope/vim-bundler', { 'type': 'opt' }) " Run bundler commands
  call minpac#add('tpope/vim-cucumber', { 'type': 'opt' }) " Cucumber highlighting
  call minpac#add('tpope/vim-rails', { 'type': 'opt' }) " rails specific config and highlight
" }}}


" PLUGIN_GROUP: VersionControl {{{
  call minpac#add('tpope/vim-fugitive') " adds git commands for checking git status, commit etc.
  call minpac#add('tpope/vim-git') " Vim runtime files and syntax highlighting
" }}}


" PLUGIN_GROUP: Web {{{
  " call minpac#add('cakebaker/scss-syntax.vim'), {'for': ['scss', 'css']}
  call minpac#add('ap/vim-css-color', { 'type': 'opt' })
" }}}


" PLUGIN_GROUP: Window Management {{{
  call minpac#add('szw/vim-maximizer')
" }}}

" vim: foldmethod=marker:sw=3
