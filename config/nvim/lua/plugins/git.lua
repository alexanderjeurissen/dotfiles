return {
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup()
      vim.keymap.set('n', '<leader>dc', [[:DiffviewClose<CR>]], { silent = true })
      vim.keymap.set('n', '<leader>gd', [[:DiffviewOpen<CR>]], { silent = true })
      vim.keymap.set('n', '<leader>gD', [[:DiffviewOpen develop<CR>]], { silent = true })
      vim.keymap.set('n', '<leader>fh', [[:DiffviewFileHistory %<CR>]], { silent = true })
    end,
  },
  {
    "TimUntersberger/neogit",
    config = function()
      require('neogit').setup({ auto_show_console = false })
      vim.keymap.set('n', '<leader>gs', function() require('neogit').open() end, { silent = true })
    end,
  },
}
