" Get a vimdiff of structure.sql compared to develop
lnoremap <leader>db :!git diff develop -- db/structure.sql -d vimdiff -a<cr>

" NOTE: make rspec default make program
setlocal makeprg=bundle\ exec\ rspec\ --require\ ~\/.config\/nvim\/make_programs\/vim_formatter.rb\ -f\ VimFormatter

" FIXME: Somehow relativenumber is disabled when entering ruby buffers
setlocal number relativenumber

" NOTE: poor man's snippets
inoreabbr <buffer> iit it { is_expected.to be(true) }
inoreabbr <buffer> iif it { is_expected.to be(false) }
inoreabbr <buffer> pry binding.pry
inoreabbr <buffer> bp binding.pry
inoreabbr <buffer> bb byebug

" tpope/vim-rails
nnoremap <leader>rC :.Runner<CR>
nnoremap <leader>rA :Runner<CR>

lua << EOF
require'nvim_lsp'.solargraph.setup({
  cmd = { "solargraph", "stdio" },
  formatting =  true,
  completion = true,
  definitions = true,
  symbols = true,
  hover = true,
  references = true,
  useBundler = true,
  filetypes = { "ruby", "eruby" },
  on_attach = require'completion'.on_attach
})
EOF

setlocal omnifunc=v:lua.vim.lsp.omnifunc
