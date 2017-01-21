" ------------------------------------------------------------------------------
" SirVer/ultisnips {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'Ultisnips')
  let g:UltiSnipsUsePythonVersion = 3
  let g:UltiSnipsExpandTrigger='<tab>'
  let g:UltiSnipsJumpForwardTrigger='<c-n>'
  let g:UltiSnipsJumpBackwardTrigger='<c-p>'
  let g:UltiSnipsEditSplit='vertical'
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" xolox/vim-session {{{
" ------------------------------------------------------------------------------
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" osyo-manga/vim-over {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-over')
  let g:over#command_line#paste_escape_chars = '/.*$^~'
  command! Replace OverCommandLine %s/
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Yggdroot/indentLine {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'indentLine')
  let g:indentLine_char = '┆'
  let g:indentLine_indentLevel = 20
  let g:indentLine_bufNameExclude = ['terminal']
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" othree/javascript-libraries-syntax.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'javascript-libraries-syntax.vim')
  let g:used_javascript_libs = 'underscore,backbone,react,flux'
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" justinmk/vim-sneak {{{
" ------------------------------------------------------------------------------
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" dangerzone/ranger.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'ranger.vim')
  command! Ranger call OpenRanger()
  no <silent> <leader>fe :call OpenRanger()<CR>
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-ruby/vim-ruby {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-ruby')
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_rails = 1
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" int3/vim-extradite {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-extradite')
  let g:gitgutter_eager=0
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" mattn/gist-vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'gist-vim')
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
if has_key(g:plugs, 'vim-rails')
  nnoremap <leader>mr <c-u>:Rrunner<CR>
  let g:rails_projections = {
    \"app/models/*.rb": {
    \  "alternate": ["spec/integration/models/%s_spec.rb"],
    \},
    \"spec/integration/models/*_spec.rb": {
    \  "alternate": ["app/models/%s.rb"],
    \},
    \"app/controllers/*.rb": {
    \  "alternate": ["spec/integration/controllers/%s_spec.rb"],
    \},
    \"spec/integration/controllers/*_spec.rb": {
    \  "alternate": ["app/controllers/%s.rb"],
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
  \}
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" zhaocai/GoldenView.Vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'GoldenView.Vim')
    " Settings {{{
      let g:maximizer_set_default_mapping = 0
      let g:maximizer_restore_on_winleave = 1

      let g:goldenview__enable_default_mapping = 0
      let g:goldenview__enable_at_startup = 0
      let g:goldenview__ignore_urule = {
      \  'filetype': [
      \    'nerdtree',
      \    'nerd',
      \    'unite',
      \    'gitcommit'
      \  ],
      \  'buftype': [
      \    'nofile',
      \    'nerd',
      \    'nerdtree',
      \    'terminal',
      \    'gitcommit'
      \  ]
      \}

      let g:goldenview__restore_urule= {
      \  'filetype': [
      \    'nerdtree',
      \    'nerd',
      \    'unite',
      \    'gitcommit'
      \  ],
      \  'buftype': [
      \    'nofile',
      \    'nerd',
      \    'nerdtree',
      \    'terminal',
      \    'gitcommit'
      \  ]
      \}
    " }}}

    " Functions {{{
      function! GoldenViewNext()
        execute "normal \<Plug>GoldenViewNext"
      endfunction

      function! GoldenViewPrevious()
        execute "normal \<Plug>GoldenViewPrevious"
      endfunction
    " }}}

      function! MaximiseCurrentWindow()
        call GoldenView#ToggleAutoResize()
        exec ":MaximizerToggle"
      endfunction

    " Keybindings {{{
      " 1. quickly switch current window with the main pane and toggle back
      nmap <silent> <leader>wm <Plug>GoldenViewSwitchMain
      nmap <silent> <leader>wt <Plug>GoldenViewSwitchToggle
      nmap <silent> <leader>wz :call MaximiseCurrentWindow()<cr>

      " 2. manipulate splits
      nmap <leader>wt <C-W>T
      nmap <leader>wd :q<CR>

      " 3. toggle auto resize
      nmap <silent> <leader>tg :ToggleGoldenViewAutoResize<CR>
    " }}}
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" mhinz/vim-signify {{{
" ------------------------------------------------------------------------------
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" junegunn/fzf.vim {{{
" ------------------------------------------------------------------------------
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

      function! s:fzf_statusline()
        " Override statusline as you like
        highlight! fzf1 ctermfg=15 ctermbg=12
        setlocal statusline=%#fzf1#\ \\ FZF

        if g:fzf_mode == 'Files'
          setlocal statusline=\ \\ Search\ for\ files
        elseif g:fzf_mode == 'Ag'
          setlocal statusline=\ \\ Search\ in\ files
        elseif g:fzf_mode == 'Mru'
          setlocal statusline=\ \\ Recent\ files
        elseif g:fzf_mode == 'Commands'
          setlocal statusline=\ \\ Commands
        elseif g:fzf_mode == 'Commands'
          setlocal statusline=\ \\ Killring
        endif
      endfunction

      autocmd! User FzfStatusLine call <SID>fzf_statusline()
  " }}}

  " Ag search {{{
    command! -bang -nargs=* Find call fzf#vim#ag(<q-args>, '--literal --ignore-case ', {'window': 'enew'})
    command! -bang -nargs=* Locate call fzf#vim#ag(<q-args>, '--literal --ignore-case -l ', {'window': 'enew'})
  " }}}

  " rails routes {{{
    command! -nargs=* RailsRoutes call fzf#run({
    \ 'source':  'rails_routes',
    \ 'sink*':    function('<sid>ag_handler'),
    \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 3.. '.
    \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
    \            '--color hl:68,hl+:110',
    \ 'down':    '50%'
    \ })
  " }}}

  " Files + devicons {{{
    function! Fzf_dev()
      function! s:files()
        let files = split(system($FZF_DEFAULT_COMMAND), '\n')
        let g:fzf_mode = 'Files'
        return s:prepend_icon(files)
      endfunction

      function! s:prepend_icon(candidates)
        let result = []
        for candidate in a:candidates
          let filename = fnamemodify(candidate, ':p:t')
          let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
          call add(result, printf("%s %s", icon, candidate))
        endfor

        return result
      endfunction

      function! s:edit_file(item)
        let parts = split(a:item, ' ')
        let file_path = get(parts, 1, '')
        execute 'silent e' file_path
      endfunction

      call fzf#run({
            \ 'source': <sid>files(),
            \ 'sink':   function('s:edit_file'),
            \ 'options': '-m -x +s',
            \ 'window':  'rightbelow 20new' })
    endfunction
  " }}}


  "Files in current directory {{{
    function! FilesInCwd()
      let current_file =expand("%")
      let cwd = fnamemodify(current_file, ':p:h')
      let command = 'ag -g "" -f ' . cwd . ' --depth 0'

      call fzf#run({
            \ 'source': command,
            \ 'sink':   'e',
            \ 'options': '-m -x +s',
            \ 'window':  'enew' })
    endfunction
  " }}}

  " Keybindings {{{
    " nnoremap <silent> <leader>ff :<C-u>call Fzf_dev()<CR>
    nnoremap <silent> <leader>pf :<C-u>Files<CR>
    nnoremap <silent> <leader>fc :<C-u>call FilesInCwd()<CR>
    nnoremap <silent> <leader>bb :<C-u>Buffers<CR>
    nnoremap <silent> <leader>W :<C-u>Windows<CR>
    nnoremap <silent> <leader>; :<C-u>BLines<CR>
    nnoremap <silent> <leader>. :<C-u>Lines<CR>
    nnoremap <silent> <leader>o :<C-u>BTags<CR>
    nnoremap <silent> <leader>O :<C-u>Tags<CR>
    nnoremap <silent> <leader>: :<C-u>Commands<CR>
    nnoremap <silent> <leader>? :<C-u>History<CR>
    nnoremap <silent> <leader>p/ :<C-u>Ag<CR>
    nnoremap <silent> <leader>gl :<C-u>Commits<CR>
    nnoremap <silent> <leader>ga :<C-u>BCommits<CR>
    nnoremap <silent> <leader>gf :<C-u>GitFiles?<CR>

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
" Shougo/denite.nvim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'denite.nvim')
  " Change file_rec command.
  call denite#custom#var('file_rec', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

  " Use C-n and C-p to move between candidates
  call denite#custom#map('insert', '<C-n>', 'move_to_next_line')
  call denite#custom#map('insert', '<C-p>', 'move_to_prev_line')

  " Custom command
  call denite#custom#var('file_rec/git', 'command',
          \ ['git', 'ls-files', '-co', '--exclude-standard'])

  " Change default prompt
  call denite#custom#option('default', 'prompt', '>')

  " Change ignore_globs
  call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
        \ [ '.git/', 'images/', '*.min.*', 'img/', 'fonts/'])
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" kien/ctrlp.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'ctrlp.vim')
    Plug 'FelikZ/ctrlp-py-matcher' "faster matcher for ctrlp
    Plug 'sgur/ctrlp-extensions.vim' "provides yankring and CMDline history
    Plug 'iurifq/ctrlp-rails.vim' "provides rails.vim modes

    " Settings {{{
      let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
      let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'

      " let g:ctrlp_regexp = 1
      "
      let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'some_bad_symbolic_links',
        \ }

      let g:ctrlp_prompt_mappings = {
        \ 'PrtSelectMove("j")':   ['<c-n>'],
        \ 'PrtSelectMove("k")':   ['<c-p>'],
        \ 'PrtHistory(-1)':       ['<down>'],
        \ 'PrtHistory(1)':        ['<up>'],
        \}
    "}}}

    " Keybindings {{{
      nnoremap <leader>fm :<C-u>CtrlPMixed<CR>
      nnoremap <leader>ff :<C-u>CtrlP<CR>
      nnoremap <leader>b :<C-u>CtrlPBuffer<CR>
      nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

      nnoremap <leader>y :<C-u>CtrlPYankring<CR>
      nnoremap <leader>u :<C-u>CtrlPUndo<CR>
      nnoremap <leader>l :<C-u>CtrlPLine<CR>

      " CtrlP-Rails.vim bindings
      nnoremap <leader>rm :<C-u>CtrlPModels<CR>
      nnoremap <leader>rmi :<C-u>CtrlPMigrations<CR>
      nnoremap <leader>rc :<C-u>CtrlPControllers<CR>
      nnoremap <leader>rv :<C-u>CtrlPViews<CR>
      nnoremap <leader>rs :<C-u>CtrlPSpecs<CR>
      nnoremap <leader>rl :<C-u>CtrlPLibs<CR>
    "}}}
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" maksimr/vim-jsbeautify {{{
" ------------------------------------------------------------------------------
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
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" benekastah/neomake {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'neomake')
  autocmd! BufWritePost * Neomake

  let g:neomake_warning_sign = {
    \ 'text': '⚠',
    \ 'texthl': 'WarningMsg',
    \ }

  let g:neomake_error_sign = {
    \ 'text': '✖',
    \ 'texthl': 'ErrorMsg',
    \ }

  call neomake#signs#RedefineErrorSign()
  call neomake#signs#RedefineWarningSign()
  let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_jsx_enabled_makers = ['eslint']
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" tpope/vim-fugitive {{{
" ------------------------------------------------------------------------------
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

  " Automatically remove fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" mattn/emmet-vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'emmet-vim')
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
" TODO:Shougo/deoplete.nvim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1

  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" morhetz/gruvbox {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'gruvbox')
  func! ActivateColorScheme()
    let g:gruvbox_italic=1
    let g:gruvbox_italicize_strings=1
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox
    set background=dark

    " Color overides
    let g:indentLine_color_term = 239
    hi! Statusline ctermfg=002 ctermbg=000

    " Transparant background
    " hi! Normal ctermbg=NONE guibg=NONE
    " hi! NonText ctermbg=NONE guibg=NONE
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" zefei/cake16 {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'cake16')
  func! ActivateColorScheme()
    colorscheme cake16
    set background=light
    " let g:indentLine_color_term = 239
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" mhartington/oceanic-next {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'oceanic-next')
  colorscheme OceanicNext
  set background=dark
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" joshdick/onedark.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'onedark.vim')
  func! ActivateColorScheme()
    colorscheme onedark
    set background=dark
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" atelierbram/Base2Tone-vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'Base2Tone-vim---')
  func! ActivateColorScheme()
    " Base2Tone Dark
    set background=dark
    colorscheme Base2Tone-Evening-dark
    " or any of the other schemes:
    " colorscheme Base2Tone-Morning-dark
    " colorscheme Base2Tone-Sea-dark
    " colorscheme Base2Tone-Space-dark
    " colorscheme Base2Tone-Earth-dark
    " colorscheme Base2Tone-Forest-dark
    " colorscheme Base2Tone-Desert-dark
    " colorscheme Base2Tone-Lake-dark
    " colorscheme Base2Tone-Meadow-dark
    " colorscheme Base2Tone-Drawbridge-dark
    " colorscheme Base2Tone-Pool-dark
    " colorscheme Base2Tone-Heath-dark
    " colorscheme Base2Tone-Cave-dark

    " Base2Tone Light
    "
    " set background=light
    " colorscheme Base2Tone-Evening-light
    " colorscheme Base2Tone-Morning-light
    " colorscheme Base2Tone-Sea-light
    " colorscheme Base2Tone-Space-light
    " colorscheme Base2Tone-Earth-light
    " colorscheme Base2Tone-Forest-light
    " colorscheme Base2Tone-Desert-light
    " colorscheme Base2Tone-Lake-light
    " colorscheme Base2Tone-Meadow-light
    " colorscheme Base2Tone-Drawbridge-light
    " colorscheme Base2Tone-Pool-light
    " colorscheme Base2Tone-Heath-light
    " colorscheme Base2Tone-Cave-light

    hi! StatusLine ctermbg=001 ctermfg=015
    hi User1 ctermfg=10
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" morhetz/flattened {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'flattened')
  func! ActivateColorScheme()
    colorscheme flattened_dark
    set background=dark
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" icymind/NeoSolarized {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'NeoSolarized')
  func! ActivateColorScheme()
    colorscheme NeoSolarized
    let g:neosolarized_contrast = "high"
    let g:neosolarized_visibility = "high"
    let g:neosolarized_diffmode = "high"
    set background=dark

    " Transparant background
    hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" onehalf {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'onehalf')
  func! ActivateColorScheme()
    " colorscheme onehalflight
    colorscheme onehalfdark
    set background=dark
    silent exec ':AirlineTheme onehalfdark'
    hi! link Search PMenu
    hi! link IncSearch PMenuSel
    hi! link Folded Visual
    " hi! IndentGuidesOdd  guibg=#3F3F3F ctermbg=236
    " hi! IndentGuidesEven guibg=#383838 ctermbg=235
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" NLKNguyen/papercolor-theme {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'papercolor-theme')
  func! ActivateColorScheme()
    colorscheme PaperColor
    set background=light
    silent exec ':AirlineTheme papercolor'
    hi! link Search PMenu
    hi! link IncSearch PMenuSel
    " hi! IndentGuidesOdd  guibg=#3F3F3F ctermbg=236
    " hi! IndentGuidesEven guibg=#383838 ctermbg=235
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" nathanaelkane/vim-indent-guides {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-indent-guides')
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
if has_key(g:plugs, 'vim-hardtime')
  let g:hardtime_default_on = 1
  let g:hardtime_showmsg = 0 " Show message
  " let g:list_of_insert_keys = ["<Bs>"]
  let g:list_of_disabled_keys = ["<up>", "<down>", "<left>", "<right>"]
  let g:hardtime_allow_different_key = 1 " This allows jh but not jj
  let g:hardtime_ignore_quickfix = 1 " Ignore hardtime when in quickfix buffer
  let g:hardtime_timeout = 500
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" skwp/greplace.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'greplace')
  set grepprg=ag

  let g:grep_cmd_opts = '--line-numbers --noheading'
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" eugen0329/vim-esearch {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-esearch')
  if !exists('g:esearch')
    let g:esearch = {}
    let g:esearch.adapter = 'ag'
    let g:esearch.backend = 'nvim'
    let g:esearch.out = 'win'
    let g:esearch.batch_size = 1000
    let g:esearch.use = ['visual', 'hlsearch', 'last']
  endif
  " let g:esearch#cmdline#dir_icon = ''
  " let g:esearch#cmdline#dir_icon = 'D'
  " let g:esearch#cmdline#dir_icon = ''
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" pelodelfuego/vim-swoop {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-swoop')
  " nnoremap <silent> <Leader>/ :call Swoop()<CR>
  " vnoremap <silent> <Leader>/ :call SwoopSelection()<CR>

  " nnoremap <silent> <Leader>/ :call SwoopMulti()<CR>
  " vnoremap <silent> <Leader>/ :call SwoopMultiSelection()<CR>

  " let g:swoopWindowsVerticalLayout = 1
  " let g:swoopPatternSpaceInsertsWildcard = 0
endif
" }}}

" ------------------------------------------------------------------------------
" terryma/vim-expand-region {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-expand-region')
  vmap v <Plug>(expand_region_expand)
endif
" }}}

" ------------------------------------------------------------------------------
" t9md/vim-choosewin {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-choosewin')
  let g:choosewin_label = 'aoeuhtns'
  let g:choosewin_color_label = {
          \ 'cterm': [2, 16]
          \ }
  let g:choosewin_color_label_current = {
        \ 'cterm': [9, 16]
        \ }

  nmap <leader>wc :<c-u>:ChooseWin<CR>
endif
" }}}

" ------------------------------------------------------------------------------
" w0rp/ale {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'ale')
  let g:ale_sign_error = '✖'
  let g:ale_sign_warning = '⚠'
  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'ruby': ['rubocop']
  \}

  " don't run linters when opening a file
  let g:ale_lint_on_enter = 0
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-airline/vim-airline {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-airline')
  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif

  let g:airline_powerline_fonts = 0
  let g:airline_enable_branch     = 1
  let g:airline_detect_modified=1
  let g:airline_detect_paste=1
  let g:airline_detect_spell=1
  let g:airline_detect_crypt=1
  let g:airline_inactive_collapse=1
  let g:airline_skip_empty_sections = 1
  let g:airline_exclude_preview = 1

  "Vim-powerline symbols
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = ''
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_left_sep          = ''
  let g:airline_left_alt_sep      = ''
  let g:airline_right_sep         = ''
  let g:airline_right_alt_sep     = ''
  let g:airline_symbols.maxlinenr = '☰'
  let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
  let g:airline_section_y = airline#section#create(["%{ObsessionStatus('', '')}"])


  " extensions {
    let g:airline#extensions#branch#format = 2
    let g:airline#extensions#bufferline#enabled = 0
    let g:airline#extensions#syntastic#enabled = 0
    let g:airline#extensions#tagbar#enabled = 0
    let g:airline#extensions#tabline#enabled = 0
    let g:airline#extensions#eclim#enabled = 0
    let g:airline#extensions#wordcount#enabled = 0
    let g:airline#extensions#whitespace#enabled = 1
    let g:airline#extensions#tmuxline#enabled = 0
    let g:airline#extensions#ycm#enabled = 0
  " }
  " Airline Whitespace {
    let g:airline#extensions#whitespace#symbol = '..'
    let g:airline#extensions#whitenpace#checks = [ 'indent', 'trailing' ]
    let g:airline#extensions#whitespace#show_message = 0
  " }

  " Modeline mapping {
    let g:airline_mode_map = {
        \ '__' : '-',
        \ 'n'  : 'N',
        \ 'i'  : 'I',
        \ 'R'  : 'R',
        \ 'c'  : 'C',
        \ 'v'  : 'V',
        \ 'V'  : 'V',
        \ '' : 'V',
        \ 's'  : 'S',
        \ 'S'  : 'S',
        \ '' : 'S',
        \ }
  " }
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" christoomey/vim-tmux-navigator {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-tmux-navigator')
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <leader>wh :TmuxNavigateLeft<cr>:AirlineRefresh<cr>
  nnoremap <silent> <leader>wj :TmuxNavigateDown<cr>:AirlineRefresh<cr>
  nnoremap <silent> <leader>wk :TmuxNavigateUp<cr>:AirlineRefresh<cr>
  nnoremap <silent> <leader>wl :TmuxNavigateRight<cr>:AirlineRefresh<cr>
  nnoremap <silent> <leader>wp :TmuxNavigatePrevious<cr>:AirlineRefresh<cr>

  nnoremap <silent> <leader>wv :vs<cr>:AirlineRefresh<cr>
  nnoremap <silent> <leader>ws :split<cr>:AirlineRefresh<cr>

  tnoremap <silent> <leader>wh <C-\><C-n>:TmuxNavigateLeft<cr><C-\><C-n>:AirlineRefresh<cr>
  tnoremap <silent> <leader>wj <C-\><C-n>:TmuxNavigateDown<cr><C-\><C-n>:AirlineRefresh<cr>
  tnoremap <silent> <leader>wk <C-\><C-n>:TmuxNavigateUp<cr><C-\><C-n>:AirlineRefresh<cr>
  tnoremap <silent> <leader>wl <C-\><C-n>:TmuxNavigateRight<cr><C-\><C-n>:AirlineRefresh<cr>
  tnoremap <silent> <leader>wp <C-\><C-n>:TmuxNavigatePrevious<cr><C-\><C-n>:AirlineRefresh<cr>
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" godlygeek/tabular {{{
" ------------------------------------------------------------------------------
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
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-ctrlspace/vim-ctrlspace {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-ctrlspace')
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
   \"SLeft": "",
   \"SRight": " SEARCH ",
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
  let g:CtrlSpaceSetDefaultMapping = 0
  nmap <leader><leader> <c-u>:CtrlSpace<cr>
endif
" }}}
" ------------------------------------------------------------------------------
