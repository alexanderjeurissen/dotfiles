local util = require('util')

local mkdir = util.mkdir
local nvim_command = util.nvim_command
local nvim_call_function = util.nvim_call_function

local General = {}

-- NOTE: inspired by a similar function in Damian Conway's vimrc
-- SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function General.AskQuit(msg, options, quit_option)
  if nvim_call_function('confirm', { msg, options }) == quit_option then
    nvim_command('exit')
  end
end

-- NOTE: inspired by a similar function in Damian Conway's vimrc
-- SOURCE: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
function General.EnsureDirExists()
  local required_dir = nvim_call_function('expand', { '%:h' })

  if not util.exists(required_dir) then
    General.AskQuit("Parent directory '" .. required_dir .. "' doesn't exist.", "&Create it\nor &Quit?", 2)

    if not mkdir(required_dir) then
      General.AskQuit("Can't create '" .. required_dir .. "'", "&Quit\nor &Continue anyway?", 1)
    end
  end
end

return General
