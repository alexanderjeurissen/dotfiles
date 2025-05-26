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
  -- PLUGINS {{{
  local rocks_config = {
    rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
    luarocks_config = {
      arch = "macosx-aarch64", -- or arch = "macosx-x86_64" , depending on your architecture
    },
  }

  vim.g.rocks_nvim = rocks_config

  local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
  }
  package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

  local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    -- Remove the dylib and dll paths if you do not need macos or windows support
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
  }
  package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

  vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
  -- }}}
end

-- vim: foldmethod=marker:sw=2:foldlevel=10
