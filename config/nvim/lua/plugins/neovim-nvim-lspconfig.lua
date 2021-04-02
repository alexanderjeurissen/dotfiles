local vim = vim or {}
local lspconfig = require('lspconfig')
local nnoremap = require("util").nnoremap

-- Diagnostics {{{
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)

vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]
-- }}}


-- Signs {{{
-- vim.cmd [[sign define LspDiagnosticsSignError text=]]
-- vim.cmd [[sign define LspDiagnosticsSignWarning text=]]
-- vim.cmd [[sign define LspDiagnosticsSignInformation text=]]
-- vim.cmd [[sign define LspDiagnosticsSignHint text=]]

vim.cmd [[sign define LspDiagnosticsSignError text=⏽]]
vim.cmd [[sign define LspDiagnosticsSignWarning text=⏽]]
vim.cmd [[sign define LspDiagnosticsSignInformation text=⏽]]
vim.cmd [[sign define LspDiagnosticsSignHint text=⏽]]
-- }}}


lspconfig.solargraph.setup {
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

lspconfig.cssls.setup{}

lspconfig.denols.setup{}

-- lspconfig.tsserver.setup {
  --[[ on_attach = function(client, bufnr)
    -- This makes sure tsserver is not used for formatting
    client.resolved_capabilities.document_formatting = false
  end, ]]
  -- settings = { documentFormatting = false }
-- }

nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
nnoremap('gh ', '<cmd>lua vim.lsp.buf.hover()<CR>')
nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')

nnoremap('<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')

nnoremap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
nnoremap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

-- vim: foldmethod=marker:sw=2:foldlevel=10
