return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
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

      vim.lsp.config('pyright', {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      vim.lsp.enable('pyright')

      vim.lsp.config('ruby_lsp', { capabilities = capabilities })
      vim.lsp.enable('ruby_lsp')

      vim.lsp.config('cssls', { capabilities = capabilities })
      vim.lsp.enable('cssls')

      vim.lsp.config('ts_ls', { capabilities = capabilities })
      vim.lsp.enable('ts_ls')

      vim.lsp.config('lua_ls', { capabilities = capabilities })
      vim.lsp.enable('lua_ls')

      vim.lsp.config('jsonls', { capabilities = capabilities })
      vim.lsp.enable('jsonls')

      vim.lsp.config('gopls', {
        capabilities = capabilities,
        cmd = { "gopls", "serve" },
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
      vim.lsp.enable('gopls')

      local map = vim.keymap.set
      map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true })
      map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
      map('n', 'g? ', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
      map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
      map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })
      map('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>', { silent = true })
      map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })
      map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })
    end,
  },
}