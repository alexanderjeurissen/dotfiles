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

let g:fzf_default_options = '--no-inline-info --multi --sort --layout=reverse --bind=ctrl-a:select-all,ctrl-d:deselect-all --color=bw,border:8,bg:8,info:2,prompt:12,fg:10,bg+:0,fg+:10,gutter:0 --border=sharp --prompt=" "'

" NOTE: Replace current buffer with search window
let g:fzf_layout = { 'window': 'call general#create_relative_centered_window()' }

" Keybindings & commands {{{
command! RG call s:fzf_Grep()
command! NeighbouringFiles call s:fzf_NeighbouringFiles()
command! GitBranchFiles call s:fzf_GitBranchFiles()
command! Buffers call s:fzf_Buffers()

nnoremap <silent> <leader>fn :<C-u>NeighbouringFiles<CR>
nnoremap <silent> <leader>bb :<C-u>Buffers<CR>
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
" NOTE: inline path completion for import statements
function! s:fzf_insert_file_path()
  let command = $FZF_DEFAULT_COMMAND

  call fzf#run(fzf#wrap({
        \ 'source':  command,
        \ 'sink':    function('general#AppendToLine'),
        \ 'options': g:fzf_default_options,
        \ }))
endfunction

" NOTE: Grep using RG
function! s:fzf_Grep()
  let g:fzf_current_mode = 'GREP'
  let command = 'rg --vimgrep -H --no-heading --column --smart-case -P "%s"'

  function! s:rg_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
          \ 'text': join(parts[3:], ':')}
  endfunction

  function! s:rg_handler(lines)
    if len(a:lines) < 2 | return | endif

    let list = map(a:lines[1:], 's:rg_to_qf(v:val)')

    let first = list[0]
    execute first.lnum
    execute 'normal!' first.col.'|zz'

    if len(list) > 1
      call setqflist(list)
      copen
      wincmd p
    endif
  endfunction

  call fzf#run(fzf#wrap({
        \ 'source':  printf(command,  escape('^(?=.)', '"\')),
        \ 'sink*':   function('s:rg_handler'),
        \ 'options': g:fzf_default_options.'--delimiter : --nth 4..'
        \ }))
endfunction


" NOTE: Open buffers
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
        \ 'options': g:fzf_default_options
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
