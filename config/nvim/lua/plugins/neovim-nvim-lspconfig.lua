local vim = vim or {}
local lspconfig = require('lspconfig')
local protocol = require('vim.lsp.protocol')
local nnoremap = require("util").nnoremap

local capabilities = protocol.make_client_capabilities()

-- Diagnostics {{{
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = true,
    signs = true,
  }
)

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",  -- Or "if_many"
    severity = vim.diagnostic.severity.ERROR,
    prefix = '⏽', -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = "if_many",  -- Or "if_many"
  },
})

vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
vim.cmd [[autocmd CursorHoldI * silent! lua vim.diagnostic.open_float()]]
-- }}}


-- Signs {{{
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- local signs = { Error = "⏽ ", Warn = "⏽", Hint = "⏽", Info = "⏽" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }}}

lspconfig.solargraph.setup {
  capabilities = capabilities,
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
      completion = true,
      definitions = true,
      symbols = true,
      hover = true,
      references = true
    }
  }
}

lspconfig.rubocop.setup{}

lspconfig.cssls.setup{
  capabilities = capabilities,
}

--[[ lspconfig.denols.setup{
  capabilities = capabilities,
} ]]

lspconfig.tsserver.setup{ capabilities = capabilities }

lspconfig.lua_ls.setup{
  capabilities = capabilities,
}

--[[ lspconfig.vim_ls.setup{
  capabilities = capabilities,
} ]]

lspconfig.gopls.setup{
  capabilities = capabilities,
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
	unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
nnoremap('gh ', '<cmd>lua vim.lsp.buf.hover()<CR>')
nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')

nnoremap('<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')

nnoremap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
nnoremap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

-- vim: foldmethod=marker:sw=2:foldlevel=10
