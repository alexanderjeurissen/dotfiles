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
  if not Util.exists(path) then
    return os.execute('mkdir ' .. path) and true or false
  end

  return false
end

function Util.getPath(str)
  local s = str:gsub("%-","")
  return s:match("(.*[/\\])")
end

-- Slice table as this is not included in lua 5.1
function Util.tbl_slice(tbl, start_idx, end_idx)
  local slice = {}
  end_idx = end_idx or #tbl

  for idx=start_idx, end_idx do
    table.insert(slice, tbl[idx])
  end

  return slice
end

-- Check if the current directory is a git repo
function Util.ensure_git()
 if os.execute("git rev-parse --is-inside-work-tree 2>/dev/null") ~= 0 then
   error("Not a git repository")
 end
end

function Util.nmap(key, action, options)
  api.nvim_set_keymap('n', key, action, options or {})
end


function Util.nnoremap(key, action, options)
  options = options or {}

  local opts = vim.tbl_extend('force', { noremap = true, silent = true  } , options)
  api.nvim_set_keymap('n', key, action, opts)
end

function Util.imap(key, action, options)
  api.nvim_set_keymap('i', key, action, options or {})
end

function Util.inoremap(key, action, options)
  options = options or {}

  local opts = vim.tbl_extend('force', { noremap = true, silent = true  } , options)
  api.nvim_set_keymap('i', key, action, options or {})
end

return Util
