-- Vim API shortcuts {{{
  local vim = vim or {}
-- }}}

-- INSTALL lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}

return require('lazy').setup({
  -- Plugin Defaults
  defaults = {
    lazy = true,  -- Default to lazy-loading
  },

  -- Core Functionality
  'Konfekt/FastFold',
  'vim-scripts/searchfold.vim',
  {'neovim/nvim-lspconfig', event = "BufReadPre", config = function() require 'plugins/neovim-nvim-lspconfig' end},
  {'nvim-treesitter/nvim-treesitter', event = "BufRead", run = ':TSUpdate', config = function() require 'plugins/nvim-treesitter-nvim-treesitter' end},
  {'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim', event = "VimEnter", config = function() require 'plugins/telescope' end},
  {'nvim-telescope/telescope-fzy-native.nvim', run = 'make', event = "CmdLineEnter"},
  -- { 'joaomsa/telescope-orgmode.nvim', event
  { 'nvim-orgmode/orgmode', event = 'VeryLazy', ft = { 'org' }, config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '/Users/alexander/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/**/*',
        org_default_notes_file = '/Users/alexander/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/inbox.org',
        mappings = {
          global = {
            org_agenda = gA,
            org_capture = 'gC'
          },
        }
    })
   end,
  },
  -- Colorschemes and Appearance
  'tsiemens/vim-aftercolors',
  -- {'craftzdog/solarized-osaka.nvim', event = "ColorScheme", config = function() require 'plugins/craftzdog-solarized-osaka' end},
  {'miikanissi/modus-themes.nvim', event = "ColorScheme", config = function() require 'plugins/miikanissi-modus-themes-nvim' end },
  { 'sainnhe/gruvbox-material', event = "ColorScheme" },
  { 'nyoom-engineering/oxocarbon.nvim', event = "ColorScheme" },

  -- Autocompletion and Snippets
  {'ms-jpq/coq_nvim', branch = "coq", event = "InsertEnter", config = function() require 'plugins/ms-jpq-coq_nvim' end},

  -- Navigation and File Management
  'SmiteshP/nvim-navic',
  'octref/RootIgnore',
  {'moll/vim-bbye', cmd = 'Bdelete', config = function() require 'plugins/moll-vim-bbye' end},
  'arithran/vim-delete-hidden-buffers',
  'tpope/vim-vinegar',
  {'airblade/vim-rooter', event = "BufRead", config = function() require 'plugins/airblade-vim-rooter' end},
  'tpope/vim-unimpaired',
  {'thinca/vim-visualstar', keys = {'visual', '*'}},

  -- Text Editing Enhancements
  {'tpope/vim-abolish', cmd = {'Abolish', 'Subvert'}, config = function() require 'plugins/tpope-vim-abolish' end},
  'tpope/vim-endwise',
  'b3nj5m1n/kommentary',
  'bogado/file-line',
  'tommcdo/vim-exchange',
  'tpope/vim-repeat',
  {'tpope/vim-surround', dependencies = {{'tpope/vim-repeat'}}, keys = {'visual', 's'}, config = function() require 'plugins/tpope-vim-surround' end},
  'tpope/vim-sleuth',
  'machakann/vim-highlightedyank',
  {'ap/vim-css-color', ft = {'css', 'scss', 'html'}, config = function() require 'plugins/vim-css-color' end},
  { "folke/todo-comments.nvim", event = "BufRead", dependencies = { "nvim-lua/plenary.nvim" }, opts = { } },

  -- Development Tools and Integrations
  {'github/copilot.vim', cmd = "Copilot", config = function() require 'plugins/github-copilot-vim' end},
  {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}, config = function() require 'plugins/tpope-vim-dispatch' end},
  {'christoomey/vim-tmux-navigator', event = "VimEnter", config = function() require 'plugins/christoomey-vim-tmux-navigator' end},

  -- Version Control Systems
  'sgeb/vim-diff-fold',
  'tpope/vim-fugitive',
  'tpope/vim-git',

  -- Language-Specific Enhancements
  {'norcalli/nvim-colorizer.lua', ft = {'css', 'scss', 'conf', 'javascript', 'lua'}},
  {'tpope/vim-cucumber', ft = {'cucumber'}, config = function() require 'plugins/tpope-vim-cucumber' end},
  {'greggroth/vim-cucumber-folding', ft={'cucumber'}, config = function() require 'plugins/greggroth-vim-cucumber-folding' end},

  -- Window and Buffer Management
  {'szw/vim-maximizer', cmd = "MaximizerToggle", config = function() require 'plugins/szw-vim-maximizer' end},
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "BufReadPre",
    config = function() require 'plugins/akinsho-bufferline-nvim' end
  },
}, {
 install = {
      missing = false
 }
})

-- vim: foldmethod=marker:sw=2:foldlevel=10
