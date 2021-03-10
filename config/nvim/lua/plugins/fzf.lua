-- Vim imports {{{
local api = vim.api
local fn = vim.fn
local cmd = api.nvim_command
local set_keymap = api.nvim_set_keymap
-- }}}

local fzf = require("fzf")

local DEFAULT_OPTS = table.concat({
  '--no-inline-info',
  '--color=bw,border:8,bg:8,info:2,prompt:12,fg:10,bg+:0,fg+:10,gutter:0',
  '--multi',
  '--sort',
  '--layout=reverse',
  '--bind=ctrl-a:select-all,ctrl-d:deselect-all',
  '--expect=ctrl-o',
  '--border=sharp',
  '--no-padding',
  '--no-margin',
  '--no-height'
}, ' ')

local FILES_CMD = 'rg --files --ignore --smart-case --hidden --follow --no-messages --ignore-file ~/.gitignore'

local function prompt(path)
  local cwd = vim.fn.fnamemodify(path, ':~:.')
  local short_cwd = vim.fn.pathshorten(cwd)

  if not short_cwd then return '~/' end

  return short_cwd .. '/'
end

local function getPath(str,sep) sep=sep or'/'return str:match("(.*)"..sep)end

local function create_relative_centered_window()
  local columns, lines = vim.api.nvim_win_get_width(0), vim.api.nvim_win_get_height(0)
  local row, col = unpack(vim.api.nvim_win_get_position(0))

  local width = math.min(columns - 4, math.max(80, columns - 20))
  local height = math.min(lines - 4, math.max(20, lines - 10))

  local top = math.floor((row + (lines / 2)) - (height / 2))
  local left = math.floor((col + (columns / 2)) - (width / 2))

  local opts = { relative = 'editor', row = top, col = left, width = width, height = height, style = 'minimal' }

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(bufnr, true, opts)

  return bufnr
end

local M = {}

function M.project_files()
  coroutine.wrap(function()
    local win = vim.api.nvim_get_current_win()
    local buf = create_relative_centered_window()

    local opts = DEFAULT_OPTS ..  ' --prompt=' .. prompt(vim.loop.cwd())
    local results = fzf.raw_fzf(FILES_CMD, opts)

    vim.cmd("bw! " .. buf)
    vim.api.nvim_set_current_win(win)

    vim.cmd('edit' .. vim.loop.cwd() .. '/' .. results[2])
  end)()
end

function M.find_files()
  coroutine.wrap(function()
    local win = vim.api.nvim_get_current_win()
    local current_bufnr = vim.api.nvim_get_current_buf()

    local path = getPath(vim.api.nvim_buf_get_name(current_bufnr))

    if not path then return error('current buffer is empty') end

    local float = create_relative_centered_window()
    local opts = DEFAULT_OPTS ..  ' --prompt=' .. prompt(path)
    local command = FILES_CMD .. ' ' .. path

    local results = fzf.raw_fzf(command, opts)

    vim.cmd("bw! " .. float)
    vim.api.nvim_set_current_win(win)

    vim.cmd('edit' .. results[2])
  end)()
end

set_keymap('n',
  '<leader>pf',
  "<cmd>lua require('plugins/fzf').project_files()<CR>",
  { noremap = true, silent = true })

set_keymap('n',
  '<leader>ff',
  "<cmd>lua require('plugins/fzf').find_files()<CR>",
  { noremap = true, silent = true })

return M

--[[ coroutine.wrap(function()
  local results = fzf.fzf(FILES_CMD, DEFAULT_OPTS)
end)() ]]
