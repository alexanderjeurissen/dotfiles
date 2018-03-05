" Get a vimdiff of structure.sql compared to develop
lnoremap <leader>db :!git diff develop -- db/structure.sql -d vimdiff -a<cr>
