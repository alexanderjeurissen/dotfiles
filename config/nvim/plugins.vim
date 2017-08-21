" ==============================================================================
" Dein.vim start {{{
" ==============================================================================
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
" ==============================================================================

" ------------------------------------------------------------------------------
" AutoCompletion {{{
" ------------------------------------------------------------------------------
    " call dein#add('Shougo/deoplete.nvim', {
    "       \ 'on_i': 1,
    "       \ 'hook_post_source': "
    "       \   call deoplete#custom#set('ultisnips', 'rank', 1000)\n
    "       \ "
    "       \})
    " call dein#add('Shougo/neco-vim', { 'on_ft': 'vim' })
    " call dein#add('carlitux/deoplete-ternjs', {
    "       \'on_ft': 'javascript',
    "       \'build': 'npm install -g tern'
    "       \})
    " call dein#add('fishbullet/deoplete-ruby', { 'on_ft': 'ruby' })
    call dein#add('SirVer/ultisnips')
    " call dein#add('honza/vim-snippets')
"   " call dein#add('letientai299/vim-react-snippets/'
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ColorSchemes {{{
" ------------------------------------------------------------------------------
   call dein#add('morhetz/gruvbox', {
         \ 'hook_post_source': "
         \    let g:gruvbox_italic=1\n
         \    let g:gruvbox_italicize_strings=1\n
         \    let g:gruvbox_contrast_dark='soft'\n
         \    let g:gruvbox_contrast_light='soft'\n
         \    colorscheme gruvbox\n
         \    set background=dark\n
         \ "
         \ })

   " call dein#add('zefei/cake16', {
   "       \ 'hook_post_source': "
   "       \   colorscheme cake16\n
   "       \   set background=light\n
   "       \   hi! User1 ctermfg=15 ctermbg=10 guifg=bg guibg=#82a3b3\n
   "       \   hi! User2 ctermfg=10 ctermbg=12 guifg=#82a3b3 guibg=#678797\n
   "       \   hi! link TabLineSel Diffdelete\n
   "       \   hi! link QuickFixMenuLine PMenuSel\n
   "       \ "
   "       \})

   " call dein#add('liuchengxu/space-vim-dark', {
   "       \ 'hook_post_source': "
   "       \   colorscheme space-vim-dark\n
   "       \   set background=dark\n
   "       \   hi Comment cterm=italic\n
   "       \   hi! User1 cterm=bold ctermfg=232 ctermbg=97  gui=Bold guifg=#333300 guibg=#875FAF\n
   "       \   hi! User2 cterm=None ctermfg=214 ctermbg=243 gui=None guifg=#FFBB7D guibg=#666666\n
   "       \   hi! User3 cterm=None ctermfg=251 ctermbg=241 gui=None guifg=#c6c6c6 guibg=#585858\n
   "       \   hi! User4 cterm=Bold ctermfg=177 ctermbg=239 gui=Bold guifg=#d75fd7 guibg=#4e4e4e\n
   "       \   hi! User5 cterm=None ctermfg=250 ctermbg=238 gui=None guifg=#bcbcbc guibg=#444444\n
   "       \   hi! User6 cterm=None ctermfg=249 ctermbg=239 gui=None guifg=#b2b2b2 guibg=#4e4e4e\n
   "       \   hi! User7 cterm=None ctermfg=249 ctermbg=241 gui=None guifg=#b2b2b2 guibg=#606060\n
   "       \ "
   "       \})

   " call dein#add('sonph/onehalf', {
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
   "       \})

   " call dein#add('whatyouhide/vim-gotham', {
   "       \ 'hook_post_source': "
   "       \    colorscheme gotham\n
   "       \    set background=dark\n
   "       \ "
   "       \ })
   "
"   " call dein#add('~/git/opensource/vim-gotham/'
"   " call dein#add('whatyouhide/vim-gotham'
"   " call dein#add('mswift42/vim-themes'
" " }}}
" " ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Core {{{
" ------------------------------------------------------------------------------
 call dein#add('tpope/vim-dispatch') " run tasks in a tmux split to not block vim
 " call dein#add('radenling/vim-dispatch-neovim', {'depends': 'tpope/vim-dispatch'})
 call dein#add('tpope/vim-obsession') " improve vim session handling
 call dein#add('tpope/vim-scriptease') " a Vim plugin for making Vim plugins.
 call dein#add('sheerun/vim-polyglot') " Syntax highlighting, indent, etc. for various file types
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Editing {{{
" ------------------------------------------------------------------------------
    " call dein#add('tpope/vim-abolish', { 'on_cmd': ['Abolish', 'Subvert'] }) " better search
    call dein#add('tpope/vim-endwise') " insert end after certain keywords in ruby
    call dein#add('tommcdo/vim-exchange')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround', { 'depends': 'tpope/vim-repeat' })
    call dein#add('w0rp/ale') " new async syntax checker for neovim
    call dein#add('tpope/vim-commentary') " easy commenting using vim motions
    " call dein#add('takac/vim-hardtime') " forces efficient movement in vim
    call dein#add('bogado/file-line') " allow opening files with line number e.g. file.txt:30
    call dein#add('tpope/vim-sleuth') " smart indent width based on buffer and neigbouring files
    call dein#add('godlygeek/tabular') " re-allignment of text
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Navigation {{{
" ------------------------------------------------------------------------------
"   call dein#add('justinmk/vim-sneak' " diagonal movements using S + 2 charaters
    call dein#add('~/.fzf', { 'build': './install --all' })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#add('mhinz/vim-grepper') " add grepper for ag/ack etc.
    call dein#add('moll/vim-bbye') " add nice buffer deleting
    call dein#add('airblade/vim-rooter') " change vim root to vcs root when editing a file
    call dein#add('mhinz/vim-signify') " Adds signs in the gutter to indicate vcs changes
    call dein#add('christoomey/vim-tmux-navigator') " easy navigation between tmux and vim splits
    call dein#add('tpope/vim-unimpaired') " pairs of handy bracket mappings like [f and ]f for file switching
    call dein#add('thinca/vim-visualstar', { 'on_map': '*' }) " allows to use the * motion in visual mode
    call dein#add('tpope/vim-vinegar', { 'on_map': '-' }) " improve default ntrw file explorer
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Ruby {{{
" ------------------------------------------------------------------------------
  call dein#add('tpope/vim-bundler') " run bundler commands in Vim
  call dein#add('tpope/vim-cucumber', { 'on_ft': 'cucumber' }) " fancy cucumber highlighting
  call dein#add('tpope/vim-rails', { 'on_ft': ['ruby', 'cucumber'] }) " rails specific config and highlight
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" VersionControl {{{
" ------------------------------------------------------------------------------
  call dein#add('tpope/vim-fugitive') " adds git commands for checking git status, commit etc.
  call dein#add('tpope/vim-git') " Vim runtime files and syntax highlighting
" }}}
" ------------------------------------------------------------------------------

" " ------------------------------------------------------------------------------
" " Web {{{
" " ------------------------------------------------------------------------------
    " call dein#add('cakebaker/scss-syntax.vim', {'on_ft': ['scss', 'css']})
    call dein#add('ap/vim-css-color', {'on_ft': ['css', 'scss']})
" " }}}
" " ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" TODO:Window Management {{{
" ------------------------------------------------------------------------------
"   " Smarts around killing buffers.
"   " will close the split if it's the last buffer in
"   " it, and close vim if it's the last buffer/split.
"   call dein#add('aaronjensen/vim-command-w', { 'on': 'CommandW' } " Maximising windows
    call dein#add('szw/vim-maximizer')
    call dein#add('zefei/vim-wintabs', {
          \ 'hook_add': "
          \   nmap <leader>bn <plug>(wintabs_next)\n
          \   nmap <leader>bp <plug>(wintabs_previous)\n
          \   nmap <leader>wn <plug>(wintabs_next)\n
          \   nmap <leader>wp <plug>(wintabs_previous)\n
          \   nmap <leader>wc :q<cr>\n
          \   nmap <leader>wd <plug>(wintabs_close)\n
          \   nmap <leader>wt <plug>(wintabs_maximize)\n
          \   nmap <leader>wa <plug>(wintabs_all)\n
          \   nmap <leader>wo <plug>(wintabs_only)\n
          \   nmap <leader>tc <plug>(wintabs_close_vimtab)\n
          \"
          \})
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Misc {{{
" ------------------------------------------------------------------------------
" }}}
" ------------------------------------------------------------------------------

" ==============================================================================
" Dein.vim end {{{
" ==============================================================================
  call dein#end()
  call dein#call_hook('source') " call hooks of non lazy plugins
  call dein#save_state() " Save dein state (cache)
endif

filetype plugin indent on

if dein#check_install()
  " Installation check.
  let g:dein#types#git#default_protocol = "ssh"
  call dein#install() " install plugins that aren't installed yet
  call dein#remote_plugins() " Install remote plugins
  call dein#check_lazy_plugins() " check for lazy plugins that don't have /plugin
  call map(dein#check_clean(), "delete(v:val, 'rf')") " remove unused plugins
endif

" Execute post_source hooks after plugins are sourced
autocmd VimEnter * call dein#call_hook('post_source')
" }}}
" ==============================================================================
