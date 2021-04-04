vim.wo.spell = true
vim.bo.textwidth = 70

-- NOTE: Ensures that :q and :x work with neovim-remote
-- https://github.com/mhinz/neovim-remote#typical-use-cases
vim.bo.bufhidden = 'delete'
