local vim = vim or {}
local Util = require('util')
local nmap = Util.nmap

local diffview = require("diffview")
local neogit = require('neogit')

diffview.setup()
neogit.setup({
  auto_show_console = false
})

nmap('<leader>gs', [[:lua require('neogit').open()<CR>]])
nmap('<leader>dc', [[:DiffviewClose<CR>]])
nmap('<leader>gd', [[:DiffviewOpen<CR>]])
nmap('<leader>gD', [[:DiffviewOpen develop<CR>]])
nmap('<leader>fh', [[:DiffviewFileHistory %<CR>]])
