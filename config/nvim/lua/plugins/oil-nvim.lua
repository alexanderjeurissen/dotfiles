return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        keymaps = {
          ["q"] = { "actions.close", mode = "n" },
          -- ["Esc"] = { "actions.close", mode = "n" },
        }
      })

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
}
