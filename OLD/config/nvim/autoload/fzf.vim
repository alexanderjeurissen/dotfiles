function! fzf#Statusline()
  echom "kerk"
  setlocal statusline=%#fzf1#\ FZF\ -\ %{g:fzf_current_mode}
endfunction

function! fzf#Files()
  let g:fzf_current_mode = 'Filess'
  call fzf#run(fzf#wrap({ 'options': g:fzf_default_options }))
endfunction


function! fzf#Buffers()
  let g:fzf_current_mode = 'Buffers'
  function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
  endfunction

  function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
  endfunction

  call fzf#run(fzf#wrap({
        \ 'source':  reverse(<sid>buflist()),
        \ 'sink':    function('<sid>bufopen'),
        \ 'options': g:fzf_default_options,
        \ }))
endfunction


"NOTE: Files that are in the same directory as the current buffer
function! fzf#NeighbouringFiles()
  let g:fzf_current_mode = 'NeighbouringFiles'
  let current_file = expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = $FZF_DEFAULT_COMMAND . ' --maxdepth 1'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'dir': cwd,
        \ 'options': g:fzf_default_options
        \ }))
endfunction


"NOTE: Files that are tracked by Git in $PWD that are dirty
function! fzf#GitFiles()
  let g:fzf_current_mode = 'GitFiles'
  let command = 'git diff --name-only'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options
        \ }))
endfunction


"NOTE: Files in $PWD that have changed in current branch compared to develop
function! fzf#GitBranchFiles()
  let g:fzf_current_mode = 'GitBranchFiles'
  let command = 'git diff --name-only develop'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options
        \ }))
endfunction
