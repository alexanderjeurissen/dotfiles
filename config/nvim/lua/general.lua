local util = require('util')

local mkdir = util.mkdir
local nvim_command = util.nvim_command
local nvim_call_function = util.nvim_call_function

local General = {}

-- NOTE: inspired by a similar function in Damian Conway's vimrc
-- SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function General.EnsureDirExists()
  local required_dir = vim.fn.expand('%:h')

  if not util.exists(required_dir) then
    util.confirm({
      create = '',
      quit = function() nvim_command('exit') end
    }, "Parent directory '" .. required_dir .. "' doesn't exist.")

    if not mkdir(required_dir) then
      util.confirm({
        Quit = function() nvim_command('exit') end,
        Continue = ''
      }, "Can't create '" .. required_dir .. "'")
    end
  end
end

function General.rename_file()
  local fname = vim.api.nvim_buf_get_name(0)
  local new_name = vim.fn.input('New file name: ', fname)

  if new_name and #new_name > 0 and new_name ~= fname then
    util.confirm({
      Yes = function()
        vim.fn.rename(fname, new_name)
        vim.cmd('edit ' .. new_name)
        vim.cmd('w! ' .. new_name)
        vim.cmd('redraw!')
      end,
      No = ''
    })
  end
end

return General
