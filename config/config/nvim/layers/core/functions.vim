
" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-e>"
    endif
endfunction

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" save session
fun! WriteSession()
  let cwd = fnamemodify('.', ':p:h:t')
  let dateStamp = strftime("%d-%m-%Y_%H:%M")
  let extension = ".session"
  let fname = cwd . "_" . dateStamp . extension

  silent exe ":UniteSessionSave " . fname
  echo "Wrote " . fname
endfun


"
" Layer specific functions
" TODO: a layer should register using following object:
" {name:string, filetypes, callback}
" calling register should return a UID so that the layer function can deactivate
" itself easily etc.
"

let g:layers = []

fun! RegisterLayer(layer)
  call add(g:layers, {'text': a:layer})
endfun

fun! RemoveLayer(layer)
  let index = index(g:layers, layer)
  call remove(g:layers, index)
endfun

" initialize all layers this has to take place after adding
" all layers to the runtime using runtime commands
autocmd BufRead,BufNewFile *.* :call InitializeLayers()

fun! InitializeLayers()
  " augroup vimrcEx
  "   autocmd!
  "   for layer in g:layers
  "     autocmd BufRead,BufNewFile
  " augroup END
  echom "test"
endfun

fun! ActiveLayers()
  echo "Active Layers:"
  for layer in g:layers
    echo "* " layer.text
  endfor
endfun
