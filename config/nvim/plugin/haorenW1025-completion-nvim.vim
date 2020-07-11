" set shortmess+=c   " Shut off completion messages

" Auto close popup menu when finish completion
augroup COMPLETION_NVIM
  autocmd!
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_trigger_character = ['.', '::']

" map <c-n> to manually trigger completion
inoremap <silent><expr> <c-p> completion#trigger_completion()
