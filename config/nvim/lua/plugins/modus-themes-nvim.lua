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
        --- You can override specific color groups to use other groups or a hex color
        --- Function will be called with a ColorScheme table
        --- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- Function will be called with a Highlights and ColorScheme table
        --- Refer to `extras/lua/modus_operandi.lua` or `extras/lua/modus_vivendi.lua` for the Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })

      vim.cmd.colorscheme "modus"
    end,
  },
}
