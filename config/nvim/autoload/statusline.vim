function! statusline#WintabsInfo()
  if exists("w:wintabs_buflist")
    let current_buffer_index = index(w:wintabs_buflist, bufnr('%'))+1
    let wintab_buffers_count = len(w:wintabs_buflist)
    return "  ".current_buffer_index.":".wintab_buffers_count."│"
  else
    return ''
  endif
endfunction

function! statusline#PasteFlag()
  if &paste
    return '  '
  else
    return ''
  endif
endfunction

function! statusline#SpellFlag()
  if &spell
    return ' ¶ '
  else
    return ''
  endif
endfunction

function! statusline#SyntaxFlag()
  if has_key(g:plugs, 'ale')
    let l:res = ale#statusline#Status()
    if l:res ==# 'OK'
      return ''
    else
      return '  '
    end
  else
    return ''
  endif
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
