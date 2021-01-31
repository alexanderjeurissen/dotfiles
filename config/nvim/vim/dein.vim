scriptencoding utf-8

" SETTINGS: Dein.vim {{{
  "Note: install dein if not present
  if !filereadable(expand(g:dein_path) . '/repos/github.com/Shougo/dein.vim/README.md')
   if executable('git')
     exec '!git clone https://github.com/Shougo/dein.vim ' . g:dein_path . '/repos/github.com/Shougo/dein.vim'
   else
     echohl WarningMsg | echom 'You need install git!' | echohl None
   endif

   autocmd VimEnter * source $MYVIMRC
  endif

  " Add dein.vim to runtimepath
  set runtimepath^=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

  let s:plugin_path='$HOME/.config/nvim/dein'
  let s:dein_toml='$HOME/.config/nvim/plugins.toml'

  if dein#load_state(expand(s:plugin_path))
   " tell dein where the plugins live
   call dein#begin(
         \ expand(s:plugin_path),
         \ expand(s:dein_toml),
         \ [expand('$HOME/.config/nvim/init.vim')]
         \)

   call dein#load_toml(s:dein_toml)

   call dein#end()
   call dein#call_hook('source') " call hooks of non lazy plugins
   call dein#save_state() " Save dein state (cache)
  endif

  filetype plugin indent on

  if dein#check_install()
    " Installation check.
    let g:dein#types#git#default_protocol = 'ssh'
    call dein#install() " install plugins that aren't installed yet
    call dein#remote_plugins() " Install remote plugins
    call dein#check_lazy_plugins() " check for lazy plugins that don't have /plugin

    call map(dein#check_clean(), "delete(v:val, 'rf')") " remove unused plugins
  endif

  " Execute post_source hooks after plugins are sourced
  autocmd VimEnter * call dein#call_hook('post_source')
" }}}

