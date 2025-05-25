local vim = vim or {}
local map = vim.keymap.set

-- tpope/vim-rails
map('n', ' rC', ':.Runner<CR>', { silent = true, buffer = true })
map('n', ' rA', ':Runner<CR>', { silent = true, buffer = true })
