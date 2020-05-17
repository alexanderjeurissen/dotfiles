local Init = {}

function Init.init()
  local Util = require 'util'
  local home = os.getenv("HOME")
  local pwd = os.getenv("PWD")

  local set = Util.set

  -- SETTINGS: General {{{
    set { path = pwd .. ',' .. pwd .. '/**' }                       -- Make :find more usable by default
    set { wildmenu = true }                                         -- Show all matches when tab completing
    set { wildmode= 'longest:list,full' }                           -- Show longest match first
    set { regexpengine = 0 }                                        -- Better for ruby (https://tinyurl.com/ll948jk)
    set { noswapfile = true }                                       -- Disable swap (https://tinyurl.com/y9t8frrs)
    set { showmode = true }                                         -- show mode in bottom-left corner
    set { synmaxcol = 200 }                                         -- Only syntax highlight 200 chars (performance)
    set { autowrite = true }                                        -- Write before running commands.
    set { shortmess = 'aAIsTF' }                                    -- Reduce |hit-enter| prompts.
    set { cmdheight = 1 }                                           -- Number of screen lines for the command-line.
    set { nowrap = true }                                           -- Don't wrap lines as it makes j/k unintuitive.
    set { smartcase = true }                                        -- Search case incensitive.
    -- set { textwidth = 100 }                                         -- Set maximum number of characters per line
    set {
      sessionoptions = {                                                  -- Changes the effect of the |:mksession| cmd.
        'blank',
        'buffers',
        'curdir',
        'folds',
        'help',
        'tabpages',
        'winsize',
        'resize',
        'globals'
      }
    }
    -- set { colorcolumn = +1 }                                        -- Highlight first column after 'textwidth'
    set { spellfile= home .. '/.config/nvim/spell/en.utf-8.add' }
    set { nolist = true }
    set {
      listchars = {                                                       -- Strings in 'list' mode.
        'trail:-',
        'extends:»',
        'precedes:«',
        'space:·',
        'nbsp:·',
        'eol:¬'
      }
    }
    set { hidden = true }                                           -- Allow for more then one unsaved buffer.
    -- set { nolazyredraw = true }                                     -- Disable lazy redraw due to issues neovim#6366
    set { lazyredraw = true }                                       -- Don't unnecessarily redraw screen.

    set { undofile = true }                                         -- Save undo's after file closes.
    set { undolevels = 1000 }                                       -- Number of changes to be saved.

    set { tabstop = 2 }                                             -- Number of spaces a <Tab> char is rendered as.
    set { shiftwidth = 2 }                                          -- Number of spaces that >> and << count for.
    set { softtabstop = 2 }                                         -- Number of spaces of <Tab> while editing.
    set { expandtab = true }                                        -- Use spaces instead of <Tab> for indentation.
    set { number = true }                                           -- Enable line numbers
    set { relativenumber = true }                                   -- Make line numbers relative
    set { numberwidth = 4 }                                         -- Set width of number column
    set { splitbelow = true }                                       -- Open new split panes at bottommost position
    set { splitright = true }                                       -- Open new split panes at rightmost position
    set { inccommand = 'nosplit' }                                  -- Show visual indication when using substitute.
    set { foldenable = true }                                       -- collapse all folds.
    set { foldmethod = 'syntax' }                                   -- Fold on the syntax
    set { foldcolumn = 0 }                                          -- Don't indicate fold open/closed
    set { foldlevel = 1 }                                           -- Autofold nothing by default
    set { foldnestmax = 3 }                                         -- Only fold outer functions

    set { modeline = true }                                         -- load vim settings from magic file comment
    set { confirm = true }                                          -- Makes operations like qa ask for confirmation
    set { scrolloff = 2 }                                           -- Keep at least 2 lines above/below
    set { sidescrolloff = 5 }                                       -- Keep at least 5 lines left/right
    set { smartindent = true }

   -- Globals
   vim.g.snappy_dev = 1
   vim.g.lumiere_dim_inactive_windows = 0
  -- }}}

  -- SETTINGS: statusline {{{
  set { laststatus=2 }
  -- set { guioptions-=e } TODO: fix

  -- }}}
end

return Init
-- vim: foldmethod=marker:sw=2:foldlevel=10
