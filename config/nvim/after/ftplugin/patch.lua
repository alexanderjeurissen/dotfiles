local vim = vim or {}
local wo = vim.wo

wo.foldenable = true

-- Autofold nothing by default
wo.foldlevel = 0

-- Only fold outer functions
wo.foldnestmax = 0

wo.list = false
wo.cursorcolumn = false
wo.cursorline = false
wo.conceallevel = 0
wo.colorcolumn = '0'

vim.call('general#MarkMargin', 0)

