nmap <leader>wc :q<cr>
nmap <leader>bd :Bdelete<CR>

" Delete all hidden buffers
nnoremap <leader>bo :DeleteHiddenBuffers<CR>

" Delete all buffers, but keep windows open
nnoremap <leader>bw :bufdo :Bdelete<CR>
