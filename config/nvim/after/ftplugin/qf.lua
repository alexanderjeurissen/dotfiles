-- Snippets from vim-qf
-- Credits: https://github.com/romainl/vim-qf

local vim = vim or {}
local map = vim.keymap.set

-- Preview the file under the cursor in a vertical preview window
local function preview_file()
  local winwidth = vim.o.columns
  local cur_line = vim.fn.getline('.')
  local cur_file = vim.fn.fnameescape(cur_line:gsub('|.*$', ''))

  if cur_line:match('|%d+') then
    local cur_pos = cur_line:match('^.-|(%d+)')
    vim.cmd('vertical pedit! +' .. cur_pos .. ' ' .. cur_file)
  else
    vim.cmd('vertical pedit! ' .. cur_file)
  end

  vim.cmd('wincmd P')
  vim.cmd('vert resize ' .. math.floor(winwidth / 2))
  vim.cmd('wincmd p')
end

-- expose function for mappings
_G.quickfix_preview = preview_file

-- Map keys for quickfix buffers
map('n', 'p', '<Cmd>lua quickfix_preview()<CR>', { silent = true, buffer = true })
map('n', 'q', ':pclose!<CR>:quit<CR>', { silent = true, buffer = true })
map('n', 'o', '<CR><C-w>p', { silent = false, buffer = true })

