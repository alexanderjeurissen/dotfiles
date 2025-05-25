local vim = vim or {}
local Util = require('util')
local nnoremap = Util.nnoremap

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
nnoremap('zN', [[:normal zC<CR>/^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>]], {}, true)
nnoremap('zP', [[:normal zC<CR>?^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>]], {}, true)

nnoremap('zn', [[:normal zc<CR>/^@@<CR>:nohl<CR>:normal zv<CR>:normal zt<CR>]], {}, true)
nnoremap('zp', [[:normal zc<CR>?^@@<CR>:nohl<CR>:normal zv<CR>:normal zb<CR>]], {}, true)
nnoremap('q', [[<CMD>DiffviewClose<CR]], {}, true)
