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
