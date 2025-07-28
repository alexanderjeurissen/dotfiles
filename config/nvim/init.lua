vim.loader.enable()

local k = vim.keycode

-- load options, keymaps and autocommands from separate modules
require('options')

-- Abbreviations {{{
-- Fix annoying typos
vim.api.nvim_exec([[
  cnoreabbrev qw wq
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
  cnoreabbrev QA qa
  cnoreabbrev Qa qa
  cnoreabbrev W w
  cnoreabbrev WW w
  cnoreabbrev Q q

  inoreabbrev teh the
  inoreabbrev reprot report
  inoreabbrev Reprot Report
]], false)

-- }}}
-- Variables {{{
vim.g.python_host_prog = "python3"

vim.g.netrw_browsex_viewer =
"open -a '/Applications/Google Chrome.app'" -- ensure gx opens the url under cursor
vim.g.netrw_keepdir = 0

vim.g.mapleader = k'<Space>' -- Set mapleader to <space>
-- }}}

require('keymaps')
require('autocmds')




if vim.g.vscode then
  -- VSCode extension
else
  require('config.lazy')
end

-- vim: foldmethod=marker:sw=2:foldlevel=10
