local vim = vim or {}
local bo = vim.bo
local wo = vim.wo
local Util = require('util')
local nmap = Util.nmap

-- Snippets from vim-help
-- Credits:
-- * https://github.com/dahu/vim-help
-- * https://github.com/rafi/vim-config/blob/master/ftplugin/help.vim

vim.wo.spell = false

vim.bo.bufhidden = ''
vim.bo.iskeyword = vim.bo.iskeyword .. ",:,#,-"

vim.wo.cursorline = false
vim.wo.colorcolumn = '0'

vim.call('general#MarkMargin', 0)

-- Jump to links with o and L
nmap('o', [[<C-]>]], {}, true)
nmap('L', [[<C-]>]], {}, true)

-- Jump back with H
nmap('H', [[<C-T>]], {}, true)
