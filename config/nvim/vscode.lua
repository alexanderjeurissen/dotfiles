require 'keybindings'
require 'autocmd'
require 'options'

local Util = require('util')

local nmap = Util.nmap
local xnoremap = Util.xnoremap

if vim.g.vscode == 1 then
    print("neovim configuration for vscode loaded")

    nmap("za", [[<Cmd>call VSCodeNotify('editor.toggleFold')<CR>]])
    nmap("zR", [[<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>]])
    nmap("zM", [[<Cmd>call VSCodeNotify('editor.foldAll')<CR>]])
    nmap("zo", [[<Cmd>call VSCodeNotify('editor.unfold')<CR>]])
    nmap("zO", [[<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>]])
    nmap("zc", [[<Cmd>call VSCodeNotify('editor.fold')<CR>]])
    nmap("zC", [[<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>]])

    nmap("z1", [[<Cmd>call VSCodeNotify('editor.foldLevel1')<CR>]])
    nmap('z2', [[<Cmd>call VSCodeNotify('editor.foldLevel2')<CR>]])
    nmap('z3', [[<Cmd>call VSCodeNotify('editor.foldLevel3')<CR>]])
    nmap('z4', [[<Cmd>call VSCodeNotify('editor.foldLevel4')<CR>]])
    nmap('z5', [[<Cmd>call VSCodeNotify('editor.foldLevel5')<CR>]])
    nmap('z6', [[<Cmd>call VSCodeNotify('editor.foldLevel6')<CR>]])
    nmap('z7', [[<Cmd>call VSCodeNotify('editor.foldLevel7')<CR>]])
    
    nmap('<c-l>', [[<Cmd>tabnext]])
    nmap('<c-h>', [[<Cmd>tabprev]])
    -- xnoremap <silent> zV <Cmd>call VSCodeNotify('editor.foldAllExcept')<CR>
end