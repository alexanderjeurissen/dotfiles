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
" Lokaltog/vim-easymotion {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-easymotion')
  map <Leader> <plug>(easymotion-prefix)
  nmap <leader><leader> <Plug>(easymotion-s)
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Shougo/vimfiler.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_tree_opened_icon = ' '
  let g:vimfiler_tree_closed_icon = ' '
  let g:vimfiler_marked_file_icon = ' ✓'
  let g:vimfiler_readonly_file_icon = ' '
  call vimfiler#custom#profile('default', 'context', { 'safe' : 0 })


  autocmd FileType vimfiler call <SID>VimfilerSetup()
  function! s:VimfilerSetup()
    nnoremap <buffer> <silent> <Esc> :bd<CR>
    nmap <buffer> <silent> f <Plug>(vimfiler_find)

    nnoremap <silent><buffer><expr> v
          \ vimfiler#do_switch_action('vsplit')
    nnoremap <silent><buffer><expr> s
          \ vimfiler#do_switch_action('split')
  endfunction
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" scrooloose/nerdtree {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'nerdtree')
  let g:NERDTreeDirArrowExpandable = ''
  let g:NERDTreeDirArrowCollapsible = ''
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
" aaronjensen/vim-command-w {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-command-w')
  nnoremap <silent><leader>wc :CommandW<CR>
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" zefei/vim-wintabs {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-wintabs')
  let g:wintabs_ui_sep_leftmost = ' '
  let g:wintabs_ui_sep_inbetween = '|'
  let g:wintabs_ui_sep_rightmost = ' '
  let g:wintabs_ui_active_left = ' '
  let g:wintabs_ui_active_right = ' '
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" junegunn/goyo.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'goyo.vim')
  nnoremap <leader>tw :Goyo<cr>
  let g:goyo_width = 110

  function! s:goyo_enter()
    " silent !tmux set status off
    " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
  endfunction

  function! s:goyo_leave()
    " silent !tmux set status on
    " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" tpope/vim-rails {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'vim-rails')
  nnoremap <leader>r <c-u>:Rrunner<CR>
  let g:rails_projections = {
    \"app/models/*.rb": {
    \  "alternate": ["spec/integration/models/%s_spec.rb"],
    \},
    \"app/controllers/*.rb": {
    \  "alternate": ["spec/integration/controllers/%s_spec.rb"],
    \},
    \"spec/integration/models/*_spec.rb": {
    \  "alternate": ["app/models/%s.rb"],
    \},
    \"spec/integration/controllers/*_spec.rb": {
    \  "alternate": ["app/controllers/%s.rb"],
    \},
    \"lib/support/app/controllers/support/*.rb": {
    \  "alternate": ["lib/support/spec/controllers/support/%s_spec.rb"]
    \},
    \"lib/support/spec/controllers/support/*_spec.rb": {
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

    " Keybindings {{{
      " 1. quickly switch current window with the main pane and toggle back
      nmap <silent> <leader>wm <Plug>GoldenViewSwitchMain
      nmap <silent> <leader>wt <Plug>GoldenViewSwitchToggle

      " 2. manipulate splits
      nmap <leader>wt <C-W>T

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
    let g:fzf_layout = { 'window': 'rightbelow 30new' }
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

      function! s:fzf_statusline()
        " Override statusline as you like
        highlight fzf1 ctermfg=13 ctermbg=10
        setlocal statusline=%#fzf1#

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
    function! s:ag_to_qf(line)
      let parts = split(a:line, ':')
      return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
            \ 'text': join(parts[3:], ':')}
    endfunction

    function! s:ag_handler(lines)
      if len(a:lines) < 2 | return | endif

      let cmd = get({'ctrl-s': 'split',
                   \ 'ctrl-v': 'vertical split',
                   \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
      let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

      let first = list[0]
      execute cmd escape(first.filename, ' %#\')
      execute first.lnum
      execute 'normal!' first.col.'|zz'

      if len(list) > 1
        call setqflist(list)
        copen
        wincmd p
      endif
    endfunction

    command! -nargs=* Agsearch call fzf#run({
    \ 'source':  printf('ag --nogroup --column --color "%s"',
    \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
    \ 'sink*':    function('<sid>ag_handler'),
    \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
    \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
    \            '--color hl:68,hl+:110',
    \ 'down':    '50%'
    \ })

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
  "

  " Jobs {{{
    function! s:jobs()
      if len(keys(g:jobs)) > 0
        return keys(g:jobs)
      else
        return []
      endif
    endfunction

    function! s:show_output(job)
      call g:jobs[''.a:job].get_output()
      wincmd j
      exec 'startinsert'
    endfunction

    command! -nargs=* Jobs call fzf#run({
    \ 'source':  <sid>jobs(),
    \ 'sink':    function('s:show_output'),
    \ 'options': '-m -x +s',
    \ 'down':    '50%'
    \ })
  "}}}

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

  " Keybindings {{{
    " nnoremap <silent> <leader>ff :<C-u>call Fzf_dev()<CR>
    nnoremap <silent> <leader>ff :<C-u>Files<CR>
    nnoremap <silent> <leader>bb :<C-u>Buffers<CR>
    nnoremap <silent> <leader>s :<C-u>Windows<CR>
    nnoremap <silent> <leader>; :<C-u>BLines<CR>
    nnoremap <silent> <leader>. :<C-u>Lines<CR>
    nnoremap <silent> <leader>o :<C-u>BTags<CR>
    nnoremap <silent> <leader>O :<C-u>Tags<CR>
    nnoremap <silent> <leader>: :<C-u>Commands<CR>
    nnoremap <silent> <leader>? :<C-u>History<CR>
    nnoremap <silent> <leader>/ :<C-u>Agsearch<CR>
    nnoremap <silent> <leader>gl :<C-u>Commits<CR>
    nnoremap <silent> <leader>ga :<C-u>BCommits<CR>
    nnoremap <silent> <leader>pf :<C-u>GitFiles?<CR>

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)

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

  let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
  let g:neomake_javascript_enabled_makers = ['eslint']
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
  let g:deoplete#omni#input_patterns = {}
  let g:deoplete#omni#input_patterns.ruby =
  \ ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
  let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'

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
" Shougo/unite.vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'unite.vim')
  let g:unite_data_directory='~/.nvim/.cache/unite'
  let g:unite_source_history_yank_enable=1
  let g:unite_prompt='❯ '
  let g:unite_source_menu_menus = {}

  " Using ag as recursive command.
  " let g:unite_source_rec_async_command =
  "       \ ['ag', '--follow', '--nocolor', '--nogroup',
  "       \  '--hidden', '-g', '']
  let g:unite_source_rec_async_command=
        \ ['ag', '--nocolor', '--nogroup',
        \  '--ignore', '.hg', '--ignore', '.svn', '--ignore', '.git', '--ignore', '.bzr',
        \  '--hidden', '-g', '']

  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore-dir .git --ignore *.log'
  let g:unite_source_grep_recursive_opt=''

  " bindings {{{
    nmap <leader>f [unite]
    nmap [unite] <nop>

    nnoremap <silent> [unite]e  :<C-u>VimFiler -no-split<CR>

    nnoremap <silent> [unite]m  :<C-u>Unite
          \ -start-insert -no-split file_rec/neovim:! buffer file_mru<CR>

    nnoremap <silent> [unite]r  :<C-u>Unite
          \ -no-split -buffer-name=recent file_mru<CR>

    nnoremap <silent> [unite]g  :<C-u>Unite
          \ file_rec/git:--cached:--others:--exclude-standard<CR>

    nnoremap <silenT> <leader>ur :<Plug>(unite_redraw)

    nnoremap <silent> <leader>y :<C-u>Unite
          \ -auto-resize -direction=botright
          \ -buffer-name=yanks history/yank<CR>

    nnoremap <silent> <leader>b :<C-u>Unite
          \ -no-split -buffer-name=buffers buffer<CR>

    nnoremap <silent> <Leader>h :<C-u>Unite
          \ -auto-resize -buffer-name=help help<CR>

    nnoremap <silent> <leader>/ :<C-u>Unite -no-quit -buffer-name=search grep:.<CR>

  " }}}

  " Git fugitive menu {{{
    let g:unite_source_menu_menus.git = {
      \ 'description' : '            Manage Git repositories
          \                            ⌘ [space]g',
      \}
    let g:unite_source_menu_menus.git.command_candidates = [
      \['▷ tig                                                        ⌘ ,gt',
          \'normal ,gt'],
      \['▷ git status       (Fugitive)                                ⌘ ,gs',
          \'Gstatus'],
      \['▷ git diff         (Fugitive)                                ⌘ ,gd',
          \'Gdiff'],
      \['▷ git commit       (Fugitive)                                ⌘ ,gc',
          \'Gcommit'],
      \['▷ git log          (Fugitive)                                ⌘ ,gl',
          \'exe "silent Glog | Unite quickfix"'],
      \['▷ git blame        (Fugitive)                                ⌘ ,gb',
          \'Gblame'],
      \['▷ git stage        (Fugitive)                                ⌘ ,gw',
          \'Gwrite'],
      \['▷ git checkout     (Fugitive)                                ⌘ ,go',
          \'Gread'],
      \['▷ git rm           (Fugitive)                                ⌘ ,gr',
          \'Gremove'],
      \['▷ git mv           (Fugitive)                                ⌘ ,gm',
          \'exe "Gmove " input("destination: ")'],
      \['▷ git push         (Fugitive, output buffer)                 ⌘ ,gp',
          \'Git! push'],
      \['▷ git pull         (Fugitive, output buffer)                 ⌘ ,gP',
          \'Git! pull'],
      \['▷ git prompt       (Fugitive, output buffer)                 ⌘ ,gi',
          \'exe "Git! " input("git command: ")'],
      \['▷ git cd           (Fugitive)',
          \'Gcd'],
      \]
    nnoremap <silent><leader>g :Unite -silent -start-insert menu:git<CR>
  " }}}

  " Custom mappings for the unite buffer
  autocmd FileType unite call s:unite_settings()

  function! s:unite_settings() "{{{
    " Enable navigation with control-n and control-p in insert mode
    imap <buffer> <C-n>       <Plug>(unite_select_next_line)
    imap <buffer> <C-p>       <Plug>(unite_select_previous_line)

    imap <buffer> <esc>       <Plug>(unite_exit)
    nmap <buffer> <esc>       <Plug>(unite_exit)

    nmap <buffer> <left>      <Plug>(unite_exit)
    nmap <buffer> <right>     <Plug>(unite_do_default_action)

    nmap <buffer><expr> <C-h> unite#do_action('split')
    imap <buffer><expr> <C-h> unite#do_action('split')

    nmap <buffer><expr> <C-v> unite#do_action('vsplit')
    imap <buffer><expr> <C-v> unite#do_action('vsplit')

    nmap <buffer><expr> <C-t> unite#do_action('tabopen')
    imap <buffer><expr> <C-t> unite#do_action('tabopen')

    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', '(\.meta$|\.tmp)')
  endfunction "}}}
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" morhetz/gruvbox {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'Gruvbox')
  let g:gruvbox_italic=1
  let g:gruvbox_italicize_strings=1
  let g:gruvbox_contrast_dark='soft'
  colorscheme gruvbox
  set background=dark
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" zefei/cake16 {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'cake16')
  colorscheme cake16
  set background=light
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
    " silent exec ":IndentLinesReset 2<CR>"
  endfunc
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Samuel-Phillips/nvim-colors-solarized {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'nvim-colors-solarized')
  colorscheme solarized
  set background=dark
  " should only be enabled if upgrading to master branch of this plugin
  " \   set termguicolors\n
endif
" }}}
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" atelierbram/Base2Tone-vim {{{
" ------------------------------------------------------------------------------
if has_key(g:plugs, 'Base2Tone-vim')
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
" takac/vim-hardtime {{{
if has_key(g:plugs, 'Base2Tone-vim')
  let g:hardtime_default_on = 1
  let g:hardtime_showmsg = 0 " Show message
  let g:list_of_insert_keys = ["<Bs>"]
  let g:list_of_disabled_keys = ["<up>", "<down>", "<left>", "<right>"]
  let g:hardtime_allow_different_key = 1 " This allows jh but not jj
  let g:hardtime_ignore_quickfix = 1 " Ignore hardtime when in quickfix buffer
endif
" }}}
" ------------------------------------------------------------------------------
