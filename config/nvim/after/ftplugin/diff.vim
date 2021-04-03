set foldenable
set foldlevel=0                                    " Autofold nothing by default
set foldnestmax=0                                  " Only fold outer functions

set nolist
set nocursorcolumn
set nocursorline
set conceallevel=0
set colorcolumn=0
call general#MarkMargin(0)

let g:solarized_diffmode="high"

normal zv

" NOTE: Ensures that :q and :x work with neovim-remote
" https://github.com/mhinz/neovim-remote#typical-use-cases
set bufhidden=delete

" Create some additional fold movements
nnoremap <buffer>zN :normal zC<CR>/^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>
nnoremap <buffer>zP :normal zC<CR>?^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>

nnoremap <buffer>zn :normal zc<CR>/^@@<CR>:nohl<CR>:normal zv<CR>:normal zt<CR>
nnoremap <buffer>zp :normal zc<CR>?^@@<CR>:nohl<CR>:normal zv<CR>:normal zb<CR>
