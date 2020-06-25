" tpope/vim-rails
nnoremap <leader>rC :.Runner<CR>
nnoremap <leader>rA :Runner<CR>

call general#MarkMargin(1, 80)

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
