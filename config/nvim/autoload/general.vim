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
  let l:s = @/
  let l:l = line('.')
  let l:c = col('.')

  " Do the business unless filetype is blacklisted
  let l:blacklist = ['sql']

  if index(l:blacklist, &filetype) < 0
    execute a:command
  endif

  " Clean up: restore previous search history, and cursor position
  let @/ = l:s
  call cursor(l:l, l:c)
endfunction

function! general#ExecVisualSelection()
  let l:selection = s:get_visual_selection()
  call jobstart("open -a '/Applications/Google Chrome.app' --args '" . l:selection . "'")
endfunc

" NOTE: get string that contains the visual selection
" SOURCE: http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript#6271254
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [l:lnum1, l:col1] = getpos("'<")[1:2]
  let [l:lnum2, l:col2] = getpos("'>")[1:2]
  let l:lines = getline(l:lnum1, l:lnum2)
  let l:lines[-1] = l:lines[-1][: l:col2 - (&selection ==# 'inclusive' ? 1 : 2)]
  let l:lines[0] = l:lines[0][l:col1 - 1:]
  return join(l:lines, '\n')
endfunction

" Execute macro over visual selection
function! general#ExecuteMacroOverVisualRange()
  echo '@'.getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" NOTE: copied from Damian Conway's vimrc
" SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function! general#MarkMargin(on, ...)
  let s:text_length=get(a:, 1, 80)

  if exists('b:MarkMargin')
      try
          call matchdelete(b:MarkMargin)
      catch /./
      endtry
      unlet b:MarkMargin
  endif
  if a:on
      let b:MarkMargin = matchadd('ColorColumn', '\%>80v\s*\S', s:text_length)
  endif
endfunction
