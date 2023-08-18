local General = require('general')
local vim = vim or {}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup('ALEXANDER_GENERAL_LUA', {})

-- When editing a file, always jump to the last known cursor position.
-- Don't do it for commit messages, when the position is invalid, or when
-- inside an event handler (happens when dropping a file on gvim).
-- In addition open folds till the cursor is visible
autocmd('BufReadPost', {
  callback = function()
    local line = vim.fn.line

    if vim.bo.filetype == 'gitcommit' then return end
    if line("'\"") <= 0 then return end
    if line("'\"") > line('$') then return end

    vim.cmd("normal g`\"")
    vim.cmd('normal zv')
  end,
  group = general
})

-- Disable linting and syntax highlighting for large files
autocmd('BufReadPre', {
  callback = function()
    if vim.fn.getfsize(vim.fn.expand('%')) > 10000000 then
      vim.cmd('syntax off')
      vim.g.ale_enabled = 0
      vim.g.coc_enabled = 0
    end
  end,
  group = general
})

-- http://vim.wikia.com/wiki/Speed_up_Syntax_Highlighting
autocmd('syntax', {
  callback = function()
    local line = vim.fn.line

    if 2000 < line('$') then
      vim.cmd('syntax sync maxlines=200')
    end
  end,
  group = general
})

-- Add sh highlighthing when editing fish files
--[[ autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.fish',
  callback = function() vim.bo.filetype = 'sh' end,
  group = general
}) ]]

-- Set syntax highlighting for Apraisals
autocmd({'BufRead', 'BufNewFile'}, {
  pattern = 'Appraisals',
  callback = function() vim.bo.filetype = 'ruby' end,
  group = general
})

-- Automatically remove fugitive buffers
autocmd('BufReadPost', {
  pattern = 'fugitive://*',
  callback = function() vim.bo.bufhidden = 'delete' end,
  group = general
})

-- Automatically remove trailing whitespaces unless file is blacklisted
autocmd('BufWritePre', {
  callback = function()
    General.Preserve(function() vim.cmd("%s/\\s\\+$//e") end)
  end,
  group = general
})

-- Ensure directory structure exists when opening a new file
autocmd('BufNewFile', {
  callback = function() General.EnsureDirExists() end,
  group = general
})

-- NOTE: open quickfix window after vim grep
-- ref: https://www.reddit.com/r/vim/comments/bmh977/automatically_open_quickfix_window_after/
local qf_group = augroup('ALEXANDER_QF', {})
autocmd('QuickFixCmdPost', {
  pattern = '[^l]*',
  command = 'cwindow',
  group = qf_group
})

autocmd('QuickFixCmdPost', {
  pattern = 'l*',
  command = 'lwindow',
  group = qf_group
})
