require 'util'

local api = vim.api
local home = os.getenv("HOME")
local pwd = os.getenv("PWD")

-- SETTINGS: General {{{
   local core_options = {
      path = pwd .. ',' .. pwd .. '/**';                       -- Make :find more usable by default
      wildmenu = true;                                         -- Show all matches when tab completing
      wildmode= 'longest:list,full';                           -- Show longest match first
      regexpengine = 1;                                        -- Better for ruby (https://tinyurl.com/ll948jk)
      noswapfile = true;                                       -- Disable swap (https://tinyurl.com/y9t8frrs)
      showmode = true;                                         -- show mode in bottom-left corner
      synmaxcol = 200;                                         -- Only syntax highlight 200 chars (performance)
      autowrite = true;                                        -- Write before running commands.
      shortmess = 'aAIsTF';                                    -- Reduce |hit-enter| prompts.
      cmdheight = 1;                                           -- Number of screen lines for the command-line.
      nowrap = true;                                           -- Don't wrap lines as it makes j/k unintuitive.
      smartcase = true;                                        -- Search case incensitive.
      -- textwidth=100                                         -- Set maximum number of characters per line
      -- Changes the effect of the |:mksession| cmd.
      sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,resize,globals';
      -- colorcolumn=+1                                           -- Highlight first column after 'textwidth'
      -- iskeyword-=_                                             -- Treat underscore as a word boundary.
      spellfile= home .. '/.config/nvim/spell/en.utf-8.add';
      nolist = true;
      listchars = {                                            -- Strings in 'list' mode.
        'trail:-',
        'extends:»',
        'precedes:«',
        'space:·',
        'nbsp:·',
        'eol:¬'
      };
      hidden = true;                                           -- Allow for more then one unsaved buffer.
      -- nolazyredraw                                             -- Disable lazy redraw due to issues neovim#6366
      lazyredraw = true;                                       -- Don't unnecessarily redraw screen.

      undofile = true;                                         -- Save undo's after file closes.
      undolevels = 1000;                                       -- Number of changes to be saved.

      tabstop = 2;                                             -- Number of spaces a <Tab> char is rendered as.
      shiftwidth = 2;                                          -- Number of spaces that >> and << count for.
      softtabstop = 2;                                         -- Number of spaces of <Tab> while editing.
      expandtab = true;                                        -- Use spaces instead of <Tab> for indentation.
      number = true;                                           -- Enable line numbers
      relativenumber = true;                                   -- Make line numbers relative
      numberwidth = 4;                                         -- Set width of number column
      splitbelow = true;                                       -- Open new split panes at bottommost position
      splitright = true;                                       -- Open new split panes at rightmost position
      inccommand = 'nosplit';                                  -- Show visual indication when using substitute.
      foldenable = true;                                       -- collapse all folds.
      foldmethod = 'syntax';                                   -- Fold on the syntax
      foldcolumn = 0;                                          -- Don't indicate fold open/closed
      foldlevel = 1;                                           -- Autofold nothing by default
      foldnestmax = 3;                                         -- Only fold outer functions

      modeline = true;                                         -- load vim settings from magic file comment
      confirm = true;                                          -- Makes operations like qa ask for confirmation
      scrolloff = 2;                                           -- Keep at least 2 lines above/below
      sidescrolloff = 5;                                       -- Keep at least 5 lines left/right
      smartindent = true;
   }

   setOptions(core_options)

   -- Globals
   vim.g.snappy_dev = 1
   vim.g.lumiere_dim_inactive_windows = 1
-- }}}

-- vim: foldmethod=marker:sw=2:foldlevel=10
