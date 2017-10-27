" rename current file, via Gary Bernhardt
function! general#RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':Rename ' . new_name
    redraw!
  endif
endfunction

function! general#Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Do the business unless filetype is blacklisted
  let blacklist = ['sql']

  if index(blacklist, &ft) < 0
    execute a:command
  endif

  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" save session
function! general#WriteSession()
  let cwd = fnamemodify('.', ':p:h:t')
  " let dateStamp = strftime("%d-%m-%Y_%H:%M")
  let extension = ".session"
  " let fname = cwd . "_" . dateStamp . extension
  let fname = cwd . extension
  silent exe ":Obsession " . fname
  echo "Wrote " . fname
endfun

function! general#ExecVisualSelection()
  let selection=s:get_visual_selection()
  call jobstart("open ".selection)
endfunc

" source: http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript#6271254
" original author of this function: xolox
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
