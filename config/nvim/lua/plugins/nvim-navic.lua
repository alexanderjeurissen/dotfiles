return {
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    config = function()
      local navic = require("nvim-navic")
      navic.setup{
        lsp = { auto_attach = true, preference = nil },
        separator = "  ",
      }
    end,
  },
}
