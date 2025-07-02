return {
  {
    "SmiteshP/nvim-navic",
    config = function()
      local navic = require("nvim-navic")
      navic.setup{
        lsp = { auto_attach = true, preference = nil },
        separator = "  ",
      }
    end,
  },
}
