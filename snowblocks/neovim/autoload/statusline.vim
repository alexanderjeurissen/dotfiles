function! statusline#Init()
  let statusline_items = ' ' " left padding
  let statusline_items .= '%{statusline#FileInfoFlag()}'
  let statusline_items .= '%t'
  let statusline_items .= '%='
  let statusline_items .= '%{statusline#PasteFlag()}'
  let statusline_items .= '%{statusline#SyntaxFlag()}'
  let statusline_items .= '%{statusline#SpellFlag()}'
  let statusline_items .= '%{statusline#HardTimeFlag()}'
  let statusline_items .= '%{statusline#BranchFlag()}'

  return statusline_items
endfunction

function! statusline#WintabsInfo()
  if exists("w:wintabs_buflist")
    let current_buffer_index = index(w:wintabs_buflist, bufnr('%'))+1
    let wintab_buffers_count = len(w:wintabs_buflist)
    return "  ".current_buffer_index.":".wintab_buffers_count."│"
  else
    return ''
  endif
endfunction

function! statusline#FileInfoFlag()
  if &readonly
    return '  '
  elseif &modified
    return '  '
  else
    return ' '
  endif
endfunction

function! statusline#PasteFlag()
  return &paste ? '  ' : ''
endfunction

function! statusline#SpellFlag()
  return &spell ? ' ¶ ' : ''
endfunction

function! statusline#SyntaxFlag()
  let l:res = ale#statusline#Status()
  if l:res ==# 'OK'
   return ''
  else
   return '  '
  end
endfunction

function! statusline#HardTimeFlag()
  if exists("b:hardtime_on") && b:hardtime_on == 1
    return '  '
  else
    return ''
  endif
endfunction

function! statusline#BranchFlag()
  let l:branch = split(fugitive#head(),'\/')

  if len(l:branch) >= 1
    return l:branch[0].' '
  endif

  return ""
endfunction
