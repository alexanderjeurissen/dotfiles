require("ufo").setup({
  provider_selector = function()
    return { "treesitter", "indent" }
  end,
})
