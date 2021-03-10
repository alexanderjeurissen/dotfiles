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

" Source: https://github.com/neovim/neovim/issues/9718#issuecomment-546603628
function! general#create_relative_centered_window()
  let win = winnr()
  let win_width = winwidth(win)
  let win_height = winheight(win)
  let win_pos = win_screenpos(win)

  let height = 19
  let width = float2nr(l:win_width - (l:win_width * 2 / 10))
  let top = float2nr(win_pos[0] + (height / 10))
  let left = float2nr(win_pos[1] + (width / 8))

  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

  let l:buf = nvim_create_buf(v:false, v:true)
  call nvim_open_win(l:buf, v:true, opts)
  return l:buf
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
