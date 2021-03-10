local set_keymap = vim.api.nvim_set_keymap

-- set_keymap('n', '<leader>gd', '<Plug>(coc-definition)', { silent = true })
set_keymap('n', '<leader>gr', '<Plug>(coc-references)', { silent = true })
set_keymap('n', '<leader>gi', '<Plug>(coc-implementation)', { silent = true })
