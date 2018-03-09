highlight clear
if exists('syntax_on')
  syntax reset
endif

set background=light
let g:colors_name = 'snappy'

" Functions: {{{
  function! s:HL(group, ...)
    let l:histring = 'hi ' . a:group . ' '

    if strlen(a:1)
      let l:histring .= 'guifg=' . a:1 . ' '
    endif

    if strlen(a:2)
      let l:histring .= 'guibg=' . a:2 . ' '
    endif

    if a:0 >= 3 && strlen(a:3)
      let l:histring .= 'gui=' . a:3 . ' '
    endif

    execute l:histring
  endfunction
" }}}

" SETUP VARS: {{{
  if !exists('g:snappy_bold')
    let g:snappy_bold=1
  endif
  if !exists('g:snappy_italic')
    if has('nvim') || has('gui_running') || $TERM_ITALICS ==# 'true'
      let g:snappy_italic=1
    else
      let g:snappy_italic=0
    endif
  endif
  if !exists('g:snappy_undercurl')
    let g:snappy_undercurl=1
  endif
  if !exists('g:snappy_underline')
    let g:snappy_underline=1
  endif
  if !exists('g:snappy_inverse')
    let g:snappy_inverse=1
  endif

  let s:bold = 'bold,'
  if g:snappy_bold == 0
    let s:bold = ''
  endif

  let s:italic = 'italic,'
  if g:snappy_italic == 0
    let s:italic = ''
  endif

  let s:underline = 'underline,'
  if g:snappy_underline == 0
    let s:underline = ''
  endif

  let s:undercurl = 'undercurl,'
  if g:snappy_undercurl == 0
    let s:undercurl = ''
  endif

  let s:inverse = 'inverse,'
  if g:snappy_inverse == 0
    let s:inverse = ''
  endif

  let s:invert_selection = s:inverse
  if exists('g:snappy_invert_selection')
    if g:snappy_invert_selection == 0
      let s:invert_selection = ''
    endif
  endif

  let s:none = 'NONE'
" }}}

" COLORS: {{{
  let s:black = '#000000'
  " let s:white = '#FFFFFF'
  let s:white = '#ECF0F1'
  let s:gray1 = '#707470'
  let s:gray2 = '#D0D4D0'
  let s:gray3 = '#E9EEE9'

  let s:blue = 'Blue'
  let s:red = 'Red'
  let s:green = 'Green'
  let s:purple = 'Purple'

  let s:troll = '#00B9E5'
" }}}

" Normal UI {{{
  " Normal text
  call s:HL('Normal', s:black, s:white)

  " Cursor line / column
  call s:HL('CursorLine', s:none , s:gray2)
  hi! link CursorColumn CursorLine

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:white, s:black, s:bold)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:gray1, s:bold)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:white, s:black)

  " Non text and special keys
  hi! link NonText GruvboxBg2
  hi! link SpecialKey GruvboxBg2

  call s:HL('Visual', s:none,  s:white, s:invert_selection)
  hi! link VisualNOS Visual

  call s:HL('Search', s:black, s:white, s:inverse)
  call s:HL('IncSearch', s:black, s:white, s:inverse)

  call s:HL('Underlined', s:black, s:none, s:underline)

  call s:HL('Red', s:red, s:none)
  call s:HL('Green', s:green, s:none)
  call s:HL('Blue', s:blue, s:none)
  call s:HL('Purple', s:purple, s:none)

  call s:HL('Italic', s:black, s:none, s:italic)
  call s:HL('ItalicGray1', s:gray1, s:none, s:italic)
  call s:HL('ItalicGray2', s:gray2, s:none, s:italic)
  call s:HL('ItalicGray3', s:gray3, s:none, s:italic)
  call s:HL('ItalicRed', s:red, s:none, s:italic)
  call s:HL('ItalicGreen', s:green, s:none, s:italic)
  call s:HL('ItalicBlue', s:blue, s:none, s:italic)
  call s:HL('ItalicPurple', s:purple, s:none, s:italic)

  call s:HL('Bold', s:black, s:none, s:bold)
  call s:HL('BoldRed', s:red, s:none, s:bold)
  call s:HL('BoldGreen', s:green, s:none, s:bold)
  call s:HL('BoldBlue', s:blue, s:none, s:bold)
  call s:HL('BoldPurple', s:purple, s:none, s:bold)

  call s:HL('StatusLine', s:black, s:white, s:inverse)
  call s:HL('StatusLineNC', s:black, s:white, s:inverse)

  " The column separating vertically split windows
  call s:HL('VertSplit', s:black, s:none)

  " Current match in wildmenu completion
  call s:HL('WildMenu', s:purple, s:white, s:bold . s:inverse)

  " FIXME
  " " Directory names, special names in listing
  " hi! link Directory GruvboxGreenBold

  " " Titles for output from :set all, :autocmd, etc.
  " hi! link Title GruvboxGreenBold

  " " Error messages on the command line
  call s:HL('ErrorMsg', s:red, s:white, s:bold)
  " " More prompt: -- More --
  call s:HL('MoreMsg', s:blue, s:white, s:bold)
  " " Current mode message: -- INSERT --
  call s:HL('ModeMsg', s:blue, s:white, s:bold)
  " " 'Press enter' prompt and yes/no questions
  call s:HL('Question', s:green, s:white, s:bold)
  " " Warning messages
  call s:HL('WarningMsg', s:red, s:white, s:bold)
" }}}

" Gutter: {{{
  " Line number for :number and :# commands
  call s:HL('LineNr', s:black, s:white)

  " Column where signs are displayed
  call s:HL('SignColumn', s:purple, s:none)
  call s:HL('ColorColumn', s:none, s:gray3)

  " Line used for closed folds
  call s:HL('Folded', s:white, s:purple, s:italic)
  " Column where folds are displayed
  call s:HL('FoldColumn', s:white, s:gray1)
" }}}

" Cursor: {{{

" Character under cursor
  call s:HL('Cursor', s:none, s:none, s:inverse)
  " Visual mode cursor, selection
  hi! link vCursor Cursor
  " Input moder cursor
  hi! link iCursor Cursor
  " Language mapping cursor
  hi! link lCursor Cursor
" }}}

" Syntax Highlighting: {{{
  call s:HL('Special', s:black, s:white, s:italic)
  call s:HL('Comment', s:gray1, s:none, s:italic)
  call s:HL('Todo', s:purple, s:white, s:bold . s:italic)
  call s:HL('Error', s:red, s:white, s:bold . s:inverse)

  " Generic statement
  call s:HL('Statement', s:black, s:white, s:bold)

  " if, then, else, endif, swicth, etc.
  call s:HL('Conditional', s:black, s:white, s:bold)

  " for, do, while, etc.
  call s:HL('Repeat', s:black, s:white, s:bold)

  " case, default, etc.
  call s:HL('Label', s:black, s:white, s:bold)

  " try, catch, throw
  call s:HL('Exception', s:blue, s:white, s:bold)

  " sizeof, "+", "*", etc.
  call s:HL('Operator', s:black, s:white)

  " Any other keyword
  call s:HL('Keyword', s:black, s:white, s:bold)

  " Variable name
  call s:HL('Identifier', s:black, s:white, s:underline)

  " Function name
  call s:HL('Function', s:black, s:white, s:italic)

  " Generic preprocessor
  call s:HL('PreProc', s:black, s:white, s:bold)

  " Preprocessor #include
  call s:HL('Include', s:black, s:white, s:italic)

  " Preprocessor #define
  call s:HL('Define', s:black, s:white, s:bold)

  " Same as Define
  call s:HL('Macro', s:black, s:white, s:bold)

  " Preprocessor #if, #else, #endif, etc.
  call s:HL('PreCondit', s:gray1, s:white, s:italic)

  " Generic constant
  call s:HL('Constant', s:black, s:white, s:bold)

  " Character constant: 'c', '/n'
  call s:HL('Character', s:red, s:white, s:italic)

  " String constant: "this is a string"
  call s:HL('String', s:green, s:white, s:italic)

  " Boolean constant: TRUE, FALSE
  call s:HL('Boolean', s:purple, s:white, s:bold)

  " Number constant: 234, 0xff
  call s:HL('Number', s:purple, s:white, s:italic)

  " Floating point constant: 2.3e10
  call s:HL('Float', s:purple, s:white, s:italic)

  " Generic type
  call s:HL('Type', s:black, s:white, s:bold)

  " static, register, volatile, etc
  call s:HL('StorageClass', s:black, s:white, s:bold)

  " struct, union, enum, etc.
  call s:HL('Structure', s:black, s:white, s:bold)

  " typedef
  call s:HL('Typedef', s:black, s:white, s:italic)
" }}}

" Completion Menu: {{{
  " Popup menu: normal item
  call s:HL('Pmenu', s:white, s:purple)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:white, s:black, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:black)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:white)
" }}}

" Diffs: {{{
  call s:HL('DiffDelete', s:red, s:white, s:inverse)
  call s:HL('DiffAdd',    s:green, s:white, s:inverse)

  " Alternative setting
  call s:HL('DiffChange', s:blue, s:white, s:inverse)
  call s:HL('DiffText',   s:purple, s:white, s:inverse)
" }}}

" Spelling: {{{
  if has("spell")
    call s:HL('SpellCap', s:none, s:none, s:undercurl, s:red)
    " Not recognized word
    call s:HL('SpellBad', s:none, s:none, s:undercurl, s:blue)
    " Wrong spelling for selected region
    call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:green)
    " Rare word
    call s:HL('SpellRare', s:none, s:none, s:undercurl, s:purple)
  end
" }}}

" Diff: {{{
  call s:HL('diffAdded', s:green, s:white)
  call s:HL('diffRemoved', s:red, s:white)
  call s:HL('diffChanged', s:blue, s:white)

  call s:HL('diffFile', s:black, s:white)
  call s:HL('diffNewFile', s:black, s:white, s:bold)

  call s:HL('diffLine', s:purple, s:white)
" }}}

" Sneak: {{{
  augroup snappy
    autocmd ColorScheme snappy hi! link Sneak Search
    autocmd ColorScheme snappy hi! link SneakLabel Search
  augroup END
" }}}

" Signify: {{{
  call s:HL('SignifySignAdd', s:gray1, s:white)
  call s:HL('SignifySignChange', s:gray1, s:white)
  call s:HL('SignifySignDelete', s:gray1, s:white)
" }}}

" Asynchronous Lint Engine: {{{
  " FIXME: See if we need this
  " hi! link ALEErrorSign SnappyRedSign
  " hi! link ALEWarningSign SnappyYellowSign
  " hi! link ALEInfoSign SnappyBlueSign
" }}}

" Dirvish: {{{
  call s:HL('DirvishPathTail', s:black, s:white, s:bold)
  call s:HL('DirvishArg', s:blue, s:white, s:italic)
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
