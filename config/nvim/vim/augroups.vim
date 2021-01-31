scriptencoding utf-8

" AUTOCMD: Autocmd groups  {{{
  augroup ALEXANDER_GENERAL " {{{
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    " In addition open folds till the cursor is visible
    autocmd BufReadPost *
          \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
          \   execute "normal g`\"" |
          \   execute "normal zv" |
          \ endif

    " Disable linting and syntax highlighting for large files
    autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   let g:ale_enabled=0 |
                \   let g:coc_enabled=0 |
                \   endif

    " http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
    autocmd Syntax * if 2000 < line('$') | syntax sync maxlines=200 | endif

    " Automatically remove fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile Appraisals setlocal filetype=ruby

    " Add html highlighting when editing rails views
    autocmd BufRead,BufNewFile *.html setlocal filetype=html.javascript
    autocmd BufRead,BufNewFile *.erb setlocal filetype=eruby.html

    " Add sh highlighthing when editing fish files
    autocmd BufRead,BufNewfile *.fish setlocal filetype=sh

    " Automatically remove trailing whitespaces unless file is blacklisted
    autocmd BufWritePre *.* :call general#Preserve("%s/\\s\\+$//e")

    " Update filetype on save if empty
    autocmd BufWritePost * nested
      \ if &l:filetype ==# '' || exists('b:ftdetect')
      \ |   unlet! b:ftdetect
      \ |   filetype detect
      \ | endif

    " NOTE: Ensure directory structure exists when opening a new file
    autocmd  BufNewFile  *  :lua require('general').EnsureDirExists()

    " let terminal resize scale the internal windows
    autocmd VimResized * :wincmd =
  augroup END " }}}

  " NOTE: reload init.vim when saving it to disk
  augroup ALEXANDER_VIMRC_RELOAD " {{{
    autocmd!
    autocmd BufWritePost init.vim source %
    autocmd BufWritePost init.lua luafile %
  augroup END " }}}

  " NOTE: open quickfix window after vim grep
  " ref: https://www.reddit.com/r/vim/comments/bmh977/automatically_open_quickfix_window_after/
  augroup quickfix
      autocmd!
      autocmd QuickFixCmdPost [^l]* cwindow
      autocmd QuickFixCmdPost l* lwindow
  augroup END
" }}}

" vim: foldmethod=marker:sw=2:foldlevel=10
