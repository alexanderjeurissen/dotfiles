function! fzf#Statusline()
  " Override statusline as you like
  highlight! fzf1 ctermfg=15 ctermbg=12
  setlocal statusline=%#fzf1#\ \\ FZF

  if g:fzf_mode == 'Files'
    setlocal statusline=\ \\ Search\ for\ files
  elseif g:fzf_mode == 'Ag'
    setlocal statusline=\ \\ Search\ in\ files
  elseif g:fzf_mode == 'Mru'
    setlocal statusline=\ \\ Recent\ files
  elseif g:fzf_mode == 'Commands'
    setlocal statusline=\ \\ Commands
  elseif g:fzf_mode == 'Commands'
    setlocal statusline=\ \\ Killring
  endif
endfunction

function! fzf#NeighbouringFiles()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = 'ag -g "" -f ' . cwd . ' --depth 0'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction

function! fzf#WinTabBuffers()
  if exists("w:wintabs_buflist")
    call fzf#run({
      \ 'source': map(copy(w:wintabs_buflist), 'bufname(v:val)'),
      \ 'sink':   'e',
      \ 'options': '-m -x +s',
      \ 'window':  'enew' })
  else
    echo "ERROR: wintabs not loaded"
  endif
endfunction


" Fuzzy search all files changed in this branch (compared to develop)
function! fzf#FilesChangedInBranch()
  let command = 'git diff --name-only develop'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction
