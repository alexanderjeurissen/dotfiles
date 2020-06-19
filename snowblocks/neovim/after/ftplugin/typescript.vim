" lua << EOF
" require'nvim_lsp'.tsserver.setup{
"   cmd = { "typescript-language-server", "--stdio" },
"   formatting = true,
"   completion = true,
"   symbols = true,
"   hover = false,
"   references = true,
"   on_attach = require'completion'.on_attach
" }
" EOF

inoreabbr <buffer> formgroup <FormGroup><CR><Label htmlFor><CR><CR></Label><CR><HelperText><CR><CR></HelperText><CR></FormGroup>

" setlocal omnifunc=v:lua.vim.lsp.omnifunc


let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
