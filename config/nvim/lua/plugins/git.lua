local map = vim.keymap.set

local diffview = require("diffview")
local neogit = require('neogit')

diffview.setup()
neogit.setup({
  auto_show_console = false
})

map('n', '<leader>gs', [[:lua require('neogit').open()<CR>]], { silent = true })
map('n', '<leader>dc', [[:DiffviewClose<CR>]], { silent = true })
map('n', '<leader>gd', [[:DiffviewOpen<CR>]], { silent = true })
map('n', '<leader>gD', [[:DiffviewOpen develop<CR>]], { silent = true })
map('n', '<leader>fh', [[:DiffviewFileHistory %<CR>]], { silent = true })
