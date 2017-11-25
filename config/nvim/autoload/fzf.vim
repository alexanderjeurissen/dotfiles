function! fzf#Statusline()
  " Override statusline as you like
  highlight! fzf1 ctermfg=15 ctermbg=12
  setlocal statusline=%#fzf1#\ \<U+F422>\ FZF

  if g:fzf_mode == 'Files'
    setlocal statusline=\ \<U+F422>\ Search\ for\ files
  elseif g:fzf_mode == 'Ag'
    setlocal statusline=\ \<U+F1E5>\ Search\ in\ files
  elseif g:fzf_mode == 'Mru'
    setlocal statusline=\ \<U+F43A>\ Recent\ files
  elseif g:fzf_mode == 'Commands'
    setlocal statusline=\ \<U+F120>\ Commands
  elseif g:fzf_mode == 'Commands'
    setlocal statusline=\ \<U+F0C4>\ Killring
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


" Fuzzy search all files changed in this branch (compared to develop)
function! fzf#FilesChangedInBranch()
  let command = 'git diff --name-only develop'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s --bind=ctrl-a:select-all,ctrl-d:deselect-all',
        \ 'window':  'enew' })
endfunction
