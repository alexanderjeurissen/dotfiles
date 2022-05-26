local map = vim.keymap.set

map('n', '<leader>wc', ':q<cr>', {})
map('n', '<leader>bd', ':Bdelete<CR>', {})

-- Delete all hidden buffers
map('n', '<leader>bo', ':DeleteHiddenBuffers<CR>', { noremap = true, silent = true })

-- Delete all buffers, but keep windows open
map('n', '<leader>bw', ':bufdo :Bdelete<CR>', { noremap = true, silent = true })
