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
  if not exists(path) then
    return os.execute('mkdir ' .. path) and true or false
  end

  return false
end

function Util.getPath(str)
  local s = str:gsub("%-","")
  return s:match("(.*[/\\])")
end

return Util
