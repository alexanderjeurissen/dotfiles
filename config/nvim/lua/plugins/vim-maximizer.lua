local map = vim.keymap.set

vim.g.maximizer_set_default_mapping = 0
vim.g.maximizer_restore_on_winleave = 1

map('n', '<leader>wz', ':MaximizerToggle<CR>', { silent = true })
