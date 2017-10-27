" FUNCTION: Install vim-plug if it's not present {{{
function! vimplug#CheckInstall()
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    if executable('curl')
      exec '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs ' .
            \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    else
      echohl WarningMsg | echom "You need install curl!" | echohl None
    endif

    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunction
" }}}


" FUNCTION: Add H keybind to open help of highlighted plugin {{{
  function! vimplug#Plugdoc()
    let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
    if has_key(g:plugs, name)
      for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
        execute 'tabe' doc
      endfor
    endif
  endfunction

  augroup PlugHelp
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> <silent> H :call vimplug#Plugdoc()<cr>
  augroup END
" }}}

" FUNCTION: Add gx keybind to open highlighted plugin's github repository {{{
  function! vimplug#PlugGithub()
    let line = getline('.')
    let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
    let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                        \ : getline(search('^- .*:$', 'bn'))[2:-2]
    let uri  = get(get(g:plugs, name, {}), 'uri', '')
    if uri !~ 'github.com'
      return
    endif
    let repo = matchstr(uri, '[^:/]*/'.name)
    let url  = empty(sha) ? 'https://github.com/'.repo
                        \ : printf('https://github.com/%s/commit/%s', repo, sha)
    call netrw#BrowseX(url, 0)
  endfunction

  augroup PlugGx
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call vimplug#PlugGithub()<cr>
  augroup END
" }}}
