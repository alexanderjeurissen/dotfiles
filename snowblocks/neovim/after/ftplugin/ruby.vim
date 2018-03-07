" Get a vimdiff of structure.sql compared to develop
lnoremap <leader>db :!git diff develop -- db/structure.sql -d vimdiff -a<cr>

" NOTE: make rspec default make program
setlocal makeprg=bundle\ exec\ rspec\ --require\ ~\/.config\/nvim\/make_programs\/vim_formatter.rb\ -f\ VimFormatter

" FIXME: Somehow relativenumber is disabled when entering ruby buffers
setlocal number relativenumber
