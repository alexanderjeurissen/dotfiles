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
  let g:sneak#target_labels = "aoeuhtns',.pygrl12345890[]"

  "fix sneak highlighting
  " autocmd ColorScheme * hi Sneak cterm=reverse ctermfg=214 ctermbg=234
  " autocmd ColorScheme * hi SneakScope cterm=reverse ctermfg=214 ctermbg=234
  " autocmd ColorScheme * hi SneakLabel cterm=reverse ctermfg=214 ctermbg=234
  " autocmd ColorScheme * hi SneakScope cterm=reverse ctermfg=214 ctermbg=234
endif
" }}}


" PLUGIN: justinmk/vim-dirvish {{{
if has_key(g:minpac#pluglist, 'vim-dirvish')
  " Enable fugitive in dirvish buffers
  autocmd Filetype dirvish call fugitive#detect(@%)
endif
" }}}


" PLUGIN: mattn/gist-vim {{{
if has_key(g:minpac#pluglist, 'gist-vim')
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_show_privates = 1
  let g:gist_update_on_write = 1
endif
" }}}


" PLUGIN: tpope/vim-rails {{{
if has_key(g:minpac#pluglist, 'vim-rails')
  nnoremap <leader>mr <c-u>:Rrunner<CR>
  nnoremap <leader>rC :call tmux#RunSpecAtLine()<CR>

  let g:rails_projections = {
    \"app/models/*.rb": {
    \  "alternate": ["spec/integration/models/%s_spec.rb"],
    \  "related": ["spec/factories/%s.rb"],
    \},
    \"spec/integration/models/*_spec.rb": {
    \  "alternate": ["app/models/%s.rb"],
    \},
    \"spec/factories/*.rb": {
    \  "alternate": ["app/models/%s.rb"],
    \},
    \"app/controllers/*.rb": {
    \  "alternate": ["spec/integration/controllers/%s_spec.rb"],
    \},
    \"spec/integration/controllers/*_spec.rb": {
    \  "alternate": ["app/controllers/%s.rb"],
    \},
    \"app/mailers/*.rb": {
    \  "alternate": ["spec/integration/mailers/%s_spec.rb"],
    \},
    \"spec/integration/mailers/*_spec.rb": {
    \  "alternate": ["app/mailers/%s.rb"],
    \},
    \"app/backend/*.rb": {
    \  "alternate": ["spec/integration/backend/%s_spec.rb"],
    \},
    \"spec/integration/backend/*_spec.rb": {
    \  "alternate": ["app/backend/%s.rb"],
    \},
    \"lib/support/app/controllers/support/*.rb": {
    \  "alternate": ["spec/integration/controllers/support/%s_spec.rb"]
    \},
    \"spec/integration/controllers/support/*_spec.rb": {
    \  "alternate": ["lib/support/app/controllers/support/%s.rb"]
    \},
    \"lib/api/app/controllers/*.rb": {
    \  "alternate": ["spec/integration/controllers/support/%s_spec.rb"]
    \},
    \"lib/api/spec/controllers/*_spec.rb": {
    \  "alternate": ["lib/api/app/controllers/%s.rb"]
    \},
    \"db/migrate/*.rb": {
    \  "alternate": ["spec/integration/migrations/%s_spec.rb"]
    \},
    \"spec/integration/migrations/*_spec.rb": {
    \  "alternate": ["db/migrate/%s.rb"]
    \},
  \}
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
    " Default fzf layout
    " - down / up / left / right
    " - window (nvim only)
    " let g:fzf_layout = { 'window': 'rightbelow 100new' }
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

      autocmd! User FzfStatusLine call fzf#Statusline()
  " }}}

  " Ag search {{{
    command! -bang -nargs=* Find call fzf#vim#ag(<q-args>, '--literal --ignore-case ', {'window': 'enew'})
    command! -bang -nargs=* Locate call fzf#vim#ag(<q-args>, '--literal --ignore-case -l ', {'window': 'enew'})
  " }}}

    command! -nargs=* WintabsChose call fzf#WintabsBuffers()

  " Keybindings {{{
    " nnoremap <silent> <leader>ff :<C-u>call Fzf_dev()<CR>
    nnoremap <silent> <leader>pf :<C-u>Files<CR>
    nnoremap <silent> <leader>fc :<C-u>call fzf#NeighbouringFiles()<CR>
    nnoremap <silent> <leader>bb :<C-u>Buffers<CR>
    nnoremap <silent> <leader>; :<C-u>BLines<CR>
    nnoremap <silent> <leader>. :<C-u>Lines<CR>
    nnoremap <silent> <leader>o :<C-u>BTags<CR>
    nnoremap <silent> <leader>O :<C-u>Tags<CR>
    nnoremap <silent> <leader>: :<C-u>Commands<CR>
    nnoremap <silent> <leader>? :<C-u>History<CR>
    nnoremap <silent> <leader>p/ :<C-u>Ag<CR>
    " nnoremap <silent> <leader>/ :<C-u>Ag<CR>
    nnoremap <silent> <leader>gl :<C-u>Commits<CR>
    nnoremap <silent> <leader>ga :<C-u>BCommits<CR>
    nnoremap <silent> <leader>gf :<C-u>GitFiles?<CR>
    nnoremap <silent> <leader>gF :<C-u>call fzf#FilesChangedInBranch()<CR>

    nnoremap <silent> <leader>rm :<C-u>FZF app/models<CR>
    nnoremap <silent> <leader>rc :<C-u>FZF app/controllers<CR>
    nnoremap <silent> <leader>rv :<C-u>FZF app/views<CR>
    nnoremap <silent> <leader>rl :<C-u>FZF ./lib<CR>

    nnoremap <silent> <leader>rs :<C-u>FZF spec<CR>
    nnoremap <silent> <leader>rsm :<C-u>FZF spec/integration/models<CR>
    nnoremap <silent> <leader>rsc :<C-u>FZF spec/integration/controllers<CR>

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
  " Automatically remove fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif
" }}}


" PLUGIN: takac/vim-hardtime {{{
if has_key(g:minpac#pluglist, 'vim-hardtime')
  let g:hardtime_default_on = 1
  let g:hardtime_showmsg = 0 " Show message
  let g:hardtime_allow_different_key = 1 " This allows jh but not jj
  let g:hardtime_ignore_quickfix = 1 " Ignore hardtime when in quickfix buffer
  let g:hardtime_timeout = 100

  let g:list_of_normal_keys = ["h", "j", "k", "l", "+"]
  let g:list_of_visual_keys = ["h", "j", "k", "l", "+"]
endif
" }}}


" PLUGIN: mhinz/vim-grepper {{{
if has_key(g:minpac#pluglist, 'vim-grepper')
  let g:grepper = {} " initialize g:grepper with empty dictionary
  let g:grepper.tools = ['rg', 'ag', 'git', 'grep']
  let g:grepper.jump = 1
  let g:grepper.stop = 100

  command! Ag :Grepper
  nnoremap <silent> <leader>/ :<C-u>Grepper<CR>
endif
" }}}


" PLUGIN: w0rp/ale {{{
if has_key(g:minpac#pluglist, 'ale')
  " let g:ale_sign_error = '✖'
  " let g:ale_sign_warning = '⚠'
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


" PLUGIN: christoomey/vim-tmux-navigator {{{
if has_key(g:minpac#pluglist, 'vim-polyglot')
  let g:used_javascript_libs = 'underscore,backbone,react,flux'
  " let g:javascript_conceal_function             = "ƒ"
  " let g:javascript_conceal_return               = "⬅"
  " let g:javascript_conceal_arrow_function       = "⇒"
  " let g:javascript_conceal_noarg_arrow_function = "➡"
  " syntax match jsOperator /<=/ conceal cchar=≤
  " syntax match jsOperator />=/ conceal cchar=≥
  " syntax match jsOperator /!=/ conceal cchar=≢
  " syntax keyword Statement lambda conceal cchar=λ
  set conceallevel=2
endif
" }}}


" PLUGIN: zefei/vim-wintabs {{{
if has_key(g:minpac#pluglist, 'vim-wintabs')
  let g:wintabs_display = 'none'

  let g:wintabs_ui_modified = ''
  let g:wintabs_ui_readonly = ''

  " style active wintab for gruvbox
  " autocmd ColorScheme gruvbox hi User1 guifg=#353535 guibg=#7aab7d
  let g:wintabs_ui_active_higroup = 'DiffDelete'

  nmap <leader>bn <plug>(wintabs_next)
  nmap <leader>bp <plug>(wintabs_previous)
  nmap <leader>wn <plug>(wintabs_next)
  nmap <leader>wp <plug>(wintabs_previous)
  nmap <leader>wc :q<cr>
  nmap <leader>wd <plug>(wintabs_close)
  nmap <leader>wt <plug>(wintabs_maximize)
  nmap <leader>wa <plug>(wintabs_all)
  nmap <leader>wo <plug>(wintabs_only)
  nmap <leader>tc <plug>(wintabs_close_vimtab)
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


" PLUGIN: morhetz/gruvbox {{{
if has_key(g:minpac#pluglist, 'gruvbox')
  let g:gruvbox_italic=1
  let g:gruvbox_italicize_strings=1
  let g:gruvbox_contrast_dark='soft'
  let g:gruvbox_contrast_light='soft'

  function! ActivateColorScheme()
    colorscheme gruvbox
  endfunction
endif
" }}}


" PLUGIN: zefei/cake16 {{{
if has_key(g:minpac#pluglist, 'cake16')
  function! ActivateColorScheme()
    colorscheme cake16
    set background=light
    hi! link vertsplit cursorlinenr
    hi! link TabLineFill DiffText
    hi! link QuickFixMenuLine PMenuSel
  endfunction
endif
" }}}


" PLUGIN: Zabanaa/neuromancer.vim {{{
if has_key(g:minpac#pluglist, 'neuromancer.vim')
  function! ActivateColorScheme()
    colorscheme neuromancer
      hi! link Float Number
      hi! link Whitespace ErrorMsg
      hi! link SignColumn LineNr
  endfunction
endif
" }}}


" PLUGIN: ajmwagar/vim-deus {{{
if has_key(g:minpac#pluglist, 'vim-deus')
  function! ActivateColorScheme()
    set background=dark
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
  endfunction
endif
" }}}


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
  nnoremap <silent>gd :call LanguageClient_textDocument_definition()<CR>
  " K for type info under cursor
  nnoremap <silent>K :call LanguageClient_textDocument_hover()<CR>
  " " <leader>lr to rename variable under cursor
  " nnoremap <leader>lr :call LanguageClient_textDocument_rename()<cr>

  " <leader>ls to fuzzy search symbols in current buffer
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lr :call LanguageClient_textDocument_references()<CR>

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
