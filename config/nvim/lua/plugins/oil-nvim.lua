return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        keymaps = {
          ["q"] = { "actions.close", mode = "n" },
          -- ["Esc"] = { "actions.close", mode = "n" },
        }
      })

    end,
  },
}
