local fzf = require("fzf")
local ensure_git = require("util").ensure_git
local nnoremap = require("util").nnoremap
local inoremap = require("util").nnoremap
local tbl_slice = require("util").tbl_slice

local CLI_OPTS = table.concat({
  '--no-inline-info',
  '--color=bw,border:8,bg:8,info:2,prompt:12,fg:10,bg+:0,fg+:10,gutter:0',
  '--multi',
  '--sort',
  '--layout=reverse',
  '--bind=ctrl-a:select-all,ctrl-d:deselect-all',
  '--expect=ctrl-o,ctrl-t,ctrl-s,ctrl-v',
  '--border=sharp',
  '--no-padding',
  '--no-margin',
  '--no-height'
}, ' ')

local WINDOW_OPTS = { height = 20, top=1, border=false }

local FILES_CMD = 'rg --files'

-- generate prompt by shortening provided path
local function prompt(path)
  local cwd = vim.fn.fnamemodify(path, ':~:.')
  local short_cwd = vim.fn.pathshorten(cwd)

  if not short_cwd then return '~/' end

  return short_cwd .. '/'
end

-- fill quickfix list with provided filepaths
local function build_loc_list(lines, win)
  win = win or vim.api.nvim_get_current_win()
  local winnr = vim.api.nvim_win_get_number(win)

  local dict = vim.tbl_map(function(line)
    return { filename = line }
  end, lines)

  vim.fn.setloclist(winnr, dict)
end

local function getPath(str,sep) sep=sep or'/'return str:match("(.*)"..sep)end

local function process_results(results, path, win)
  if not results then return end
  path = path or (vim.loop.cwd() .. '/')

  local key = results[1]
  local choices = tbl_slice(results, 2)

  if #choices > 1 then
    build_loc_list(choices, win)
    vim.cmd('lopen')
    return
  end

  local choice = choices[1]

  if key == '' then
    vim.cmd("edit" .. path .. choice)
  elseif key == "ctrl-s" then
    vim.cmd("split" .. path .. choice)
  elseif key == "ctrl-v" then
    vim.cmd("vsplit" .. path .. choice)
  elseif key == "ctrl-t" then
    vim.cmd("tabe" .. path .. choice)
  else
    -- Somehow error() does not work
    -- when invoked *after* we invoke fzf
    -- it does work in regular coroutines, so likely a bug
    errorMsg("Not implemented!")
    -- error("Not implemented!")
  end
end

local M = {}

function M.project_files()
  coroutine.wrap(function()
    local win = vim.api.nvim_get_current_win()
    local opts = CLI_OPTS ..  ' --prompt=' .. prompt(vim.loop.cwd())
    local results = fzf.fzf_relative(FILES_CMD, opts, WINDOW_OPTS)
    process_results(results, nil, win)
  end)()
end

function M.find_files(path)
  coroutine.wrap(function()
    local current_bufnr = vim.api.nvim_get_current_buf()
    path = path or getPath(vim.api.nvim_buf_get_name(current_bufnr))

    if not path then return error('current buffer is empty and no path provided') end

    local opts = CLI_OPTS ..  ' --prompt=' .. prompt(path)
    local command = FILES_CMD .. ' ' .. path

    local results = fzf.fzf_relative(command, opts, WINDOW_OPTS)

    process_results(results, '')
  end)()
end

function M.insert_file_path()
  coroutine.wrap(function()
    local win = vim.api.nvim_get_current_win()
    local opts = CLI_OPTS ..  ' --no-multi'
    local results = fzf.fzf_relative(FILES_CMD, opts, WINDOW_OPTS)

    vim.api.nvim_set_current_win(win)
    if results then vim.cmd('normal i' .. results[2]) end
  end)()
end

function M.git_branch_files()
  coroutine.wrap(function()
    ensure_git()

    local opts = CLI_OPTS ..  ' --prompt="GIT (develop) "'
    local command = 'git diff --name-only develop'
    local results = fzf.fzf_relative(command, opts, WINDOW_OPTS)

    process_results(results)
  end)()
end

function M.git_diff_files()
  coroutine.wrap(function()
    ensure_git()

    local opts = CLI_OPTS ..  ' --prompt="GIT (upstream)"'
    local command = 'git diff --name-only @{u}'
    local results = fzf.fzf_relative(command, opts, WINDOW_OPTS)

    process_results(results)
  end)()
end

function M.buffers()
  coroutine.wrap(function()
    -- using a greedy whitespace regex as delimeter, we choose the 3rd to last item
    -- this skips the *line*N portion of the string which is at the end of each ls entry.
    local opts = CLI_OPTS ..  [[ --no-multi --prompt="BUFFER " --delimiter "\s+" --nth -3]]

    vim.cmd('redir => g:buffers | silent ls | redir END')
    local buffers = tbl_slice(vim.split(vim.g.buffers, '\n'), 2)
    vim.g.buffers = nil

    local results = fzf.fzf_relative(buffers, opts, WINDOW_OPTS)

    if results then
      local bufnr = tonumber(string.match(results[2], '^[ 0-9]*'))
      vim.cmd('buffer ' .. bufnr)
    end
  end)()
end

-- Files bindings {{{
nnoremap('<leader>pf', "<cmd>lua require('plugins/fzf').project_files()<CR>")
nnoremap('<leader>p/', "<cmd>lua require('plugins/fzf').live_grep()<CR>")
nnoremap('<leader>ff', "<cmd>lua require('plugins/fzf').find_files()<CR>")
vim.keymap.set('i', '<C-F>', [[<C-O>:lua require('plugins/fzf').insert_file_path()<CR>]])
-- }}}

nnoremap('<leader>bb', "<cmd>lua require('plugins/fzf').buffers()<CR>")
nnoremap('gb', "<cmd>lua require('plugins/fzf').buffers()<CR>")

-- Git bindings {{{
nnoremap('<leader>gF', "<cmd>lua require('plugins/fzf').git_branch_files()<CR>")
nnoremap('<leader>gf', "<cmd>lua require('plugins/fzf').git_diff_files()<CR>")
-- }}}

-- Rails bindings {{{
nnoremap('<leader>rh', "<cmd>lua require('plugins/fzf').find_files('app')<CR>")
nnoremap('<leader>rl', "<cmd>lua require('plugins/fzf').find_files('lib')<CR>")
nnoremap('<leader>rs', "<cmd>lua require('plugins/fzf').find_files('spec')<CR>")
nnoremap('<leader>rf', "<cmd>lua require('plugins/fzf').find_files('spec/factories')<CR>")
nnoremap('<leader>rfi', "<cmd>lua require('plugins/fzf').find_files('spec/fixtures')<CR>")
nnoremap('<leader>rmi', "<cmd>lua require('plugins/fzf').find_files('db/migrate')<CR>")
-- }}}

return M
-- vim: foldmethod=marker:sw=2:foldlevel=10
