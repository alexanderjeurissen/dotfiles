local lspconfig = require('lspconfig')
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local map = vim.keymap.set

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Diagnostics {{{

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",  -- Or "if_many"
    severity = vim.diagnostic.severity.ERROR,
    prefix = '⏽', -- Could be '■', '▎', 'x'
  },
  underline = true,
  signs = true,
  severity_sort = true,
  float = {
    source = "if_many",  -- Or "if_many"
  },
})

vim.api.nvim_create_autocmd('CursorHold', {
  callback = vim.diagnostic.open_float,
})
vim.api.nvim_create_autocmd('CursorHoldI', {
  callback = vim.diagnostic.open_float,
})
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

map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
map('n', 'gh ', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })

map('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>', { silent = true })

map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })

-- vim: foldmethod=marker:sw=2:foldlevel=10
