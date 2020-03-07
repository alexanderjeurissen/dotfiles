" NOTE: An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
 call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
 copen
endfunction

let g:fzf_action = {
      \ 'ctrl-o': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

let g:fzf_default_options = '--inline-info --multi --sort --layout=reverse --bind=ctrl-a:select-all,ctrl-d:deselect-all'
" let g:fzf_files_options = '--preview "bat --theme="OneHalfLight" --style=numbers,changes --color always {} | head -'.&lines.'"'
let g:fzf_files_options = '--preview "bat --theme="OneHalfLight" --style=numbers,changes --color always {} | head -100"'

" NOTE: Replace current buffer with search window
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': 'tabnew' }
" let g:fzf_layout = { 'window': 'tabnew' }
" let g:fzf_layout = { 'window': 'call general#FloatingWindow()' }

" NOTE: Open a new tab with search window
" let g:fzf_layout = { 'window': '-tabnew' }

" NOTE: don't specify any colors, so it falls back on default opts --color bw
" let g:fzf_colors = {}

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
imap <silent> <C-F> <C-O>:call <sid>fzf_insert_file_path()<CR>

" }}}

" Functions {{{
function! s:fzf_insert_file_path()
  let command = $FZF_DEFAULT_COMMAND

  call fzf#run(fzf#wrap({
        \ 'source':  command,
        \ 'sink':    function('general#AppendToLine'),
        \ 'options': g:fzf_default_options,
        \ }))
endfunction

function! s:fzf_Files()
  let g:fzf_current_mode = 'FILES'
  call fzf#run(fzf#wrap({ 'options': g:fzf_default_options . ' ' . g:fzf_files_options }))
endfunction


function! s:fzf_Buffers()
  let g:fzf_current_mode = 'BUFFERS'
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
  let g:fzf_current_mode = 'CWD_FILES'
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
  let g:fzf_current_mode = 'GIT_FILES'
  let command = 'git diff --name-only'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options
        \ }))
endfunction


"NOTE: Files in $PWD that have changed in current branch compared to develop
function! s:fzf_GitBranchFiles()
  let g:fzf_current_mode = 'GIT_BRANCH_FILES'
  let command = 'git diff --name-only develop'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options
        \ }))
endfunction
" }}}
