" PLUGIN: SirVer/ultisnips {{{
if has_key(g:minpac#pluglist, 'Ultisnips')
  let g:UltiSnipsUsePythonVersion = 3
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsEditSplit='vertical'
  let g:ulti_expand_or_jump_res = 0
  let g:UltiSnipsEnableSnipMate = 1

  imap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
  imap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"

  let g:UltiSnipsJumpForwardTrigger="<C-n>"
  let g:UltiSnipsJumpBackwardTrigger="<C-p>"
  let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
endif
" }}}


" PLUGIN: xolox/vim-session {{{
if has_key(g:minpac#pluglist, 'vim-session')
  let g:session_autoload = 'no'
  let g:session_autosave = 'yes'
  let g:session_autosave_periodic = 30
  let g:session_default_to_last = 0
  let g:session_persist_font = 1
  let g:session_persist_colors = 1
  let g:session_directory = '~/.config/nvim/sessions'
endif
" }}}


" PLUGIN: justinmk/vim-sneak {{{
if has_key(g:minpac#pluglist, 'vim-sneak')
  let g:sneak#label = 1
  let g:sneak#target_labels = "aoeuhtnsidAOEUHTNSID ',.pgrlfyPGRLFY"
endif
" }}}


" PLUGIN: justinmk/vim-dirvish {{{
if has_key(g:minpac#pluglist, 'vim-dirvish')
  " Enable fugitive in dirvish buffers
  autocmd Filetype dirvish call fugitive#detect(@%)
endif
" }}}


" PLUGIN: tpope/vim-rails {{{
if has_key(g:minpac#pluglist, 'vim-rails')
  nnoremap <leader>rC :.Runner<CR>
  nnoremap <leader>rA :Runner<CR>
endif
" }}}


" PLUGIN: vim-maximizer {{{
if has_key(g:minpac#pluglist, 'vim-maximizer')
  let g:maximizer_set_default_mapping = 0
  let g:maximizer_restore_on_winleave = 1

  nmap <silent> <leader>wz :MaximizerToggle<cr>
endif
" }}}


" PLUGIN: mhinz/vim-signify {{{
if has_key(g:minpac#pluglist, 'vim-signify')
  let g:signify_vcs_list = ['git']
  let g:signify_sign_add               = '+'
  let g:signify_sign_delete            = '_'
  let g:signify_sign_delete_first_line = '‾'
  let g:signify_sign_change            = '!'
  let g:signify_sign_changedelete      = g:signify_sign_change
  let g:signify_update_on_bufenter    = 0
  let g:signify_update_on_focusgained = 1
endif
" }}}


" PLUGIN: junegunn/fzf.vim {{{
if has_key(g:minpac#pluglist, 'fzf.vim')
  " Color/display options {{{
    let g:fzf_layout = { 'window': 'enew' }
    let g:fzf_mode = ''

    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
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

      imap <c-x><c-f> <plug>(fzf-complete-path)
      imap <c-x><c-/> <plug>(fzf-complete-file-ag)
  " }}}

  " Keybindings {{{
    nnoremap <silent> <leader>pf :<C-u>Files<CR>
    nnoremap <silent> <leader>fc :<C-u>call fzf#NeighbouringFiles()<CR>
    nnoremap <silent> <leader>bb :<C-u>Buffers<CR>
    nnoremap <silent> <leader>; :<C-u>BLines<CR>
    nnoremap <silent> <leader>. :<C-u>Lines<CR>
    nnoremap <silent> <leader>: :<C-u>Commands<CR>
    nnoremap <silent> <leader>? :<C-u>History<CR>
    nnoremap <silent> <leader>gl :<C-u>Commits<CR>
    nnoremap <silent> <leader>gb :<C-u>BCommits<CR>
    nnoremap <silent> <leader>gf :<C-u>GitFiles?<CR>
    nnoremap <silent> <leader>gF :<C-u>call fzf#FilesChangedInBranch()<CR>

    nnoremap <silent> <leader>rh :<C-u>FZF app<CR>
    nnoremap <silent> <leader>rl :<C-u>FZF lib<CR>
    nnoremap <silent> <leader>rs :<C-u>FZF spec<CR>

    nnoremap <silent> <leader>rf :<C-u>FZF spec/factories<CR>
    nnoremap <silent> <leader>rfi :<C-u>FZF spec/fixtures<CR>
    nnoremap <silent> <leader>rmi :FZF db/migrate<CR>
  " }}}
endif
" }}}


" PLUGIN: tpope/vim-fugitive {{{
if has_key(g:minpac#pluglist, 'vim-fugitive')
  nnoremap <silent> <leader>gs  :Gstatus<CR>
  nnoremap <silent> <leader>gd  :Gvdiff<CR>
  nnoremap <silent> <leader>gc  :Gcommit<CR>
  nnoremap <silent> <leader>gb  :Gblame<CR>
  nnoremap <silent> <leader>gp  :Git push<CR>
  nnoremap <silent> <leader>gr  :Gread<CR>
  nnoremap <silent> <leader>gw  :Gwrite<CR>
  nnoremap <silent> <leader>gwq :Gwrite<CR>:qa<CR>
  nnoremap <silent> <leader>ge  :Gedit<CR>

  command! GreadDevelop Gread! show develop:%
endif
" }}}


" PLUGIN: mhinz/vim-grepper {{{
if has_key(g:minpac#pluglist, 'vim-grepper')
  let g:grepper = {} " initialize g:grepper with empty dictionary
  let g:grepper.tools = ['rg', 'ag', 'git', 'grep']
  let g:grepper.jump = 1
  let g:grepper.stop = 100

  nnoremap <silent> <leader>/ :<C-u>Grepper<CR>
endif
" }}}


" PLUGIN: w0rp/ale {{{
if has_key(g:minpac#pluglist, 'ale')
  let g:ale_sign_error = '◆'
  let g:ale_sign_warning = '◇'
  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'jsx': ['stylelint', 'eslint'],
  \   'ruby': ['rubocop'],
  \   'sh' : ['shellcheck'],
  \   'vim' : ['vint'],
  \   'html' : ['tidy'],
  \   'python' : ['flake8'],
  \   'markdown' : ['mdl']
  \}

  let g:ale_linter_aliases = {'jsx': 'css'}

  let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'

  " don't run linters when opening a file
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_save = 1
endif
" }}}


" PLUGIN: christoomey/vim-tmux-navigator {{{
if has_key(g:minpac#pluglist, 'vim-tmux-navigator')
  let g:tmux_navigator_no_mappings = 0
  let g:tmux_navigator_save_on_switch = 1

  nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

  tnoremap <silent> <c-h> <C-\><C-n>:TmuxNavigateLeft<cr>
  tnoremap <silent> <c-j> <C-\><C-n>:TmuxNavigateDown<cr>
  tnoremap <silent> <c-k> <C-\><C-n>:TmuxNavigateUp<cr>
  tnoremap <silent> <c-l> <C-\><C-n>:TmuxNavigateRight<cr>
  tnoremap <silent> <c-\> <C-\><C-n>:TmuxNavigatePrevious<cr>
endif
" }}}


" PLUGIN: hkupty/nvimux {{{
if has_key(g:minpac#pluglist, 'nvimux')
   packadd nvimux

   tnoremap <C-h> <C-\><C-n><C-w>h
   tnoremap <C-j> <C-\><C-n><C-w>j
   tnoremap <C-k> <C-\><C-n><C-w>k
   tnoremap <C-l> <C-\><C-n><C-w>l
   noremap <C-h> <C-w>h
   noremap <C-j> <C-w>j
   noremap <C-k> <C-w>k
   noremap <C-l> <C-w>l
   inoremap <C-h> <Esc><C-w>h
   inoremap <C-j> <Esc><C-w>j
   inoremap <C-k> <Esc><C-w>k
   inoremap <C-l> <Esc><C-w>l

   let g:nvimux_open_term_by_default = 1

lua << EOF
   local nvimux = require('nvimux')

   -- Nvimux configuration
   nvimux.config.set_all{
     prefix = '<C-a>',
     open_term_by_default = true,
     new_window_buffer = 'single',
     quickterm_direction = 'botright',
     quickterm_orientation = 'vertical',
     -- Use 'g' for global quickterm
     quickterm_scope = 't',
     quickterm_size = '80',
   }

   -- Nvimux custom bindings
   nvimux.bindings.bind_all{
     {'s', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
     {'v', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
   }
EOF
endif
" }}}


" PLUGIN: godlygeek/tabular {{{
if has_key(g:minpac#pluglist, 'tabular')
  inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

  function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      Tabularize/|/l1
      normal! 0
      call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction
endif
" }}}


" PLUGIN: sheerun/vim-polygot {{{
if has_key(g:minpac#pluglist, 'vim-polyglot')
  let g:used_javascript_libs = 'underscore,backbone,react,flux'
  set conceallevel=2
endif
" }}}


" PLUGIN: moll/vim-bbye {{{
if has_key(g:minpac#pluglist, 'vim-bbye')
  nmap <leader>wc :q<cr>
  nmap <leader>bd :Bdelete<CR>

  " Delete all hidden buffers
  nnoremap <leader>bo :DeleteHiddenBuffers<CR>

  " Delete all buffers, but keep windows open
  nnoremap <leader>bw :bufdo :Bdelete<CR>
endif
" }}}


" PLUGIN: ajmwagar/vim-deus {{{
if has_key(g:minpac#pluglist, 'vim-deus')
  function! ActivateColorScheme()
    set background=dark
    colorscheme deus
    hi! link SignColumn LineNr
    hi! VertSplit guibg=#242a32
    hi! StatusLine guifg=#242a32 guibg=#ebdab2
    hi! StatusLineNC guifg=#242a32 guibg=#ebdab2
    hi! CursorLineNr guibg=#242a32 guifg=#ebdab2

    hi! SignColumn guibg=#242a32
    hi! SignifySignAdd guibg=#242a32 guifg=#99c379
    hi! SignifySignDelete guibg=#242a32 guifg=#fb4733
    hi! SignifySignChange guibg=#242a32 guifg=#8ec07b

    hi! AleWarningSign guibg=#242a32 guifg=#ebdab2

    hi! CursorLine guibg=#292f37
    hi! ColorColumn guibg=#292f37
    hi! link WhiteSpace AleErrorSign
    hi! link QuickFixLine DiffText
  endfunction
endif
" }}}

" PLUGIN: arcticicestudio/nord-vim {{{
if has_key(g:minpac#pluglist, 'nord-vim')
  function! ActivateColorScheme()
   colorscheme nord
  endfunction
endif
"}}}


" PLUGIN: roxma/nvim-completion-manager {{{
if has_key(g:minpac#pluglist, 'nvim-completion-manager')
  set shortmess+=c
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif
" }}}


" PLUGIN: autozimu/LanguageClient-neovim {{{
if has_key(g:minpac#pluglist, 'LanguageClient-neovim')
  " Automatically start language servers.
  let g:LanguageClient_autoStart = 0
  let g:LanguageClient_serverCommands = {}
  let g:LanguageClient_diagnosticsEnable = 0

  " gd to go to definition
  " nnoremap <silent>gd :call LanguageClient_textDocument_definition()<CR>
  " K for type info under cursor
  " nnoremap <silent>K :call LanguageClient_textDocument_hover()<CR>
  " " <leader>lr to rename variable under cursor
  " nnoremap <leader>lr :call LanguageClient_textDocument_rename()<cr>

  " <leader>ls to fuzzy search symbols in current buffer
  " nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  " nnoremap <leader>lr :call LanguageClient_textDocument_references()<CR>

  "LANGSERVER: Javascript / Typescript {{{
    if executable('yarn')
      if !executable('javascript-typescript-stdio')
        echohl WarningMsg | echom "javascript lang server not installed" | echohl None
        exec '!yarn global add javascript-typescript-langserver'
      else
        " Use LanguageServer for omnifunc completion
        let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
        let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
      endif
    else
      echohl WarningMsg | echom "You need install yarn!" | echohl None
    endif
  " }}}
endif
" }}}
" vim: foldmethod=marker:sw=3
