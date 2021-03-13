scriptencoding utf-8

function! statusline#Init()
  let l:statusline_items = ' ' " left padding
  let l:statusline_items .= '%{statusline#FileInfoFlag()}'
  let l:statusline_items .= '%t'
  let l:statusline_items .= '%='
  let l:statusline_items .= '%{statusline#PasteFlag()}'
  let l:statusline_items .= '%{statusline#SpellFlag()}'
  let l:statusline_items .= '%{statusline#HardTimeFlag()}'
  let l:statusline_items .= '%{statusline#BranchFlag()}'

  return l:statusline_items
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
  if exists('b:hardtime_on') && b:hardtime_on == 1
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

  return ''
endfunction
