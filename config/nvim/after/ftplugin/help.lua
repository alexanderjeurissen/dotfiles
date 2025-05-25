local vim = vim or {}
local Util = require('util')
local nmap = Util.nmap

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
nmap('o', [[<C-]>]], {}, true)
nmap('L', [[<C-]>]], {}, true)

-- Jump back with H
nmap('H', [[<C-T>]], {}, true)
