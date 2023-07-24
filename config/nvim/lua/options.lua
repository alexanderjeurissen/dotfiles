-- Meta accessors for vim options {{{
  local o = vim.o
  local bo = vim.bo
  local wo = vim.wo
  local fn = vim.fn
-- }}}

local home = os.getenv("HOME") local home = os.getenv("HOME")
local pwd = os.getenv("PWD")

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

function _G.errorMsg(str)
  vim.api.nvim_command('echohl ErrorMsg | echo "' .. str .. '" | echohl None')
end

-- OPTIONS: Editor {{{
  o.path = pwd .. ',' .. pwd .. '/**'                                                   -- Make :find more usable by default
  o.wildmenu = true                                                                     -- Show all matches when tab completing
  o.wildmode= 'longest:list,full'                                                       -- Show longest match first
  o.regexpengine = 0                                                                    -- Better for ruby (https://tinyurl.com/ll948jk)
  o.swapfile = false                                                                    -- Disable swap (https://tinyurl.com/y9t8frrs)
  o.showmode = true                                                                     -- show mode in bottom-left corner
  o.synmaxcol = 200                                                                     -- Only syntax highlight 200 chars (performance)
  o.autowrite = true                                                                    -- Write before running commands.
  o.shortmess = 'aAIsTF'                                                                -- Reduce |hit-enter| prompts.
  o.cmdheight = 1                                                                       -- Number of screen lines for the command-line.
  o.smartcase = true                                                                    -- Search case incensitive.
  -- o.textwidth = 100                                                                     -- Set maximum number of characters per line
  o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,resize,globals"  -- Changes the effect of the |:mksession| cmd.
  o.spellfile = home .. '/.config/nvim/spell/en.utf-8.add'
  o.listchars = "trail:-,extends:»,precedes:«,space:·,nbsp:·,eol:¬"                     -- Strings in 'list' mode.
  o.hidden = true                                                                       -- Allow for more then one unsaved buffer.
  o.lazyredraw = true                                                                   -- Don't unnecessarily redraw screen.
  o.undofile = true                                                                     -- Save undo's after file closes.
  o.undolevels = 1000                                                                   -- Number of changes to be saved.
  o.tabstop = 2                                                                         -- Number of spaces a <Tab> char is rendered as.
  o.shiftwidth = 2                                                                      -- Number of spaces that >> and << count for.
  o.softtabstop = 2                                                                     -- Number of spaces of <Tab> while editing.
  o.expandtab = true                                                                    -- Use spaces instead of <Tab> for indentation.
  o.splitbelow = true                                                                   -- Open new split panes at bottommost position
  o.splitright = true                                                                   -- Open new split panes at rightmost position
  o.inccommand = 'nosplit'                                                              -- Show visual indication when using substitute.
  o.modeline = true                                                                     -- load vim settings from magic file comment
  o.confirm = true                                                                      -- Makes operations like qa ask for confirmation
  o.scrolloff = 2                                                                       -- Keep at least 2 lines above/below
  o.sidescrolloff = 5                                                                   -- Keep at least 5 lines left/right
  o.smartindent = true

  o.winbar = " "
  o.winbar = o.winbar .. "%{winnr() > 9?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 1?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 2?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 3?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 4?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 5?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 6?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 7?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 8?' ':''}"
  o.winbar = o.winbar .. "%{winnr() == 9?' ':''}"
  o.winbar = o.winbar .. " %{expand('%:~:.')} "
  o.winbar = o.winbar .. "%="
  o.winbar = o.winbar .. "%{&modified?' ':''}"
  o.winbar = o.winbar .. "%{&readonly?' ':''}"
  o.winbar = o.winbar .. "%{&paste?'  ':''}"
  o.winbar = o.winbar .. "%{&spell?' ¶ ':''}"
  o.winbar = o.winbar .. "%P "

  o.laststatus = 3                                                                      -- Disable/enable bottom statusline

  --[[ 
  
            ]]

  -- o.shell = "/usr/local/bin/fish"                                                                   -- Set shell to bin/sh to improve performance in zsh/fish
  o.shell = "/bin/sh"                                                                   -- Set shell to bin/sh to improve performance in zsh/fish
  o.termguicolors = true

  if fn.executable('rg') == 1 then
    o.grepprg = "rg --vimgrep -H --no-heading --column --smart-case -P"                                          -- Set RipGrep as the default grep program (if it exists)
    o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  end
-- }}}

-- OPTIONS: Window {{{
  wo.wrap = false                                                                       -- Don't wrap lines as it makes j/k unintuitive.
  wo.list = false

  -- wo.colorcolumn = +1                                                                    -- Highlight first column after 'textwidth'

  wo.number = true                                                                      -- Enable line numbers
  wo.relativenumber = true                                                              -- Make line numbers relative
  wo.numberwidth = 4                                                                    -- Set width of number column

  wo.foldenable = true                                                                  -- collapse all folds.
  wo.foldmethod = 'syntax'                                                              -- Fold on the syntax
  wo.foldcolumn = '0'                                                                   -- Don't indicate fold open/closed
  wo.foldlevel = 1                                                                      -- Autofold nothing by default
  wo.foldnestmax = 3                                                                    -- Only fold outer functions


  if wo.diff == true then                                                               -- Set diff mode specific window options
    wo.list = false
    wo.cursorcolumn = false
    wo.cursorline = false
    wo.conceallevel = 0
    wo.colorcolumn = '0'

    vim.call('general#MarkMargin', 0)
  end
-- }}}

-- VARIABLES: global {{{
   vim.g.snappy_dev = 1
   vim.g.python_host_prog = "python3"

   vim.g.dein_path = '$HOME/.config/nvim/dein'
   vim.api.nvim_set_var('dein#auto_recache', 1)

   -- vim.g.lumiere_dim_inactive_windows = 0

   vim.g.netrw_browsex_viewer = "open -a '/Applications/Google Chrome.app'"             -- ensure gx opens the url under cursor
   vim.g.netrw_keepdir = 0

   vim.g.mapleader = "<Space>" -- Set mapleader to <space>
-- }}}

-- SETUP: source config still written in vimscript {{{
  vim.cmd('source ' .. home .. '/.config/nvim/vim/keybindings.vim')
-- }}}

-- PLUGIN: b3nj5m1n / kommentary {{{
  vim.g.kommentary_create_default_mappings = false
  vim.keymap.set("n", "gcc", "<Plug>kommentary_line_default")
  vim.keymap.set("n", "gc", "<Plug>kommentary_motion_default")
  vim.keymap.set("v", "gc", "<Plug>kommentary_visual_default<C-c>")
-- }}}
