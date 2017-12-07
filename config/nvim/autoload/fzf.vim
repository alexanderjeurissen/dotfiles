function! fzf#Statusline()
  setlocal statusline=%#fzf1#\ \ FZF
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

"NOTE: Fuzzy search all files changed in current branch (compared to develop)
function! fzf#FilesChangedInBranch()
  let command = 'git diff --name-only develop'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s --bind=ctrl-a:select-all,ctrl-d:deselect-all',
        \ 'window':  'enew' })
endfunction
