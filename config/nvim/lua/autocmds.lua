local vim = vim or {}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup('ALEXANDER_GENERAL_LUA', {})

-- When editing a file, always jump to the last known cursor position.
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

-- Set syntax highlighting for Appraisals
vim.filetype.add({ filename = { Appraisals = 'ruby' } })

-- Function to delete hidden buffers
autocmd('BufLeave', {
  pattern = '*',
  callback = function()
    local buffers = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), function(_, val)
      return vim.fn.buflisted(val) == 1 and vim.fn.bufwinnr(val) == -1 and vim.fn.getbufvar(val, "&modified") == 0 and
      vim.fn.empty(vim.fn.bufname(val)) == 1
    end)
    for _, buf in ipairs(buffers) do
      vim.cmd('bdelete ' .. buf)
    end
  end,
  group = general
})

-- Automatically remove trailing whitespaces unless file is blacklisted
autocmd('BufWritePre', {
  callback = function()
    require('general').Preserve(function() vim.cmd("%s/\\s\\+$//e") end)
  end,
  group = general
})

-- Ensure directory structure exists when opening a new file
autocmd('BufNewFile', {
  callback = function() require('general').EnsureDirExists() end,
  group = general
})

-- NOTE: open quickfix/location list window after it's populated
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

return {}
