local lspconfig = require('lspconfig')
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local nnoremap = require("util").nnoremap

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
-- local signs = { Error = "⏽", Warn = "⏽", Hint = "⏽", Info = "⏽" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }}}

--[[ lspconfig.solargraph.setup {
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
} ]]

lspconfig.ruby_lsp.setup {
  capabilities = capabilities,  -- This is for enabling features like completion, etc.
  init_options = {
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      completion = true,
      definition = true,
      diagnostics = true,
      documentHighlights = true,
      documentLink = true,
      documentSymbols = true,
      foldingRanges = true,
      formatting = true,
      hover = true,
      inlayHint = true,
      onTypeFormatting = true,
      selectionRanges = true,
      semanticHighlighting = true,
      signatureHelp = true,
      typeHierarchy = true,
      workspaceSymbol = true
    },
 --[[ "featuresConfiguration": {
      "inlayHint": {
        "implicitHashValue": true,
        "implicitRescue": true
      }
    }, ]]
    formatter = 'auto',
    linters = { 'standard', 'rubocop' },
  },
}

lspconfig.cssls.setup{
  capabilities = capabilities,
}

lspconfig.ts_ls.setup{ capabilities = capabilities }

lspconfig.lua_ls.setup{
  capabilities = capabilities,
}

lspconfig.jsonls.setup{
  capabilities = capabilities,
}

lspconfig.gopls.setup{
  capabilities = capabilities,
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
	unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true
    },
  },
}

nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
nnoremap('gh ', '<cmd>lua vim.lsp.buf.hover()<CR>')
nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')

nnoremap('<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>')

nnoremap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
nnoremap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

-- vim: foldmethod=marker:sw=2:foldlevel=10
