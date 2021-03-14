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

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- PLUGINS: Colorschemes {{{
    use 'tsiemens/vim-aftercolors'
    use { 'romainl/flattened', config = function() require 'plugins/romainl-flattened' end}
    use { 'npxbr/gruvbox.nvim', requires = {{'rktjmp/lush.nvim'}}, config = function() require 'plugins/npxbr-gruvbox-nvim' end}
  -- }}}

  -- PLUGINS: Core {{{
    use 'Konfekt/FastFold'

    use 'vim-scripts/searchfold.vim'

    -- NOTE: run tasks in a tmux split to not block vim
    use {
      'tpope/vim-dispatch',
      opt = true,
      cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }

    -- NOTE: Treesitter configurations and abstraction layer for Neovim (highlights).
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- merged = 0

    -- NOTE: A vim plugin for making vim plugins
    use 'tpope/vim-scriptease'

    use { 'tjdevries/express_line.nvim', requires= {{ 'nvim-lua/plenary.nvim' }}, config = function() require 'plugins/tjdevries-express-line-nvim' end }

    -- NOTE: Tmux navigation keybindings
    use {
      'christoomey/vim-tmux-navigator',
      config = function() require 'plugins/christoomey-vim-tmux-navigator' end
    }

    -- use { 'hkupty/nvimux', config = function() require 'plugins/nvimux' end }
  -- }}}

  -- PLUGINS: Editing {{{
    -- NOTE: better search and replace
    use { 'tpope/vim-abolish', opt = true, cmd = {'Abolish', 'Subvert'} }

    -- NOTE: insert end after certain keywords in ruby
    use 'tpope/vim-endwise'

    -- NOTE: Easy commenting using vim motions
    -- use { 'tpope/vim-commentary', disabled=true }
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
    use '~/Development/open-source/qedit.nvim'
  -- }}}

  -- PLUGINS: Frontend/Javascript {{{
    -- NOTE: yank visual selections
    use { 'ap/vim-css-color', ft = {'css', 'scss', 'conf', 'javascript'} }

    -- NOTE: semantic highlighting for javascript
    -- use { 'billyvg/tigris.nvim', ft = {'javascript', 'html.javascript'} }
  -- }}}

  -- PLUGINS: Ruby {{{
    -- NOTE: run bundler commands in Vim
    use 'tpope/vim-bundler'

    -- NOTE: fancy cucumber highlighting
    use { 'tpope/vim-cucumber', ft = {'cucumber'} }

    -- NOTE: cucumber folding pattern
    use 'greggroth/vim-cucumber-folding'
    on_ft = 'cucumber'

    -- NOTE: rails specific config and highlight
    -- use { 'tpope/vim-rails', opt = true, ft = {'ruby', 'cucumber'} }
  -- }}}

  -- PLUGINS: Navigation {{{
    -- NOTE: ...
    use 'octref/RootIgnore'

    -- NOTE: Fuzzy finder / selector
    use { 'junegunn/fzf', run = './install --all' }
    use { 'vijaymarupudi/nvim-fzf', config=function() require 'plugins/fzf' end}

    -- NOTE: Ido packages and runtime
    use '~/Development/open-source/ido-nvim/files'
    use { '~/Development/open-source/ido-nvim/core', config = function() require 'plugins/ido' end }


    -- NOTE: add nice buffer deleting
    use {
      'moll/vim-bbye',
      config = function() require 'plugins/moll-vim-bbye' end
    }

    -- NOTE: rails specific config and highlight
    use 'arithran/vim-delete-hidden-buffers'

    -- NOTE: File browser
    use 'tpope/vim-vinegar'

    -- NOTE: ...
    use 'tpope/vim-eunuch'

    -- NOTE: Tab rename utilities
    -- use 'gcmt/taboo.vim'

    -- NOTE: change vim root to vcs root when editing a file
    use {
      'airblade/vim-rooter',
      config = function() require 'plugins/airblade-vim-rooter' end
    }

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
    use {
      'szw/vim-maximizer',
      config = function() require 'plugins/szw-vim-maximizer' end
    }
  -- }}}
end)

-- vim: foldmethod=marker:sw=2:foldlevel=10
