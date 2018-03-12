" FIXME: this is current bugged due to conflicting tpope plugin
" rename current file, via Gary Bernhardt
function! general#RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    execute':Rename ' . new_name
    redraw!
  endif
endfunction

" NOTE: copied from Damian Conway's vimrc
" SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function! AskQuit (msg, options, quit_option)
  if confirm(a:msg, a:options) == a:quit_option
    exit
  endif
endfunction

" NOTE: copied from Damian Conway's vimrc
" SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function! general#EnsureDirExists ()
  let l:required_dir = expand('%:h')
  if !isdirectory(l:required_dir)
    call AskQuit("Parent directory '" . l:required_dir . "' doesn't exist.",
      \       "&Create it\nor &Quit?", 2)
    try
      call mkdir(l:required_dir, 'p')
    catch
      call AskQuit("Can't create '" . l:required_dir . "'",
        \            "&Quit\nor &Continue anyway?", 1)
    endtry
  endif
endfunction


" NOTE: copied from Damian Conway's vimrc
" SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function! general#UndoubleCompletions()
  let l:col = getpos('.')[2]
  let l:line = getline('.')
  call setline('.', substitute(l:line, '\(\k\+\)\%'.l:col.'c\zs\1', '', ''))
endfunction

" NOTE: copied from Damian Conway's vimrc
" SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function! general#HLNext(blinktime)
  let l:target_pat = '\c\%#'.@/
  let l:ring = matchadd('CurrentSearchMatch', l:target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(l:ring)
  redraw
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
  silent execute ":Obsession " . fname
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

" Execute macro over visual selection
function! ExecuteMacroOverVisualRange()
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
