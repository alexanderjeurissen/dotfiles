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
" let g:fzf_files_options = ' --preview "bat --theme=\"Solarized (light)\" --style=changes --color always {} | head -'.&lines.'"'
let g:fzf_files_options =''
" let g:fzf_files_options = '--preview "bat --theme="OneHalfLight" --style=numbers,changes --color always {} | head -100"'

" NOTE: Replace current buffer with search window
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': 'tabnew' }
let g:fzf_layout = { 'window': 'call general#FloatingWindow()' }

" Keybindings & commands {{{
command! Files call s:fzf_Files()
command! RG call s:fzf_Grep()
command! NeighbouringFiles call s:fzf_NeighbouringFiles()
command! GitFiles call s:fzf_GitFiles()
command! GitBranchFiles call s:fzf_GitBranchFiles()
command! Buffers call s:fzf_Buffers()

nnoremap <silent> <leader>fn :<C-u>NeighbouringFiles<CR>
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
" NOTE: inline path completion for import statements
function! s:fzf_insert_file_path()
  let command = $FZF_DEFAULT_COMMAND

  call fzf#run(fzf#wrap({
        \ 'source':  command,
        \ 'sink':    function('general#AppendToLine'),
        \ 'options': g:fzf_default_options.fzf#get_fzf_colors(),
        \ }))
endfunction

" NOTE: Fuzzy find files
function! s:fzf_Files()
  let g:fzf_current_mode = 'FILES'
  call fzf#run(fzf#wrap({ 'options': g:fzf_default_options. g:fzf_files_options . fzf#get_fzf_colors() }))
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
        \ 'options': g:fzf_default_options.fzf#get_fzf_colors().'--delimiter : --nth 4..'
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
        \ 'options': g:fzf_default_options.fzf#get_fzf_colors()
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
        \ 'options': g:fzf_default_options.fzf#get_fzf_colors()
        \ }))
endfunction


"NOTE: Files that are tracked by Git in $PWD that are dirty
function! s:fzf_GitFiles()
  let g:fzf_current_mode = 'GIT_FILES'
  let command = 'git diff --name-only'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options.fzf#get_fzf_colors()
        \ }))
endfunction


"NOTE: Files in $PWD that have changed in current branch compared to develop
function! s:fzf_GitBranchFiles()
  let g:fzf_current_mode = 'GIT_BRANCH_FILES'
  let command = 'git diff --name-only develop'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'options': g:fzf_default_options.fzf#get_fzf_colors()
        \ }))
endfunction


" NOTE: generate color settings string based on colorscheme, to be put in .zprofile
function! fzf#get_fzf_colors()
  let rules =
  \ { 'fg':      [['NormalFloat',       'fg#']],
    \ 'bg':      [['NormalFloat',       'bg#']],
    \ 'hl':      [['MatchParen',      'fg#']],
    \ 'fg+':     [['MatchParen', 'fg#'], ['Normal', 'fg#']],
    \ 'bg+':     [['PMenuSBar', 'bg#']],
    \ 'hl+':     [['MatchParen',    'fg#']],
    \ 'info':    [['MatchParen',      'fg#']],
    \ 'prompt':  [['MatchParen',  'fg#']],
    \ 'pointer': [['MatchParen',    'fg#']],
    \ 'marker':  [['MatchParen',      'fg#']],
    \ 'spinner': [['MatchParen',        'fg#']],
    \ 'header':  [['Comment',      'fg#']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && !empty(code)
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  " echom ' --color='.join(cols, ',')
  return ' --color='.join(cols, ',').' '
endfunction
" }}}
