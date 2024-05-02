-- Vim API shortcuts {{{
  local vim = vim or {}
  local api = vim.api
  local fn = vim.fn
  local cmd = api.nvim_command
-- }}}

-- INSTALL packer {{{
  local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  end
-- }}}

-- NOTE: Load Packer (only applicable if packer is in opt/ path)
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- PLUGINS: Core {{{
    use 'Konfekt/FastFold'
    use 'vim-scripts/searchfold.vim'

    -- NOTE: LSP & TreeSitter {{{
    use { 'neovim/nvim-lspconfig', config = function() require 'plugins/neovim-nvim-lspconfig' end }
    use { 'SmiteshP/nvim-navic', config = function() require 'plugins/SmiteshP-nvim-navic' end }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require 'plugins/nvim-treesitter-nvim-treesitter' end }
    use { 'nvim-telescope/telescope.nvim',
          requires = 'nvim-lua/plenary.nvim',
          config = function() require 'plugins/telescope' end }
    -- fzy native sorter for Telescope
    use {
      'nvim-telescope/telescope-fzy-native.nvim',
      run = 'make'  -- This compiles the native fzy module
    }
    -- }}}

    -- NOTE: Autocompletion
    use { 'ms-jpq/coq_nvim', branch = "coq", config = function() require 'plugins/ms-jpq-coq_nvim' end }
    -- NOTE: not working atm
    -- use { 'https://codeberg.org/esensar/nvim-dev-container',config = function() require("devcontainer").setup{} end }

    -- NOTE: run tasks in a tmux split to not block vim
    use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'} }

    -- NOTE: Tmux navigation keybindings
    use { 'christoomey/vim-tmux-navigator',
      config = function() require 'plugins/christoomey-vim-tmux-navigator' end
    }

    -- NOTE: Github Copilot
    use { 'github/copilot.vim' , config = function() require 'plugins/github-copilot-vim' end }
  -- }}}

  -- PLUGINS: Colorschemes {{{
    use 'tsiemens/vim-aftercolors'
    -- use { 'ishan9299/nvim-solarized-lua', config = function() require 'plugins/ishan9299-nvim-solarized-lua' end }
    -- use { "miikanissi/modus-themes.nvim", config = function() require 'plugins/miikanissi-modus-themes' end }
    use { 'craftzdog/solarized-osaka.nvim', config = function() require 'plugins/craftzdog-solarized-osaka' end }
    -- use { 'rose-pine/neovim', config = function() require 'plugins/rose-pine-neovim' end }
  -- }}}

  -- PLUGINS: Editing {{{
    -- NOTE: better search and replace
    use { 'tpope/vim-abolish', opt = true, cmd = {'Abolish', 'Subvert'} }

    -- NOTE: insert end after certain keywords in ruby
    use 'tpope/vim-endwise'

    -- NOTE: Easy commenting using vim motions
    use 'b3nj5m1n/kommentary'

    -- NOTE: allow opening files with line number e.g. file.txt:30
    use 'bogado/file-line'

    -- NOTE: ...
    use 'tommcdo/vim-exchange'

    -- NOTE: ...
    use 'tpope/vim-repeat'

    -- NOTE: ...
    use { 'tpope/vim-surround', requires = {{ 'tpope/vim-repeat' }} }

    -- NOTE: smart indent width based on buffer and neigbouring files
    use 'tpope/vim-sleuth'

    -- NOTE: yank visual selections
    use 'machakann/vim-highlightedyank'

    -- NOTE: Enables editing quickfix buffer
    -- use '~/Development/open-source/qedit.nvim'
  -- }}}

  -- PLUGINS: Frontend/Javascript {{{
    -- NOTE: ...
    use { 'norcalli/nvim-colorizer.lua', ft = {'css', 'scss', 'conf', 'javascript', 'lua'} }
  -- }}}

  -- PLUGINS: Ruby {{{
    -- NOTE: fancy cucumber highlighting
    use { 'tpope/vim-cucumber', ft = {'cucumber'} }

    -- NOTE: cucumber folding pattern
    use { 'greggroth/vim-cucumber-folding', ft={'cucumber'} }
  -- }}}

  -- PLUGINS: Navigation {{{
    -- NOTE: ...
    use 'octref/RootIgnore'

    -- NOTE: add nice buffer deleting
    use { 'moll/vim-bbye', config = function() require 'plugins/moll-vim-bbye' end }

    use 'arithran/vim-delete-hidden-buffers'

    -- NOTE: File browser
    use 'tpope/vim-vinegar'

    -- NOTE: change vim root to vcs root when editing a file
    use { 'airblade/vim-rooter', config = function() require 'plugins/airblade-vim-rooter' end }

    -- NOTE: pairs of handy bracket mappings like [f and ]f for file switching
    use 'tpope/vim-unimpaired'

    -- NOTE: allows to use the * motion in visual mode
    use { 'thinca/vim-visualstar', keys = { 'visual', '*' } }
  -- }}}

  -- PLUGINS: Version Control {{{
    -- NOTE: allows to fold vim diffs
    use 'sgeb/vim-diff-fold'

    -- NOTE: adds git commands for checking git status, commit etc.
    use 'tpope/vim-fugitive'

    -- NOTE: Vim runtime files and syntax highlighting
    use 'tpope/vim-git'
  -- }}}

  -- PLUGINS: Window Management {{{
    -- NOTE: allows to zoom into splits
    use { 'szw/vim-maximizer', config = function() require 'plugins/szw-vim-maximizer' end }

    -- NOTE: tab/bufline support with file icons
    use {
      'akinsho/bufferline.nvim',
      tag = "*",
      requires = 'nvim-tree/nvim-web-devicons',
      config = function() require 'plugins/akinsho-bufferline-nvim' end
    }
  -- }}}
end)

-- vim: foldmethod=marker:sw=2:foldlevel=10
