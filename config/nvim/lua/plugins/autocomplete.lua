local vim = vim or {}
local cmp = require('cmp')
local lspkind = require('lspkind')

-- require("cmp-path").setup()
-- require("cmp-buffer").setup()
-- require("cmp-cmdline").setup()

lspkind.init({
  mode = 'symbol',
  preset = 'codicons',
})

--[[ require("copilot").setup({
  panel = {
    enabled = false,
    auto_refresh = false,
  },
  suggestion = {
    enabled = false,
    auto_trigger = true,
    debounce = 75,
  },
  filetypes = {
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
})

require("copilot_cmp").setup() ]]

cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    -- { name = "copilot" },
    { name = "nvim_lsp" },
  }, {
    { name = 'buffer' },
    { name = "path" },
    { name = "orgmode" },
  }),
  formatting = {
    -- fields = { "kind", "abbr" },
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = 'symbol_text',     -- show only symbol annotations
        maxwidth = 50,            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        symbol_map = { Copilot = "" }
      })(entry, vim_item)

      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end,
  }
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'buffer' },
  }, {
    { name = 'path' }
  }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline' }
  }, {
    { name = 'path' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})
