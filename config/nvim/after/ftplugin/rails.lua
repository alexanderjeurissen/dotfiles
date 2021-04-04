local vim = vim or {}
local Util = require('util')
local nnoremap = Util.nnoremap

-- tpope/vim-rails
nnoremap(' rC', [[:.Runner<CR>]], {}, true)
nnoremap(' rA', [[:Runner<CR>]], {}, true)

vim.call('general#MarkMargin', 0)
