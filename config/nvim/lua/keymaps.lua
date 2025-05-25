local vim = vim or {}
local map = vim.keymap.set

-- main keymaps
map('n', 'n', [[nzz:lua require('general').hl_next(100)<cr>]], { silent = true })
map('n', 'N', [[Nzz:lua require('general').hl_next(100)<cr>]], { silent = true })

-- KEYBINDINGS: Editing
-- Map '@' in visual mode to run macro over visual selection
vim.keymap.set('x', '@', [[:<C-u>lua require('general').ExecuteMacroOverVisualRange()<CR>]], {
  noremap = true,
  silent = true,
  desc = 'Run macro over visual selection',
})

-- Define the Bufmacro command
vim.api.nvim_create_user_command('Bufmacro', function()
    vim.cmd('bufdo execute "normal @a" | write')
end, {})

-- Define the Cmacro command
vim.api.nvim_create_user_command('Cmacro', function()
    vim.cmd('cdo execute "normal @a" | write')
end, {})

-- Move visual block
map('v', 'J', [[:m '>+1<CR>gv=gv]], { silent = true })
map('v', 'K', [[:m '<-2<CR>gv=gv]], { silent = true })

-- custom comma motion mapping
map('n', 'di,', [[f,dT,]], { silent = true })
map('n', 'ci,', [[f,cT,]], { silent = true })

-- (upper|lower)case word under cursor
map('n', 'g^', [[gUiW]], { silent = true })
map('n', 'gv', [[guiW]], { silent = true })

-- Create newline before/after current row
map('n', 'go', [[o<ESC>k]], { silent = true })
map('n', 'gO', [[O<ESC>j]], { silent = true })

-- Paste and keep pasting same thing, don't take what was removed
map('v', '<leader>p', [["_dP]], { silent = true })

-- Make Y behave like other capital commands.
map('n', 'Y', [[y$]], { silent = true })

-- keep selection after indent
map('v', '<', [[<gv]], { silent = true })
map('v', '>', [[>gv]], { silent = true })

map('i', '<c-h>', [[<c-o>x]], { silent = true })

-- KEYBINDINGS: Navigation / Search
-- Go to previous and next item in quickfix list
map('n', ' cw', [[:cwindow<CR><C-w>J]], { silent = true })
map('n', ' cq', [[<C-w><C-p>:cclose<CR>]], { silent = true })
map('n', ' cn', [[:cnext<CR>]], { silent = true })
map('n', ' cN', [[:cnfile<CR>]], { silent = true })
map('n', ' cp', [[:cprev<CR>]], { silent = true })
map('n', ' cP', [[:cpfile<CR>]], { silent = true })

map('n', ' ln', [[:lnext<CR>]], { silent = true })
map('n', ' lN', [[:lnfile<CR>]], { silent = true })
map('n', ' lp', [[:lprev<CR>]], { silent = true })
map('n', ' lP', [[:lpfile<CR>]], { silent = true })

-- Split creation
map('n', ' wv', [[<C-w>v]], { silent = true })
map('n', ' ws', [[<C-w>s]], { silent = true })

-- Split resizing
map('n', '<left>', [[<C-w>5<]], { remap = true, silent = true })
map('n', '<up>', [[<C-w>5+]], { remap = true, silent = true })
map('n', '<down>', [[<C-w>5-]], { remap = true, silent = true })
map('n', '<right>', [[<C-w>5>]], { remap = true, silent = true })

-- Split navigation
map('n', '<c-h>', [[<C-w><left>]], { silent = true })
map('n', '<c-j>', [[<C-w><down>]], { silent = true })
map('n', '<c-k>', [[<C-w><up>]], { silent = true })
map('n', '<c-l>', [[<C-w><right>]], { silent = true })
map('n', [[<c-\>]], [[<C-w><w>]], { silent = true })

-- KEYBINDINGS: General
-- Disable arrows and BS in insert mode
map('i', '<left>', [[<nop>]], { silent = true })
map('i', '<up>', [[<nop>]], { silent = true })
map('i', '<down>', [[<nop>]], { silent = true })
map('i', '<right>', [[<nop>]], { silent = true })
map('i', '<DEL>', [[<nop>]], { silent = true })

-- Wrapped lines goes down/up to next row, rather than next line in file.
map('n', 'j', [[gj]], { silent = true })
map('n', 'k', [[gk]], { silent = true })

-- Find merge conflict markers
map('n', 'gm', [[/\v^[<\|=>]{7}( .*\|$)<CR>]], { silent = false })

-- Rebind the old H and L key to zh, zl
map('n', 'zh', [[H]], { silent = true })
map('n', 'zm', [[M]], { silent = true })
map('n', 'zl', [[L]], { silent = true })

-- Repurpose the H and L keys to quickly switch buffers
map('n', 'H', [[:bp<CR>]], { silent = true })
map('n', 'L', [[:bn<CR>]], { silent = true })

map('n', 'zgg', [[:normal 100000000zk<CR>]], { silent = true })
map('n', 'zG', [[:normal  100000000zj<CR>]], { silent = true })

-- auto-center on specific movement keys, and blink current search match
map('n', 'G', [[Gzz]], { silent = true })
map('n', 'n', [[nzz:lua require('general').hl_next(100)<cr>]], { silent = true })
map('n', 'N', [[Nzz:lua require('general').hl_next(100)<cr>]], { silent = true })
map('n', '}', [[}zz]], { silent = true })
map('n', '{', [[{zz]], { silent = true })

map('n', '<C-c>', '<C-c>', { silent = true, noremap = true })

-- Save the current buffer
map('n', '<leader>fs', ':w<CR>', { silent = true })

-- Open vimrc with <leader>fed
map('n', '<leader>fed', ':e $MYVIMRC<CR>', { silent = true })

-- Reload vimrc with <leader>feR
map('n', '<leader>feR', ':luafile $MYVIMRC<CR>', { silent = true })

-- Save file with sudo
vim.keymap.set('c', 'w!!', 'w !sudo tee % > /dev/null', {
  noremap = true,
  silent = false,
  desc = 'Write with sudo',
})

-- Copy current file path + line number to system clipboard
map('n', '<leader>fC', [[:let @+=expand("%") . ":" . line(".")<CR>]], { silent = true })

return {}
