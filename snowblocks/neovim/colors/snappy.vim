scriptencoding utf-8
highlight clear
if exists('syntax_on')
  syntax reset
endif

set background=light
let g:colors_name = 'snappy'

augroup SnappyReload
autocmd!
    autocmd BufWritePost snappy.vim colo snappy
    autocmd BufWritePost snappy.vim let g:snappy_dev=1
    autocmd BufWritePost snappy.vim set ft=vim
augroup END

" Functions: {{{
  function! s:HL(group, fg_name, ...)
    let l:pieces = [a:group]
    let l:histring = 'hi ' . a:group . ' '

    if a:fg_name !=# ''
      let l:pieces = s:AddGroundValues(l:pieces, 'guifg', a:fg_name)
    endif

    if a:0 > 0 && a:1 !=# ''
      let l:pieces = s:AddGroundValues(l:pieces, 'guibg', a:1)
    endif

    if a:0 > 1 && a:2 !=# ''
      let l:pieces = s:AddGroundValues(l:pieces, 'gui', a:2)
    endif

    call s:Clear(a:group)
    call s:Highlight(l:pieces)
  endfunction

  function! s:AddGroundValues(accumulator, ground, value)
    let l:new_list = a:accumulator
    " for [l:where, l:value] in items(a:color)
    call add(l:new_list, a:ground . '=' . a:value)
    " endfor

    return l:new_list
  endfunction

  " NOTE: clear given higlightgroup
  function! s:Clear(group)
    exec 'highlight clear ' . a:group
  endfunction

  " NOTE: execute the 'highlight' command with a List of arguments.
  function! s:Highlight(args)
    exec 'highlight ' . join(a:args, ' ')
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
  if !exists('g:snappy_dev')
    let g:snappy_dev=0
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
  let s:black = '#000000'       " #000000
  let s:gray1 = '#080808'       " #080808
  let s:gray2 = '#111111'       " #111111
  let s:gray3 = '#1a1a1a'       " #1a1a1a
  let s:gray4 = '#232323'       " #232323
  let s:gray5 = '#2b2b2b'       " #2b2b2b
  let s:gray6 = '#343434'       " #343434
  let s:gray7 = '#3d3d3d'       " #3d3d3d
  let s:gray8 = '#464646'       " #464646
  let s:gray9 = '#4f4f4f'       " #4f4f4f
  let s:gray10 = '#575757'      " #575757
  let s:gray11 = '#606060'      " #606060
  let s:gray12 = '#696969'      " #696969
  let s:gray13 = '#727272'      " #727272
  let s:gray14 = '#7b7b7b'      " #7b7b7b
  let s:gray15 = '#838383'      " #838383
  let s:gray16 = '#8c8c8c'      " #8c8c8c
  let s:gray17 = '#959595'      " #959595
  let s:gray18 = '#9e9e9e'      " #9e9e9e
  let s:gray19 = '#a7a7a7'      " #a7a7a7
  let s:gray20 = '#afafaf'      " #afafaf
  let s:gray21 = '#b8b8b8'      " #b8b8b8
  let s:gray22 = '#c1c1c1'      " #c1c1c1
  let s:gray23 = '#cacaca'      " #cacaca
  let s:gray24 = '#d3d3d3'      " #d3d3d3
  let s:gray25 = '#dbdbdb'      " #dbdbdb
  let s:gray26 = '#e4e4e4'      " #e4e4e4
  let s:gray27 = '#ededed'      " #ededed
  let s:gray28 = '#f6f6f6'      " #f6f6f6
  let s:white = '#ffffff'       " #ffffff

  " NOTE: offsuite grays for UI elements
  let s:uibg = '#ecf0f1'        " #ECF0F1
  let s:ui1 = '#dedcd6'         " #DEDCD6
  let s:ui2 = '#cac7bd'         " #cac7bd
  let s:ui3 = '#b7b2a5'         " #b7b2a5
  let s:ui4 = '#a39e8d'         " #a39e8d
  let s:ui5 = '#908975'         " #908975

  " NOTE: colors moddeled after the Win98 selected start menu item
  " by changing hues to match the desired color name.
  " These are used for highlighting important syntax
  let s:red = '#800013'         " #800013
  let s:green = '#00802c'       " #00802c
  let s:blue = '#170080'        " #170080
  let s:purple = '#410080'      " #410080
" }}}

" Normal UI {{{
  " Normal text
  call s:HL('Normal', s:black, s:uibg)
  " call s:HL('Normal', s:black, s:light_red_bg)

  " Cursor line / column
  call s:HL('CursorLine', s:none , s:ui1)

  hi! link CursorColumn CursorLine

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:blue, s:none, s:bold)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:gray1, s:bold)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:gray5, s:gray23, s:bold)

  " Non text is stuff like Tildes on the bottom of the page.
  call s:HL('NonText', s:gray1, s:none)

  " Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
  call s:HL('SpecialKey', s:none, s:gray1)

  call s:HL('Visual', s:none, s:none, s:invert_selection)
  hi! link VisualNOS Visual

  call s:HL('Search', s:ui2, s:black, s:inverse)
  call s:HL('IncSearch', s:ui2, s:black, s:inverse)
  call s:HL('CurrentSearchMatch', s:white, s:none, s:inverse . s:bold)

  call s:HL('Underlined', s:black, s:none, s:underline)

  call s:HL('StatusLine', s:ui1, s:gray5, s:inverse)
  " NOTE: equal StatusLine and StatusLineNC cause statusline spacing to bug out
  " SOURCE: https://tinyurl.com/yavjy26z
  call s:HL('StatusLineNC', s:ui1, s:gray15, s:inverse)

  " The column separating vertically split windows
  call s:HL('VertSplit', s:none, s:none)

  " Current match in wildmenu completion
  call s:HL('WildMenu', s:blue, s:white, s:bold . s:inverse)

  " FIXME
  " " Directory names, special names in listing
  call s:HL('Directory', s:black, s:none, s:bold)

  " " Titles for output from :set all, :autocmd, etc.
  " hi! link Title GruvboxGreenBold

  " " Error messages on the command line
  call s:HL('ErrorMsg', s:red, s:none, s:bold)
  " " More prompt: -- More --
  call s:HL('MoreMsg', s:blue, s:none, s:bold)
  " " Current mode message: -- INSERT --
  call s:HL('ModeMsg', s:blue, s:none, s:bold)
  " " 'Press enter' prompt and yes/no questions
  call s:HL('Question', s:green, s:none, s:bold)
  " " Warning messages
  call s:HL('WarningMsg', s:red, s:none, s:bold)
" }}}

" Gutter: {{{
  " Line number for :number and :# commands
  call s:HL('LineNr', s:gray15, s:gray26)

  " Column where signs are displayed
  call s:HL('SignColumn', s:blue, s:none)
  " FIXME: this colorcolumn highlight is a bit intrusive currently
  call s:HL('ColorColumn', s:none, s:ui2)

  " Line used for closed folds
  call s:HL('Folded', s:gray5, s:ui2, s:italic)
  " Column where folds are displayed
  call s:HL('FoldColumn', s:white, s:ui3)
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
  call s:HL('Special', s:black, s:none, s:italic)
  call s:HL('Comment', s:gray4, s:none, s:italic)
  " TODO and similar tags.
  call s:HL('Todo', s:purple, s:none, s:bold . s:italic)
  call s:HL('Error', s:red, s:none, s:bold . s:inverse)

  " Generic statement
  call s:HL('Statement', s:black, s:none, s:bold)

  " if, then, else, endif, swicth, etc.
  call s:HL('Conditional', s:black, s:none, s:bold)

  " for, do, while, etc.
  call s:HL('Repeat', s:black, s:none, s:bold)

  " case, default, etc.
  call s:HL('Label', s:black, s:none, s:bold)

  " try, catch, throw
  call s:HL('Exception', s:red, s:none, s:bold)

  " sizeof, "+", "*", etc.
  call s:HL('Operator', s:black, s:none)

  " Any other keyword
  call s:HL('Keyword', s:black, s:none, s:bold)

  " Variable name
  call s:HL('Identifier', s:black, s:none, s:italic)

  " Function name
  call s:HL('Function', s:black, s:none, s:italic)

  " Generic preprocessor
  " Stuff like 'require' in Ruby.
  call s:HL('PreProc', s:black, s:none, s:bold)

  " Preprocessor #include
  call s:HL('Include', s:black, s:none, s:italic)

  " Preprocessor #define
  call s:HL('Define', s:black, s:none, s:bold)

  " Same as Define
  call s:HL('Macro', s:black, s:none, s:bold)

  " Preprocessor #if, #else, #endif, etc.
  call s:HL('PreCondit', s:gray1, s:none, s:italic)

  " Generic constant
  call s:HL('Constant', s:black, s:none, s:bold)

  " Character constant: 'c', '/n'
  call s:HL('Character', s:red, s:none, s:italic)

  " String constant: "this is a string"
  call s:HL('String', s:green, s:none, s:italic)

  " Boolean constant: TRUE, FALSE
  call s:HL('Boolean', s:purple, s:none, s:bold)

  " Number constant: 234, 0xff
  call s:HL('Number', s:purple, s:none, s:italic)

  " Floating point constant: 2.3e10
  call s:HL('Float', s:purple, s:none, s:italic)

  " Generic type
  call s:HL('Type', s:black, s:none, s:bold)

  " static, register, volatile, etc
  call s:HL('StorageClass', s:black, s:none, s:bold)

  " struct, union, enum, etc.
  call s:HL('Structure', s:black, s:none, s:bold)

  " typedef
  call s:HL('Typedef', s:black, s:none, s:italic)
" }}}

" Completion Menu: {{{
  " Popup menu: normal item
  call s:HL('Pmenu', s:black, s:ui1)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:white, s:black, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:ui2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:black)
" }}}

" Diffs: {{{
  call s:HL('DiffDelete', s:red, s:none, s:inverse)
  call s:HL('DiffAdd',    s:green, s:none, s:inverse)

  " Alternative setting
  call s:HL('DiffChange', s:blue, s:none, s:inverse)
  call s:HL('DiffText',   s:purple, s:none, s:inverse)
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
  call s:HL('diffAdded', s:green, s:none)
  call s:HL('diffRemoved', s:red, s:none)
  call s:HL('diffChanged', s:blue, s:none)

  call s:HL('diffFile', s:black, s:none)
  call s:HL('diffNewFile', s:black, s:none, s:bold)

  call s:HL('diffLine', s:purple, s:none)
" }}}

" Sneak: {{{
  augroup snappy
    autocmd ColorScheme snappy hi! link Sneak Search
    autocmd ColorScheme snappy hi! link SneakLabel Search
  augroup END
" }}}

" Signify: {{{
  call s:HL('SignifySignAdd', s:green, s:none)
  call s:HL('SignifySignChange', s:blue, s:none)
  call s:HL('SignifySignDelete', s:red, s:none)
" }}}

" Asynchronous Lint Engine: {{{
  " FIXME: See if we need this
  " hi! link ALEErrorSign SnappyRedSign
  " hi! link ALEWarningSign SnappyYellowSign
  " hi! link ALEInfoSign SnappyBlueSign
  call s:HL('ALEErrorSign', s:red, s:white, s:inverse)
  call s:HL('ALEWarningSign', s:red, s:none, s:bold)
  call s:HL('ALEInfoSign', s:blue, s:none, s:bold)
" }}}

" Dirvish: {{{
  call s:HL('DirvishPathTail', s:black, s:none, s:bold)
  call s:HL('DirvishArg', s:blue, s:none, s:italic)
" }}}

" Ruby specific Highlighting: {{{
  call s:HL('rubyDefine', s:black, s:none, s:bold)
  call s:HL('rubyStringDelimiter', s:green, s:none)
" }}}

" FIXME Colorscheme DEBUG highlight rules {{{
  " NOTE: This is for debugging purposes.
  " it highlights the color var names above in their own color to easily see the highlight rule that
  " is applied
  if g:snappy_dev == 1
    syn match SnappyGrayOne contained 'gray1'
    syn match SnappyGrayTwo contained 'gray2'
    syn match SnappyGrayThree contained 'gray3'
    " syn match SnappyGrayFour /\vgray4/
    " syn match SnappyGrayFive "\vgray5"
    " syn match SnappyGraySix "\vgray6"
    " syn match SnappyGraySeven "\vgray7"
    " syn match SnappyGrayEight "\vgray8"

    call s:HL('SnappyGrayOne', s:gray1, s:none, s:inverse)
    call s:HL('SnappyGrayTwo', s:gray2, s:none, s:inverse)
    call s:HL('SnappyGrayThree', s:gray3, s:none, s:inverse)
    " call s:HL('SnappyGrayFour', s:gray4, s:none, s:inverse)
    " call s:HL('SnappyGrayFive', s:gray5, s:none, s:inverse)
    " call s:HL('SnappyGraySix', s:gray6, s:none, s:inverse)
    " call s:HL('SnappyGraySeven', s:gray7, s:none, s:inverse)
    " call s:HL('SnappyGrayEight', s:gray8, s:none, s:inverse)
  endif
" }}}
" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
