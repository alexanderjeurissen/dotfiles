local Util = require('util')

local mkdir = Util.mkdir
local cmd = Util.nvim_command
local nvim_call_function = Util.nvim_call_function

local General = {}

-- NOTE: inspired by a similar function in Damian Conway's vimrc
-- SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function General.EnsureDirExists()
  local required_dir = vim.fn.expand('%:h')

  if not Util.exists(required_dir) then
    Util.confirm({
      create = Util.noop,
      quit = function() cmd('exit') end
    }, "Parent directory '" .. required_dir .. "' doesn't exist.")

    if not mkdir(required_dir) then
      Util.confirm({
        Quit = function() cmd('exit') end,
        Continue = ''
      }, "Can't create '" .. required_dir .. "'")
    end
  end
end

function General.rename_file()
  local fname = vim.api.nvim_buf_get_name(0)
  local new_name = vim.fn.input('New file name: ', fname)

  if new_name and #new_name > 0 and new_name ~= fname then
    Util.confirm({
      Yes = function()
        vim.fn.rename(fname, new_name)
        vim.cmd('edit ' .. new_name)
        vim.cmd('w! ' .. new_name)
        vim.cmd('redraw!')
      end,
      No = Util.noop
    })
  end
end

-- NOTE: Inspired by similar function in Damian Conway's vimrc
-- SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function General.hl_next(blinktime)
  local target_pat = [[\c\%#]] .. vim.fn.getreg('/')

  local ring = vim.fn.matchadd('CurrentSearchMatch', target_pat, 101)
  vim.cmd('redraw')

  cmd('sleep ' .. blinktime .. 'm')

  vim.fn.matchdelete(ring)
  vim.cmd('redraw')
end

return General
