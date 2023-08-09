local vim = vim or {}

-- Disable marking of margin (colorcolumn)
vim.call('general#MarkMargin', 0)

vim.o.tabstop = 2
vim.o.shiftwidth = 0
vim.o.softtabstop = 0
vim.o.expandtab = 0

-- vim.o.list = true
