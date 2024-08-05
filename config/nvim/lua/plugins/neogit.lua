local vim = vim or {}
local Util = require('util')
local nmap = Util.nmap

local neogit = require('neogit')

neogit.setup()

nmap('<leader>gs', [[:lua require('neogit').open()<CR>]])
