return {
  {
    "moll/vim-bbye",
    config = function()
      local map = vim.keymap.set
      map('n', '<leader>wc', ':q<cr>', { desc = 'Close window' })
      map('n', '<leader>bd', ':Bdelete<CR>', { desc = 'Delete buffer' })
      map('n', '<leader>tC', ':tabnew<CR>', { desc = 'New tab' })
      map('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
      map('n', '<leader>tp', ':tabprevious<CR>', { desc = 'Previous tab' })
      map('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab' })
      map('n', '<leader>bo', ':DeleteHiddenBuffers<CR>', { noremap = true, silent = true, desc = 'Delete hidden buffers' })
      map('n', '<leader>bw', ':bufdo :Bdelete<CR>', { noremap = true, silent = true, desc = 'Wipe all buffers' })
    end,
  },
}
