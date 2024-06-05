-- Telescope requires

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

require('telescope').setup{
  pickers = {
    git_files = {
      theme = 'ivy',
      layout_config = { height = 10 }
    },
    find_files = {
      theme = 'ivy',
      layout_config = { height = 10 }
    },
    buffers = {
      theme = 'ivy',
      layout_config = { height = 10 }
    },
    live_grep = {
      theme = 'ivy',
      preview = { hide_on_startup = false }
    }
  },
  defaults = {
    preview = {
      hide_on_startup = true -- hide previewer when picker starts
    },
    mappings = {
      i = {
        -- close in insert mode
        ['<esc>'] = actions.close,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<C-a>"] = actions.toggle_all,
        ["<C-o>"] = actions.send_selected_to_loclist + actions.open_loclist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
      },
      n = {
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<C-a>"] = actions.toggle_all,
        ["<C-o>"] = actions.send_selected_to_loclist + actions.open_loclist,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
      }
    },
    selection_caret = '❯ ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}

-- Load the fzy native extension
require('telescope').load_extension('fzy_native')

-- Files bindings {{{
-- Open general Telescope picker
vim.api.nvim_set_keymap('n', '<leader>tl', "<cmd>Telescope<CR>", { noremap = true, silent = true })
-- Find files in the current project (similar to FZF's project_files)
vim.api.nvim_set_keymap('n', '<leader>pf', "<cmd>lua require('telescope.builtin').git_files()<CR>", { noremap = true, silent = true })

-- Live grep in the project
vim.api.nvim_set_keymap('n', '<leader>p/', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })

-- Find files using the file browser
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
-- }}}

-- Buffer bindings {{{
-- List open buffers
vim.api.nvim_set_keymap('n', '<leader>bb', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gb', "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
-- }}}

-- Git bindings {{{
-- List files changed in current branch
vim.api.nvim_set_keymap('n', '<leader>gF', "<cmd>lua require('telescope.builtin').git_files()<CR>", { noremap = true, silent = true })

-- List git diffs for current file
vim.api.nvim_set_keymap('n', '<leader>gf', "<cmd>lua require('telescope.builtin').git_status()<CR>", { noremap = true, silent = true })
-- }}}
