" ------------------------------------------------------------------------------
" SirVer/ultisnips {{{
" ------------------------------------------------------------------------------
if dein#tap('Ultisnips')
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" xolox/vim-session {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-session')
  let g:session_autoload = 'no'
  let g:session_autosave = 'yes'
  let g:session_autosave_periodic = 30
  let g:session_default_to_last = 0
  let g:session_persist_font = 1
  let g:session_persist_colors = 1
  let g:session_directory = '~/.config/nvim/sessions'
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Yggdroot/indentLine {{{
" ------------------------------------------------------------------------------
if dein#tap('indentLine')
  let g:indentLine_char = '┆'
  let g:indentLine_indentLevel = 20
  let g:indentLine_bufNameExclude = ['terminal']
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" othree/javascript-libraries-syntax.vim {{{
" ------------------------------------------------------------------------------
if dein#tap('javascript-libraries-syntax.vim')
  let g:used_javascript_libs = 'underscore,backbone,react,flux'
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" justinmk/vim-sneak {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-sneak')
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" tpope/vim-vinegar {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-vinegar')
  let g:netrw_keepdir=0 " fixes issue when copying or moving files in netrw
  no <silent> <leader>wv <C-w>v
  no <silent> <leader>ws <C-w>s

  " Esc exits netrw and goes back to alternate buffer
  autocmd Filetype netrw no <buffer> <silent> <Esc> <c-^>
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-ruby/vim-ruby {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-ruby')
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_rails = 1
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" int3/vim-extradite {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-extradite')
  let g:gitgutter_eager=0
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" mattn/gist-vim {{{
" ------------------------------------------------------------------------------
if dein#tap('gist-vim')
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_show_privates = 1
  let g:gist_update_on_write = 1
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" tpope/vim-rails {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-rails')
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-maximizer {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-maximizer')
  " Settings {{{
    let g:maximizer_set_default_mapping = 0
    let g:maximizer_restore_on_winleave = 1

  " Keybindings {{{
    nmap <silent> <leader>wz :MaximizerToggle<cr>
    nmap <leader>bd :Bdelete!<CR>
  " }}}
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" mhinz/vim-signify {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-signify')
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" junegunn/fzf.vim {{{
" ------------------------------------------------------------------------------
if dein#tap('fzf.vim')
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

  " Keybindings {{{
    " nnoremap <silent> <leader>ff :<C-u>call Fzf_dev()<CR>
    nnoremap <silent> <leader>pf :<C-u>Files<CR>
    nnoremap <silent> <leader>fc :<C-u>call fzf#FilesInCwd()<CR>
    nnoremap <silent> <leader>bb :<C-u>Buffers<CR>
    nnoremap <silent> <leader>W :<C-u>Windows<CR>
    nnoremap <silent> <leader>; :<C-u>BLines<CR>
    nnoremap <silent> <leader>. :<C-u>Lines<CR>
    nnoremap <silent> <leader>o :<C-u>BTags<CR>
    nnoremap <silent> <leader>O :<C-u>Tags<CR>
    nnoremap <silent> <leader>: :<C-u>Commands<CR>
    nnoremap <silent> <leader>? :<C-u>History<CR>
    nnoremap <silent> <leader>p/ :<C-u>Ag<CR>
    nnoremap <silent> <leader>/ :<C-u>Ag<CR>
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" maksimr/vim-jsbeautify {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-jsbeautify')
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" tpope/vim-fugitive {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-fugitive')
  nnoremap <silent> <leader>gs  :Gstatus<CR>
  nnoremap <silent> <leader>gd  :Gvdiff<CR>
  nnoremap <silent> <leader>gc  :Gcommit<CR>
  nnoremap <silent> <leader>gb  :Gblame<CR>
  nnoremap <silent> <leader>gp  :Git push<CR>
  nnoremap <silent> <leader>gr  :Gread<CR>
  nnoremap <silent> <leader>gw  :Gwrite<CR>
  nnoremap <silent> <leader>gwq :Gwrite<CR>:qa<CR>
  nnoremap <silent> <leader>ge  :Gedit<CR>

  " Automatically remove fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" mattn/emmet-vim {{{
" ------------------------------------------------------------------------------
if dein#tap('emmet-vim')
  imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")
  let g:user_emmet_next_key='<C-n>'
  let g:user_emmet_install_global = 1
  let g:user_emmet_settings = {
        \'html.javascript' : {
          \'extends' : 'html',
          \'filters' : 'html'
        \}
      \}
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Shougo/deoplete.nvim {{{
" ------------------------------------------------------------------------------
if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#disable_auto_complete = 0 "disable auto autocompletion
  let g:deoplete#auto_complete_start_length = 1 "also show completion with single character

  " TODO: sometimes this behaviour is broken and makes it impossible to enter a \n if the last word
  " of a sentence is a trigger for a snippet
  " Make <cr> select the candidate and if it's a snippet expand it.
  " inoremap <silent> <CR> <C-r>=<SID>trySelectCandidate()<CR>

  function! s:trySelectCandidate()
    if pumvisible()
      call deoplete#mappings#close_popup() "close deoplete
      let snippet = UltiSnips#ExpandSnippetOrJump()
      if g:ulti_expand_or_jump_res > 0
        return snippet
      else
        return "\<CR>"
      endif
    else
     return "\<CR>"
    endif
  endfunction
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" SirVer/ultisnips {{{
" ------------------------------------------------------------------------------
if dein#tap('ultisnips')
  let g:ulti_expand_or_jump_res = 0
  let g:UltiSnipsEnableSnipMate = 1
  let g:UltiSnipsJumpForwardTrigger="<C-n>"
  let g:UltiSnipsJumpBackwardTrigger="<C-p>"
  let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" nathanaelkane/vim-indent-guides {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-indent-guides')
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_color_change_percent = 5
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'terminal']
    let g:indent_guides_start_level = 2
    let g:indent_guides_enable_on_vim_startup = 1
  endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" takac/vim-hardtime {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-hardtime')
  let g:hardtime_default_on = 1
  let g:hardtime_showmsg = 0 " Show message
  let g:hardtime_allow_different_key = 1 " This allows jh but not jj
  let g:hardtime_ignore_quickfix = 1 " Ignore hardtime when in quickfix buffer
  let g:hardtime_timeout = 100

  let g:list_of_normal_keys = ["h", "j", "k", "l", "+"]
  let g:list_of_visual_keys = ["h", "j", "k", "l", "+"]
endif
" }}}
" ------------------------------------------------------------------------------

if dein#tap('vim-grepper')
  let g:grepper = {} " initialize g:grepper with empty dictionary
  let g:grepper.tools = ['ag', 'git', 'grep']
  let g:grepper.jump = 1
  let g:grepper.stop = 500

  command! Ag :Grepper
  nnoremap <silent> <leader>/ :<C-u>Grepper<CR>
endif

" ------------------------------------------------------------------------------
" skwp/greplace.vim {{{
" ------------------------------------------------------------------------------
if dein#tap('greplace')
  set grepprg=ag

  let g:grep_cmd_opts = '--line-numbers --noheading'
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" terryma/vim-expand-region {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-expand-region')
  vmap v <Plug>(expand_region_expand)
endif
" }}}

" ------------------------------------------------------------------------------
" t9md/vim-choosewin {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-choosewin')
  let g:choosewin_label = 'aoeuhtns'
  let g:choosewin_color_label = {
          \ 'cterm': [2, 16]
          \ }
  let g:choosewin_color_label_current = {
        \ 'cterm': [9, 16]
        \ }

  nnoremap <leader>wc :<c-u>:ChooseWin<CR>
endif
" }}}

" ------------------------------------------------------------------------------
" w0rp/ale {{{
" ------------------------------------------------------------------------------
if dein#tap('ale')
  " let g:ale_sign_error = '✖'
  " let g:ale_sign_warning = '⚠'
  let g:ale_sign_error = '•'
  let g:ale_sign_warning = '•'
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" christoomey/vim-tmux-navigator {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-tmux-navigator')
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" godlygeek/tabular {{{
" ------------------------------------------------------------------------------
if dein#tap('tabular')
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-ctrlspace/vim-ctrlspace {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-ctrlspace')
  " Settings for MacVim and powerline fonts
   let g:CtrlSpaceSymbols = {}
   let g:CtrlSpaceSymbols = {
   \"CS": "",
   \"File": " FILES",
   \"All": "፨ All",
   \"CTab": "▣ CTAB",
   \"Tabs": " TABS",
   \"Sin": " HOME",
   \"Help": " HELP",
   \"SLeft": " : ",
   \"SRight": "",
   \"BM": " BOOKMARKS",
   \"Vis": " visible",
   \"IV": " invisible"
   \}
"                             ○ ◉                      
    " hi! link CtrlSpaceNormal   Normal
    " hi! link CtrlSpaceSelected PMenuSbar
    " hi! link CtrlSpaceSearch   Conditional
    " hi! link CtrlSpaceStatus   Cursor

  " set ag as command to be used by Ctrl Space
  if executable("ag")
      let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  endif

  " Automatically persist workspace
  let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
  let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
  let g:CtrlSpaceSaveWorkspaceOnExit = 1

  " disable default mapping
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "
  " let g:CtrlSpaceSetDefaultMapping = 0
  " nmap <leader><leader> <c-u>:CtrlSpace<cr>
  "
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" christoomey/vim-tmux-navigator {{{
" ------------------------------------------------------------------------------
if dein#tap('vim-polyglot')
  let g:javascript_conceal_function             = "ƒ"
  let g:javascript_conceal_this                 = "@"
  let g:javascript_conceal_return               = "⏎"
  let g:javascript_conceal_undefined            = "¿"
  let g:javascript_conceal_arrow_function       = "⇒"
  " let g:javascript_conceal_noarg_arrow_function = "⇒"
  syntax match Operator "<=" conceal cchar=≤
  syntax match Operator ">=" conceal cchar=≥
  syntax match Operator "!=" conceal cchar=≢

  set conceallevel=1
endif
" }}}
" ------------------------------------------------------------------------------

