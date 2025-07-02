return {
  {
    "szw/vim-maximizer",
    config = function()
      vim.g.maximizer_set_default_mapping = 0
      vim.g.maximizer_restore_on_winleave = 1
      vim.keymap.set('n', '<leader>wz', ':MaximizerToggle<CR>', { silent = true, desc = 'Toggle window maximizer' })
    end,
  },
}
