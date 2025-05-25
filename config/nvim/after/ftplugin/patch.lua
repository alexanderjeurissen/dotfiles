local vim = vim or {}

vim.opt_local.foldenable = true

-- Autofold nothing by default
vim.opt_local.foldlevel = 0

-- Only fold outer functions
vim.opt_local.foldnestmax = 0

vim.opt_local.list = false
vim.opt_local.cursorcolumn = false
vim.opt_local.cursorline = false
vim.opt_local.conceallevel = 0
vim.opt_local.colorcolumn = '0'
