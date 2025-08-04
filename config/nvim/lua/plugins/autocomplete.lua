return {
  -- copilot core
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  -- copilot-cmp integration; only loads after copilot.lua
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    after = "copilot.lua", -- ensures load order
    config = function()
      require("copilot_cmp").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
    },
    after = "copilot-cmp",
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      lspkind.init({ mode = 'symbol', preset = 'codicons' })

      cmp.setup({
        snippet = { expand = function(args) vim.snippet.expand(args.body) end },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = "copilot" },
            { name = "nvim_lsp" }
          },
          {
            { name = 'buffer' },
            { name = "path" },
            { name = "orgmode" }
          }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            max_width = 50,
            symbol_map = { Copilot = "" }
          })
        }
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'buffer' } }, { { name = 'path' } }),
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'cmdline' } }, { { name = 'path' } }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
  },
}
