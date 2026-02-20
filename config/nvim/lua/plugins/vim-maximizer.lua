return {
  {
    "szw/vim-maximizer",
    cmd = "MaximizerToggle",
    keys = {
      { "<leader>wz", ":MaximizerToggle<CR>", silent = true, desc = "Toggle window maximizer" },
    },
    config = function()
      vim.g.maximizer_set_default_mapping = 0
      vim.g.maximizer_restore_on_winleave = 1
    end,
  },
}
