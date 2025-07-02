return {
  {
    "miikanissi/modus-themes.nvim",
    config = function()
      require("modus-themes").setup({
        style = "auto",
        variant = "default",
        transparent = false,
        dim_inactive = false,
        styles = {
          comments = { italic = true },
          keywords = { bold = true },
          functions = {},
          variables = {},
        },
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
      })
    end,
  },
}
