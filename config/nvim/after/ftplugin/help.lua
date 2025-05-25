local vim = vim or {}
local map = vim.keymap.set

-- Snippets from vim-help
-- Credits:
-- * https://github.com/dahu/vim-help
-- * https://github.com/rafi/vim-config/blob/master/ftplugin/help.vim

vim.opt_local.spell = false

vim.opt_local.bufhidden = ''
vim.opt_local.iskeyword = vim.bo.iskeyword .. ",:,#,-"

vim.opt_local.cursorline = false
vim.opt_local.colorcolumn = '0'

-- Jump to links with o and L
map('n', 'o', '<C-]>', { remap = true, silent = true, buffer = true })
map('n', 'L', '<C-]>', { remap = true, silent = true, buffer = true })

-- Jump back with H
map('n', 'H', '<C-T>', { remap = true, silent = true, buffer = true })
