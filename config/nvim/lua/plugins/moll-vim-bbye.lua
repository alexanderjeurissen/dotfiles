local set_keymap = vim.api.nvim_set_keymap

set_keymap('n', '<leader>wc', ':q<cr>', {})
set_keymap('n', '<leader>bd', ':Bdelete<CR>', {})

-- Delete all hidden buffers
set_keymap('n', '<leader>bo', ':DeleteHiddenBuffers<CR>', { noremap = true, silent = true })

-- Delete all buffers, but keep windows open
set_keymap('n', '<leader>bw', ':bufdo :Bdelete<CR>', { noremap = true, silent = true })
