vim.opt_local.spell = true
vim.opt_local.textwidth = 70

-- NOTE: Ensures that :q and :x work with neovim-remote
-- https://github.com/mhinz/neovim-remote#typical-use-cases
vim.opt_local.bufhidden = 'delete'
