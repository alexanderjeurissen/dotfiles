" FIXME: this is current bugged due to conflicting tpope plugin
" rename current file, via Gary Bernhardt
function! general#RenameFile()
  let l:old_name = expand('%')
  let l:new_name = input('New file name: ', expand('%'))
  if l:new_name !=# '' && l:new_name != l:old_name
    execute ':Rename ' . l:new_name
    redraw!
  endif
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

" save session
function! general#WriteSession()
  let l:cwd = fnamemodify('.', ':p:h:t')
  " let dateStamp = strftime("%d-%m-%Y_%H:%M")
  let l:extension = '.session'
  " let fname = cwd . "_" . dateStamp . extension
  let l:fname = l:cwd . l:extension
  silent execute ':Obsession ' . l:fname
  echo 'Wrote ' . l:fname
endfun

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

" NOTE: Create a floating window using either a new buffer
" or by putting the supplied buffer in the floating window.
function! general#FloatingWindow(...) abort
  " NOTE: instantiate buffer
  let s:buf = nvim_create_buf(v:false, v:true)

  " NOTE: Create a floating window depending on arguments:
  " | 'split' => center window based on source split size
  " | 'global' => center window based on terminal size
  " default to 'split'
  let scope = get(a:, 1, 'split')

  if scope ==# 'global'
    " NOTE: position floating window: center of screen
    let height = float2nr(&lines - (&lines * 2 / 10))
    let width = float2nr(&columns - (&columns * 2 / 10))
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)
  else
    " NOTE: position floating window: center of split
    let win = winnr()
    let win_width = winwidth(win)
    let win_height = winheight(win)
    let win_pos = win_screenpos(win)

    let height = float2nr(l:win_height - (l:win_height * 2 / 10))
    let width = float2nr(l:win_width - (l:win_width * 2 / 10))
    let row = float2nr(win_pos[0] + (height / 10))
    let col = float2nr(win_pos[1] + (width / 6))
  end

  " NOTE: disable some function to ensure correct behaviour:
  " 1. No sign column
  " 2. No mode
  " 3. No line numbers
  " 4. No relative line numbers
  " 5. No ruler
  call setbufvar(s:buf, '&signcolumn', 'no')
  call setbufvar(s:buf, '&showmode', 0)
  call setbufvar(s:buf, '&number', 0)
  call setbufvar(s:buf, '&relativenumber', 0)
  call setbufvar(s:buf, '&ruler', 0)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let win = nvim_open_win(s:buf, v:true, opts)

  return s:buf
endfunction


" NOTE: open help queries in floating window
function! general#FloatingWindowHelp(query) abort
  let l:buf = general#FloatingWindow('global')
  call nvim_set_current_buf(l:buf)
  setlocal filetype=help
  setlocal buftype=help
  execute 'help ' . a:query
endfunction

function! general#AppendToLine(str)
  execute ":normal i" . a:str
endfunction
