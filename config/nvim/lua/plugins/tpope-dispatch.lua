local api = vim.api
local fn = vim.fn
local cmd = api.nvim_command

local dispatch = {}

dispatch.nearest = function()
  local old_dispatch = vim.b.dispatch

  vim.b.dispatch=old_dispatch .. ':' .. api.nvim_get_current_line()

  cmd("Dispatch")

  vim.b.dispatch = old_dispatch
end

return dispatch
