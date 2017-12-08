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
        \ 'sink*':  function('<sid>qf_handler'),
        \ 'options': '-m -x +s --bind=ctrl-a:select-all,ctrl-d:deselect-all',
        \ 'window':  'enew' })
endfunction


function! s:fzf_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:qf_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:fzf_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction
