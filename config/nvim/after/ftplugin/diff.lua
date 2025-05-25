local vim = vim or {}
local map = vim.keymap.set

vim.opt_local.foldenable = true
vim.opt_local.foldlevel = 0
vim.opt_local.foldnestmax = 0

vim.opt_local.list = false

vim.opt_local.cursorcolumn = false
vim.opt_local.cursorline = false
vim.opt_local.conceallevel = 0
vim.opt_local.colorcolumn = '0'

-- NOTE: Ensures that :q and :x work with neovim-remote
-- https://github.com/mhinz/neovim-remote#typical-use-cases
vim.opt_local.bufhidden = 'delete'

vim.cmd(':normal zv')

-- Create some additional fold movements
map('n', 'zN', [[:normal zC<CR>/^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>]], { silent = true, buffer = true })
map('n', 'zP', [[:normal zC<CR>?^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>]], { silent = true, buffer = true })

map('n', 'zn', [[:normal zc<CR>/^@@<CR>:nohl<CR>:normal zv<CR>:normal zt<CR>]], { silent = true, buffer = true })
map('n', 'zp', [[:normal zc<CR>?^@@<CR>:nohl<CR>:normal zv<CR>:normal zb<CR>]], { silent = true, buffer = true })
map('n', 'q', '<CMD>DiffviewClose<CR>', { silent = true, buffer = true })
