local set_keymap = vim.api.nvim_set_keymap
local nnoremap = require("util").nnoremap
local tnoremap = require("util").tnoremap

vim.g.tmux_navigator_no_mappings = 0
vim.g.tmux_navigator_save_on_switch = 1

nnoremap('<BS>', ':TmuxNavigateLeft<cr>')

tnoremap('<c-h>', '<C-\\><C-n>:TmuxNavigateLeft<cr>')
tnoremap('<c-j>', '<C-\\><C-n>:TmuxNavigateDown<cr>')
tnoremap('<c-k>', '<C-\\><C-n>:TmuxNavigateUp<cr>')
tnoremap('<c-l>', '<C-\\><C-n>:TmuxNavigateRight<cr>')
tnoremap('<c-\\>', '<C-\\><C-n>:TmuxNavigatePrevious<cr>')
