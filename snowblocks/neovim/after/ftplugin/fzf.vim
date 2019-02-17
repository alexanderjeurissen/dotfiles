setlocal statusline=%#fzf1#\ %{g:fzf_current_mode}

" NOTE: clear mode and ruler on enter, and reinstate on bufleave
set noshowmode noruler
autocmd BufLeave <buffer> set showmode ruler

" NOTE: this clears the command line window
echom ""
