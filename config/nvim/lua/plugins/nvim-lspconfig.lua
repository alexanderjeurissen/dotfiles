return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.diagnostic.config({
        virtual_text = {
          source = "if_many",
          severity = vim.diagnostic.severity.ERROR,
          prefix = '⏽',
        },
        underline = true,
        signs = true,
        severity_sort = true,
        float = { source = "if_many" },
      })
      vim.api.nvim_create_autocmd('CursorHold', { callback = vim.diagnostic.open_float })
      vim.api.nvim_create_autocmd('CursorHoldI', { callback = vim.diagnostic.open_float })

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      lspconfig.ruby_lsp.setup { capabilities = capabilities }
      lspconfig.cssls.setup{ capabilities = capabilities }
      lspconfig.ts_ls.setup{ capabilities = capabilities }
      lspconfig.lua_ls.setup{ capabilities = capabilities }
      lspconfig.jsonls.setup{ capabilities = capabilities }
      lspconfig.gopls.setup{
        capabilities = capabilities,
        cmd = {"gopls", "serve"},
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
      }

      local map = vim.keymap.set
      map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
      map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
      map('n', 'gh ', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
      map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
      map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })
      map('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>', { silent = true })
      map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })
      map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })
    end,
  },
}
