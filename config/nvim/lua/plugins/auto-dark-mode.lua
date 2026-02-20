return {
  "f-person/auto-dark-mode.nvim",
  event = "VeryLazy",
  opts = {
    update_interval = 3000,
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd("colorscheme modus")
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      vim.cmd("colorscheme modus")
    end,
  }
}
