" PLUGIN: SirVer/ultisnips {{{
if has_key(g:plugs, 'Ultisnips')
  let g:UltiSnipsUsePythonVersion = 3
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsEditSplit='vertical'
  " let g:UltiSnipsExpandTrigger = ""
  let g:ulti_expand_or_jump_res = 0
  " let g:UltiSnipsEnableSnipMate = 1
  imap <expr><tab> pumvisible() ? "\<C-n>" : "\<TAB>"
  imap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<TAB>"
endif
" }}}


" PLUGIN: xolox/vim-session {{{
if has_key(g:plugs, 'vim-session')
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
if has_key(g:plugs, 'vim-sneak')
  let g:sneak#label = 1
  let g:sneak#target_labels = "aoeuhtns',.pygrl12345890[]"

  "fix sneak highlighting
  autocmd ColorScheme * hi Sneak cterm=reverse ctermfg=214 ctermbg=234
  autocmd ColorScheme * hi SneakScope cterm=reverse ctermfg=214 ctermbg=234
  autocmd ColorScheme * hi SneakLabel cterm=reverse ctermfg=214 ctermbg=234
  " autocmd ColorScheme * hi SneakScope cterm=reverse ctermfg=214 ctermbg=234

  " hi! link SneakPluginTarget Search
  " hi! link SneakStreakTarget Search
  " call s:HL('SneakStreakMask', s:yellow, s:yellow)
  " hi! link SneakStreakStatusLine Search

  " map <Leader> <plug>(sneak-prefix)
  " nmap <leader><leader> <Plug>(sneak-s)
endif
" }}}


" PLUGIN: tpope/vim-vinegar {{{
if has_key(g:plugs, 'vim-vinegar')
  let g:netrw_keepdir=0 " fixes issue when copying or moving files in netrw
  no <silent> <leader>wv <C-w>v
  no <silent> <leader>ws <C-w>s

  " Esc exits netrw and goes back to alternate buffer
  autocmd Filetype netrw no <buffer> <silent> <Esc> <c-^>
endif
" }}}

" PLUGIN: justinmk/vim-dirvish {{{
if has_key(g:plugs, 'vim-dirvish')

  no <silent> <leader>wv <C-w>v
  no <silent> <leader>ws <C-w>s

  " Disable Netrw
  let g:loaded_netrw       = 1
  let g:loaded_netrwPlugin = 1

  " Enable fugitive in dirvish buffers
  autocmd Filetype dirvish call fugitive#detect(@%)
endif
" }}}


" PLUGIN: vim-ruby/vim-ruby {{{
if has_key(g:plugs, 'vim-ruby')
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_rails = 1
endif
" }}}


" PLUGIN: int3/vim-extradite {{{
if has_key(g:plugs, 'vim-extradite')
  let g:gitgutter_eager=0
endif
" }}}


" PLUGIN: mattn/gist-vim {{{
if has_key(g:plugs, 'gist-vim')
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_show_privates = 1
  let g:gist_update_on_write = 1
endif
" }}}


" PLUGIN: tpope/vim-rails {{{
if has_key(g:plugs, 'vim-rails')
  nnoremap <leader>mr <c-u>:Rrunner<CR>
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
if has_key(g:plugs, 'vim-maximizer')
  " Settings {{{
    let g:maximizer_set_default_mapping = 0
    let g:maximizer_restore_on_winleave = 1

  " Keybindings {{{
    nmap <silent> <leader>wz :MaximizerToggle<cr>
    nmap <leader>bd :Bdelete!<CR>
  " }}}
endif
" }}}


" PLUGIN: mhinz/vim-signify {{{
if has_key(g:plugs, 'vim-signify')
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
if has_key(g:plugs, 'fzf.vim')
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



" PLUGIN: maksimr/vim-jsbeautify {{{
if has_key(g:plugs, 'vim-jsbeautify')
  "for Javascript
  autocmd FileType javascript,eruby.javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  autocmd FileType javascript,eruby.javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>

  "for html
  autocmd FileType html,html.javascript,eruby.html,handlebars noremap <buffer> <c-f> :call HtmlBeautify()<cr>
  autocmd FileType html,html.javascript,eruby.html,handlebars vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>

  "for css or scss
  autocmd FileType css,scss noremap <buffer> <c-f> :call CSSBeautify()<cr>
  autocmd FileType css,scss vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>
endif
" }}}


" PLUGIN: tpope/vim-fugitive {{{
if has_key(g:plugs, 'vim-fugitive')
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


" PLUGIN: SirVer/ultisnips {{{
if has_key(g:plugs, 'ultisnips')
  let g:ulti_expand_or_jump_res = 0
  let g:UltiSnipsEnableSnipMate = 1
  let g:UltiSnipsJumpForwardTrigger="<C-n>"
  let g:UltiSnipsJumpBackwardTrigger="<C-p>"
  let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
endif
" }}}


" PLUGIN: takac/vim-hardtime {{{
if has_key(g:plugs, 'vim-hardtime')
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
if has_key(g:plugs, 'vim-grepper')
  let g:grepper = {} " initialize g:grepper with empty dictionary
  let g:grepper.tools = ['ag', 'git', 'grep']
  let g:grepper.jump = 1
  let g:grepper.stop = 100

  command! Ag :Grepper
  nnoremap <silent> <leader>/ :<C-u>Grepper<CR>
endif
" }}}


" PLUGIN: terryma/vim-expand-region {{{
if has_key(g:plugs, 'vim-expand-region')
  vmap v <Plug>(expand_region_expand)
endif
" }}}


" PLUGIN: w0rp/ale {{{
if has_key(g:plugs, 'ale')
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
if has_key(g:plugs, 'vim-tmux-navigator')
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
if has_key(g:plugs, 'tabular')
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
if has_key(g:plugs, 'vim-polyglot')
  let g:used_javascript_libs = 'underscore,backbone,react,flux'
  let g:javascript_conceal_function             = "ƒ"
  let g:javascript_conceal_return               = "⬅"
  let g:javascript_conceal_arrow_function       = "⇒"
  let g:javascript_conceal_noarg_arrow_function = "➡"
  syntax match jsOperator /<=/ conceal cchar=≤
  syntax match jsOperator />=/ conceal cchar=≥
  syntax match jsOperator /!=/ conceal cchar=≢
  syntax keyword Statement lambda conceal cchar=λ
  set conceallevel=2
endif
" }}}

" PLUGIN: zefei/vim-wintabs {{{
if has_key(g:plugs, 'vim-wintabs')
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


" PLUGIN: morhetz/gruvbox {{{
if has_key(g:plugs, 'gruvbox')
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
if has_key(g:plugs, 'cake16')
  function! ActivateColorScheme()
    colorscheme cake16
    set background=light
    hi! User1 guifg=#d0c7b8 guibg=#FFFFFF
    " hi! User2 ctermfg=10 ctermbg=12 guifg=#82a3b3 guibg=#678797
    hi! link vertsplit cursorlinenr
    hi! link TabLineFill DiffText
    hi! link QuickFixMenuLine PMenuSel
  endfunction
endif
" }}}



" PLUGIN: roxma/nvim-completion-manager {{{
if has_key(g:plugs, 'nvim-completion-manager')
  set shortmess+=c
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif
" }}}
