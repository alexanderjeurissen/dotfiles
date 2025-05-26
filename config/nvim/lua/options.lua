local vim = vim or {}

-- Meta accessors for vim options
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local k = vim.keycode

local home = os.getenv("HOME")
local pwd = os.getenv("PWD")

-- OPTIONS: Editor
o.path = pwd .. ',' .. pwd .. '/**'
-- Make :find more usable by default
o.wildmenu = true
-- Show all matches when tab completing
o.wildmode = 'longest:list,full'
-- Show longest match first
o.regexpengine = 0
-- Better for ruby
o.swapfile = false
-- Disable swap
o.showmode = true
-- show mode in bottom-left corner
o.synmaxcol = 200
-- Only syntax highlight 200 chars (performance)
o.autowrite = true
-- Write before running commands.
o.shortmess = 'aAIsTF'
-- Reduce |hit-enter| prompts.
o.cmdheight = 1
-- Number of screen lines for the command-line.
o.smartcase = true
-- Search case insensitive.
-- o.textwidth = 100 -- Set maximum number of characters per line
o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,resize,globals"
-- Changes the effect of the |:mksession| cmd.
o.spellfile = home .. '/.config/nvim/spell/en.utf-8.add'
o.listchars = "tab:▸ ,trail:-,extends:»,precedes:«,space:·,nbsp:·,eol:¬"
-- Strings in 'list' mode.
o.hidden = true
-- Allow for more then one unsaved buffer.
o.undofile = true
-- Save undo's after file closes.
o.undolevels = 1000
-- Number of changes to be saved.
o.tabstop = 2
-- Number of spaces a <Tab> char is rendered as.
o.shiftwidth = 2
-- Number of spaces that >> and << count for.
o.softtabstop = 2
-- Number of spaces of <Tab> while editing.
o.expandtab = true
-- Use spaces instead of <Tab> for indentation.
o.splitbelow = true
-- Open new split panes at bottommost position
o.splitright = true
-- Open new split panes at rightmost position
-- NOTE: commented out as this can conflict with Noice
o.lazyredraw = true
-- Don't redraw while executing macros.
o.inccommand = 'nosplit'
-- Show visual indication when using substitute.
o.modeline = true
-- load vim settings from magic file comment
o.confirm = true
-- Makes operations like qa ask for confirmation
o.scrolloff = 2
-- Keep at least 2 lines above/below
o.sidescrolloff = 5
-- Keep at least 5 lines left/right
o.smartindent = true
o.updatetime = 1000
-- if idle for updatetime write swap and trigger CursorHold
--[[ o.statusline = o.statusline .. "%="
o.statusline = o.statusline .. "%{&paste?'  ':''}"
o.statusline = o.statusline .. "%{&spell?' ¶ ':''}" ]]

o.laststatus = 2
-- Disable/enable bottom statusline
o.syntax = 'on'

o.shell = "/bin/sh" -- Set shell to bin/sh to improve performance in zsh
o.termguicolors = true
o.background = 'dark'

-- OPTIONS: Window
wo.wrap = false -- Don't wrap lines as it makes j/k unintuitive.
wo.list = false
-- wo.colorcolumn = +1 -- Highlight first column after 'textwidth'
wo.number = true -- Enable line numbers
wo.relativenumber = true -- Make line numbers relative
wo.numberwidth = 4 -- Set width of number column
wo.foldenable = true -- collapse all folds.
wo.foldcolumn = '0' -- Don't indicate fold open/closed
wo.foldlevel = 99 -- Using ufo provider need a large value
o.foldlevelstart = 99 -- Sets 'foldlevel' when starting to edit another buffer in a window. (99) means no folds are closed at start
wo.foldnestmax = 3 -- Only fold outer functions

if wo.diff == true then -- Set diff mode specific window options
  wo.list = false
  wo.cursorcolumn = false
  wo.cursorline = false
  wo.conceallevel = 0
  wo.colorcolumn = '0'
end

vim.cmd.colorscheme "modus_operandi"

return {}
