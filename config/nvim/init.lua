local vim = vim or {}
vim.loader.enable()
local General = require('general')

local map = vim.keymap.set

-- Options {{{
-- Meta accessors for vim options
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local fn = vim.fn
local k = vim.keycode

local home = os.getenv("HOME")
local pwd = os.getenv("PWD")

-- OPTIONS: Editor
o.path = pwd .. ',' .. pwd .. '/**'          -- Make :find more usable by default
o.wildmenu = true                            -- Show all matches when tab completing
o.wildmode = 'longest:list,full'             -- Show longest match first
o.regexpengine = 0                           -- Better for ruby (https://tinyurl.com/ll948jk)
o.swapfile = false                           -- Disable swap (https://tinyurl.com/y9t8frrs)
o.showmode = true                            -- show mode in bottom-left corner
o.synmaxcol = 200                            -- Only syntax highlight 200 chars (performance)
o.autowrite = true                           -- Write before running commands.
o.shortmess = 'aAIsTF'                       -- Reduce |hit-enter| prompts.
o.cmdheight = 1                              -- Number of screen lines for the command-line.
o.smartcase = true                           -- Search case insensitive.
-- o.textwidth = 100                         -- Set maximum number of characters per line
o.sessionoptions =
"blank,buffers,curdir,folds,help,tabpages,winsize,resize,globals"        -- Changes the effect of the |:mksession| cmd.
o.spellfile = home .. '/.config/nvim/spell/en.utf-8.add'
o.listchars = "tab:▸ ,trail:-,extends:»,precedes:«,space:·,nbsp:·,eol:¬" -- Strings in 'list' mode.
o.hidden = true                              -- Allow for more then one unsaved buffer.
o.undofile = true                            -- Save undo's after file closes.
o.undolevels = 1000                          -- Number of changes to be saved.
o.tabstop = 2                                -- Number of spaces a <Tab> char is rendered as.
o.shiftwidth = 2                             -- Number of spaces that >> and << count for.
o.softtabstop = 2                            -- Number of spaces of <Tab> while editing.
o.expandtab = true                           -- Use spaces instead of <Tab> for indentation.
o.splitbelow = true                          -- Open new split panes at bottommost position
o.splitright = true                          -- Open new split panes at rightmost position
-- NOTE: commented out as this can conflict with Noice
o.lazyredraw = true                       -- Don't redraw while executing macros.
o.inccommand = 'nosplit'                     -- Show visual indication when using substitute.
o.modeline = true                            -- load vim settings from magic file comment
o.confirm = true                             -- Makes operations like qa ask for confirmation
o.scrolloff = 2                              -- Keep at least 2 lines above/below
o.sidescrolloff = 5                          -- Keep at least 5 lines left/right
o.smartindent = true
o.updatetime = 1000                          -- if idle for updatetime write swap and trigger CursorHold

--[[ o.statusline = o.statusline .. "%="
o.statusline = o.statusline .. "%{&paste?'  ':''}"
o.statusline = o.statusline .. "%{&spell?' ¶ ':''}" ]]

o.laststatus = 2                             -- Disable/enable bottom statusline
o.syntax = 'on'

o.shell = "/bin/sh" -- Set shell to bin/sh to improve performance in zsh/fish
o.termguicolors = true
o.background = 'dark'

-- OPTIONS: Window
wo.wrap = false -- Don't wrap lines as it makes j/k unintuitive.
wo.list = false

-- wo.colorcolumn = +1                                                                    -- Highlight first column after 'textwidth'

wo.number = true         -- Enable line numbers
wo.relativenumber = true -- Make line numbers relative
wo.numberwidth = 4       -- Set width of number column

wo.foldenable = true     -- collapse all folds.
wo.foldcolumn = '0'      -- Don't indicate fold open/closed
wo.foldlevel = 99        -- Using ufo provider need a large value
o.foldlevelstart = 99    -- Sets 'foldlevel' when starting to edit another buffer in a window. (99) means no folds are closed at start
wo.foldnestmax = 3       -- Only fold outer functions


if wo.diff == true then  -- Set diff mode specific window options
  wo.list = false
  wo.cursorcolumn = false
  wo.cursorline = false
  wo.conceallevel = 0
  wo.colorcolumn = '0'
end

vim.cmd.colorscheme "modus_operandi"
-- vim.cmd.colorscheme "modus_operandi"

-- }}}
-- Abbreviations {{{
-- Fix annoying typos
vim.api.nvim_exec([[
  cnoreabbrev qw wq
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
  cnoreabbrev QA qa
  cnoreabbrev Qa qa
  cnoreabbrev W w
  cnoreabbrev WW w
  cnoreabbrev Q q

  inoreabbrev teh the
  inoreabbrev reprot report
  inoreabbrev Reprot Report
]], false)

-- }}}
-- Variables {{{
vim.g.python_host_prog = "python3"

vim.g.netrw_browsex_viewer =
"open -a '/Applications/Google Chrome.app'" -- ensure gx opens the url under cursor
vim.g.netrw_keepdir = 0

vim.g.mapleader = k'<Space>' -- Set mapleader to <space>
-- }}}


-- Keybindings {{{
map('n', 'n', [[nzz:lua require('general').hl_next(100)<cr>]], { silent = true })
map('n', 'N', [[Nzz:lua require('general').hl_next(100)<cr>]], { silent = true })

-- KEYBINDINGS: Editing {{{
-- Define the function to execute a macro over a visual selection

-- Map '@' in visual mode to the function
vim.keymap.set('x', '@', [[:<C-u>lua require('general').ExecuteMacroOverVisualRange()<CR>]], {
  noremap = true,
  silent = true,
  desc = 'Run macro over visual selection'
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
-- Hat-tip http://vimbits.com/bits/11
map('n', 'Y', [[y$]], { silent = true })

-- keep selection after indent
map('v', '<', [[<gv]], { silent = true })
map('v', '>', [[>gv]], { silent = true })

map('i', '<c-h>', [[<c-o>x]], { silent = true })

-- }}}

-- KEYBINDINGS: Navigation / Search {{{
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

-- TODO: likely not necessary if we choose to adopt
-- Hydra.nvim
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

-- KEYBINDINGS: General {{{
-- Disable arrows and BS in insert mode
map('i', '<left>', [[<nop>]], { silent = true })
map('i', '<up>', [[<nop>]], { silent = true })
map('i', '<down>', [[<nop>]], { silent = true })
map('i', '<right>', [[<nop>]], { silent = true })
-- imap('<BS>', [[<nop>]])
map('i', '<DEL>', [[<nop>]], { silent = true })

-- Wrapped lines goes down/up to next row, rather than next line in file.
map('n', 'j', [[gj]], { silent = true })
map('n', 'k', [[gk]], { silent = true })

-- Find merge conflict markers
map('n', 'gm', [[/\v^[<\|=>]{7}( .*\|$)<CR>]], { silent = false })

-- TODO: figure out if we need this
-- Commented out on 28/08/2024
-- default to very magic
-- noremap('/', [[/\v]], { silent = false })
-- noremap('?', [[?\v]], { silent = false })

-- TODO: Do we want to keep this ?
-- commenting this out to see if s and S default behavior are more beneficial
-- Repurpose the s and S key for search and replace
-- nmap('S', [[:%s//g<LEFT><LEFT>]], { silent = false })
-- vmap('s', [[:Blockwise s//g<LEFT><LEFT>]], { silent = false })

-- Rebind the old H and L keyt to zh, zl
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
  desc = 'Write with sudo'
})

-- Copy current file path + line number to system clipboard
map('n', '<leader>fC', [[:let @+=expand("%") . ":" . line(".")<CR>]], { silent = true })
-- }}}

-- Auto commands {{{
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup('ALEXANDER_GENERAL_LUA', {})

-- When editing a file, always jump to the last known cursor position.
-- Don't do it for commit messages, when the position is invalid, or when
-- inside an event handler (happens when dropping a file on gvim).
-- In addition open folds till the cursor is visible
autocmd('BufReadPost', {
  callback = function()
    local line = vim.fn.line

    if vim.bo.filetype == 'gitcommit' then return end
    if line("'\"") <= 0 then return end
    if line("'\"") > line('$') then return end

    vim.cmd("normal g`\"")
    vim.cmd('normal zv')
  end,
  group = general
})

-- Set syntax highlighting for Appraisals
vim.filetype.add({ filename = { Appraisals = 'ruby' } })

-- Function to delete hidden buffers
autocmd('BufLeave', {
  pattern = '*',
  callback = function()
    local buffers = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), function(_, val)
      return vim.fn.buflisted(val) == 1 and vim.fn.bufwinnr(val) == -1 and vim.fn.getbufvar(val, "&modified") == 0 and
      vim.fn.empty(vim.fn.bufname(val)) == 1
    end)
    for _, buf in ipairs(buffers) do
      vim.cmd('bdelete ' .. buf)
    end
  end,
  group = general
})

-- Automatically remove trailing whitespaces unless file is blacklisted
autocmd('BufWritePre', {
  callback = function()
    General.Preserve(function() vim.cmd("%s/\\s\\+$//e") end)
  end,
  group = general
})

-- Ensure directory structure exists when opening a new file
autocmd('BufNewFile', {
  callback = function() General.EnsureDirExists() end,
  group = general
})

-- NOTE: open quickfix/location list window after it's populated
-- ref: https://www.reddit.com/r/vim/comments/bmh977/automatically_open_quickfix_window_after/
local qf_group = augroup('ALEXANDER_QF', {})
autocmd('QuickFixCmdPost', {
  pattern = '[^l]*',
  command = 'cwindow',
  group = qf_group
})

autocmd('QuickFixCmdPost', {
  pattern = 'l*',
  command = 'lwindow',
  group = qf_group
})
-- }}}

if vim.g.vscode then
    -- VSCode extension
else
  -- PLUGINS {{{
  local rocks_config = {
    rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
    luarocks_config = {
      arch = "macosx-aarch64", -- or arch = "macosx-x86_64" , depending on your architecture
    },
  }

  vim.g.rocks_nvim = rocks_config

  local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
  }
  package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

  local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    -- Remove the dylib and dll paths if you do not need macos or windows support
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
  }
  package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

  vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
  -- }}}
end

-- vim: foldmethod=marker:sw=2:foldlevel=10
