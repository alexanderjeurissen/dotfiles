" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
 call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
 copen
 " cc " Open first match
endfunction

let g:fzf_action = {
      \ 'ctrl-o': function('s:build_quickfix_list'),
      \ 'ctrl-r': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

let g:fzf_default_options = [
      \'--ansi',
      \'--multi',
      \'--sort',
      \'--bind=ctrl-a:select-all,ctrl-d:deselect-all'
      \ ]

  " Replace current buffer with search window
  let g:fzf_layout = { 'window': 'enew' }

" Customize fzf colors to match your color scheme
  let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
" }}}

" Keybindings & commands {{{
command! Files call s:fzf_Files()
command! NeighbouringFiles call s:fzf_NeighbouringFiles()
command! GitFiles call s:fzf_GitFiles()
command! GitBranchFiles call s:fzf_GitBranchFiles()
command! Buffers call s:fzf_Buffers()

nnoremap <silent> <leader>fc :<C-u>NeighbouringFiles<CR>
nnoremap <silent> <leader>pf :<C-u>Files<CR>
nnoremap <silent> <leader>bb :<C-u>Buffers<CR>
nnoremap <silent> <leader>gf :<C-u>GitFiles<CR>
nnoremap <silent> <leader>gF :<C-u>GitBranchFiles<CR>

nnoremap <silent> <leader>rh :<C-u>FZF app<CR>
nnoremap <silent> <leader>rl :<C-u>FZF lib<CR>
nnoremap <silent> <leader>rs :<C-u>FZF spec<CR>

nnoremap <silent> <leader>rf :<C-u>FZF spec/factories<CR>
nnoremap <silent> <leader>rfi :<C-u>FZF spec/fixtures<CR>
nnoremap <silent> <leader>rmi :FZF db/migrate<CR>
" }}}

" Functions {{{
function! s:fzf_Statusline()
  echom "kerk"
  setlocal statusline=%#fzf1#\ FZF\ -\ %{g:fzf_current_mode}
endfunction

function! s:fzf_Files()
  let g:fzf_current_mode = 'Files'
  call fzf#run(fzf#wrap({ 'options': g:fzf_default_options }))
endfunction


function! s:fzf_Buffers()
  let g:fzf_current_mode = 'Buffers'
  function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
  endfunction

  function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
  endfunction

  call fzf#run(fzf#wrap({
        \ 'source':  reverse(<sid>buflist()),
        \ 'sink':    function('s:bufopen'),
        \ 'options': g:fzf_default_options,
        \ }))
endfunction


"NOTE: Files that are in the same directory as the current buffer
function! s:fzf_NeighbouringFiles()
  let g:fzf_current_mode = 'NeighbouringFiles'
  let current_file = expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = $FZF_DEFAULT_COMMAND . ' --maxdepth 1'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'dir': cwd,
        \ 'options': g:fzf_default_options
        \ }))
endfunction


"NOTE: Files that are tracked by Git in $PWD that are dirty
function! s:fzf_GitFiles()
  let g:fzf_current_mode = 'GitFiles'
  let command = 'git diff --name-only'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options
        \ }))
endfunction


"NOTE: Files in $PWD that have changed in current branch compared to develop
function! s:fzf_GitBranchFiles()
  let g:fzf_current_mode = 'GitBranchFiles'
  let command = 'git diff --name-only develop'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options
        \ }))
endfunction
" }}}
