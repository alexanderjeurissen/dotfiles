local vim = vim or {}
local wo = vim.wo
local Util = require('util')
local nnoremap = Util.nnoremap

wo.foldenable = true
wo.foldlevel = 0
wo.foldnestmax = 0

wo.list = false

wo.cursorcolumn = false
wo.cursorline = false
wo.conceallevel = 0
wo.colorcolumn = '0'

-- NOTE: Ensures that :q and :x work with neovim-remote
-- https://github.com/mhinz/neovim-remote#typical-use-cases
vim.bo.bufhidden = 'delete'

vim.cmd(':normal zv')

-- Create some additional fold movements
nnoremap('zN', [[:normal zC<CR>/^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>]], {}, true)
nnoremap('zP', [[:normal zC<CR>?^diff --git<CR>:nohl<CR>:normal zA<CR>:normal zt<CR>]], {}, true)

nnoremap('zn', [[:normal zc<CR>/^@@<CR>:nohl<CR>:normal zv<CR>:normal zt<CR>]], {}, true)
nnoremap('zp', [[:normal zc<CR>?^@@<CR>:nohl<CR>:normal zv<CR>:normal zb<CR>]], {}, true)
nnoremap('q', [[<CMD>DiffviewClose<CR]], {}, true)
