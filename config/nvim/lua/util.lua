--- NVIM SPECIFIC SHORTCUTS
local vim = vim or {}
local api = vim.api
local fn = vim.fn

local Util = {}

Util.nvim_command = api.nvim_command
Util.nvim_call_function = api.nvim_call_function

-- Check if a file or directory exists in this path
function Util.exists(path)
  return io.open(path, "r") and true or false
end

-- create directory if it doesn't exist yet
function Util.mkdir(path)
  if Util.exists(path) then return false end
  return vim.fn.mkdir(path, 'p') == 1
end

function Util.getPath(str)
  local s = str:gsub("%-","")
  return s:match("(.*[/\\])")
end

function Util.noop() --[[ do nothing ]] end

-- Slice table as this is not included in lua 5.1
function Util.tbl_slice(tbl, start_idx, end_idx)
  local slice = {}
  end_idx = end_idx or #tbl

  for idx=start_idx, end_idx do
    table.insert(slice, tbl[idx])
  end

  return slice
end

-- Show confirm dialog before executing predicate
function Util.confirm(options, msg)
  local defaults = { Yes = Util.noop, No = Util.noop }
  msg = msg or 'Are you sure ?'
  options = options or defaults

  local option_tbl = {}
  local callback_tbl = {}

  for option, callback in pairs(options) do
    table.insert(option_tbl, '&'..option)
    table.insert(callback_tbl, callback)
  end

  local option_str = table.concat(option_tbl, '\n')

  local choice = vim.fn.confirm(msg, option_str)
  local choice_func = callback_tbl[choice]

  if choice and choice_func and type(choice_func) == 'function' then
    choice_func()
  end
end

-- Check if the current directory is a git repo
function Util.ensure_git()
 if os.execute("git rev-parse --is-inside-work-tree 2>/dev/null") ~= 0 then
   error("Not a git repository")
 end
end

local function map(mode, key, action, options, buffer)
  options = options or {}
  buffer = buffer or false

  local default_opts = { noremap = true, silent = true  }
  local opts = vim.tbl_extend('force', default_opts, options)

  if buffer then
    api.nvim_buf_set_keymap(0, mode, key, action, opts)
  else
    api.nvim_set_keymap(mode, key, action, opts)
  end
end

function Util.nmap(key, action, options, buffer)
  options = options or {}
  local opts = vim.tbl_extend('force', options, { noremap = false })
  map('n', key, action, opts, buffer)
end

function Util.nnoremap(key, action, options, buffer)
  map('n', key, action, options, buffer)
end

function Util.tnoremap(key, action, options, buffer)
  map('t', key, action, options, buffer)
end

function Util.imap(key, action, options, buffer)
  options = options or {}
  local opts = vim.tbl_extend('force', options, { noremap = false })
  map('i', key, action, opts, buffer)
end

function Util.inoremap(key, action, options, buffer)
  map('i', key, action, options, buffer)
end

function Util.xnoremap(key, action, options, buffer)
  map('x', key, action, options, buffer)
end

function Util.vmap(key, action, options, buffer)
  options = options or {}
  local opts = vim.tbl_extend('force', options, { noremap = false })
  map('v', key, action, opts, buffer)
end

function Util.vnoremap(key, action, options, buffer)
  map('v', key, action, options, buffer)
end

function Util.noremap(key, action, options, buffer)
  map('', key, action, options, buffer)
end

-- Define a function to get the highlighting group under the cursor
function get_highlight_group()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor_pos[1], cursor_pos[2]

    local synID = vim.fn.synID(row, col, 1)
    local name = vim.fn.synIDattr(synID, "name")
    local fg = vim.fn.synIDattr(synID, "fg")
    local fgGui = vim.fn.synIDattr(synID, "fg#")
    local bg = vim.fn.synIDattr(synID, "bg")
    local bgGui = vim.fn.synIDattr(synID, "bg#")

    print(vim.inspect(name))
    print(vim.inspect(fg))
    print(vim.inspect(bg))
    print(vim.inspect(fgGui))
    print(vim.inspect(bgGui))
end

-- Bind this function to a command or keymap if desired
vim.cmd("command! HighlightGroup lua get_highlight_group()")

return Util
