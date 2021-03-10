local ido = require("ido")
local main = require("ido.core.main")
local advice = require("ido.core.advice")

-- Vim imports {{{
local api = vim.api
local fn = vim.fn
local cmd = api.nvim_command
local set_keymap = api.nvim_set_keymap
-- }}}

-- Ido PKG import statements {{
require("ido-pkg/files")
require("ido-pkg/browse")
require("ido-pkg/cd")
-- }}

-- Ido layouts {{{
ido.layouts.setup("minimal", {
   results_start = " { ",
   results_end = " }",
   results_separator = " | ",
   height = 1,
})

ido.layouts.setup("vertical", {
   results_start = "\n ❯ ",
   results_end = "",

   results_separator = "\n    ",

   height = 10,
})
-- }}}

ido.opts.setup({
   layout = ido.layouts.minimal
})

ido.pkg.setup('find_files', {
  pkg_opts = {
    command = 'rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'
  }
})

-- NOTE: bindings {{{
  --[[ set_keymap('n',
    '<leader>pf',
    "<cmd>lua require('ido').pkg.run('find_files')<CR>",
    { noremap = true, silent = true }) ]]

  --[[ set_keymap('n',
    '<leader>ff',
    "<cmd>lua require('ido').pkg.run('find_files')<CR>",
    { noremap = true, silent = true }) ]]

  set_keymap('n',
    '<leader>.',
    "<cmd>lua require('ido').pkg.run('browse')<CR>",
    { noremap = true, silent = true })
-- }}}
-- vim: foldmethod=marker:sw=2:foldlevel=10
