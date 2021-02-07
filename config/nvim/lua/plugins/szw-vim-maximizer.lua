local set_keymap = vim.api.nvim_set_keymap

vim.g.maximizer_set_default_mapping = 0
vim.g.maximizer_restore_on_winleave = 1

set_keymap('n', '<leader>wz', ':MaximizerToggle<CR>', { silent = true })
