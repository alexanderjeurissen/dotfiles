-- Telescope requires
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

require('telescope').setup{
  pickers = {
    -- FIXME: This picker is somehow not recognized so we hardcoded it in the keybinding which is suboptimal
    marks = {
      layout_config = { height = 30, width = 100 },
    },
    projects = {
      layout_config = { height = 30, width = 100 },
    },
    git_files = {
      layout_config = { height = 30, width = 100 },
    },
    find_files = {
      layout_config = { height = 30, width = 100 },
    },
    buffers = {
      layout_config = { height = 30, width = 100 },
    },
    live_grep = {
      layout_config = { height = 30, width = 200 },
      preview = { hide_on_startup = false },
      debounce = 100
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
    ["zf-native"] = {
          -- options for sorting file-like items
          file = {
              -- override default telescope file sorter
              enable = true,

              -- highlight matching text in results
              highlight_results = true,

              -- enable zf filename match priority
              match_filename = true,

              -- optional function to define a sort order when the query is empty
              initial_sort = nil,

              -- set to false to enable case sensitive matching
              smart_case = true,
          },

          -- options for sorting all other items
          generic = {
              -- override default telescope generic item sorter
              enable = true,

              -- highlight matching text in results
              highlight_results = true,

              -- disable zf filename match priority
              match_filename = false,

              -- optional function to define a sort order when the query is empty
              initial_sort = nil,

              -- set to false to enable case sensitive matching
              smart_case = true,
          },
      }
  }
}

-- Files bindings {{{
-- Open general Telescope picker
vim.keymap.set('n', '<leader>m', "<cmd>lua require('telescope.builtin').marks()<CR>", {
  noremap = true,
  silent = true,
  desc = 'List marks'
})

-- Open general Telescope picker
vim.keymap.set('n', '<leader>tl', "<cmd>Telescope<CR>", {
  noremap = true,
  silent = true,
  desc = 'Open Telescope'
})

-- Find files in the current project (similar to FZF's project_files)
vim.keymap.set('n', '<leader>pf', "<cmd>lua require('telescope.builtin').git_files()<CR>", {
  noremap = true,
  silent = true,
  desc = 'Project files'
})

-- Live grep in the project
vim.keymap.set('n', '<leader>p/', "<cmd>lua require('telescope.builtin').live_grep()<CR>", {
  noremap = true,
  silent = true,
  desc = 'Grep project'
})

-- Find files using the file browser
vim.keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", {
  noremap = true,
  silent = true,
  desc = 'Find files'
})
-- }}}

-- Buffer bindings {{{
-- List open buffers
vim.keymap.set('n', '<leader>bb', "<cmd>lua require('telescope.builtin').buffers()<CR>", {
  noremap = true,
  silent = true,
  desc = 'List buffers'
})
vim.keymap.set('n', 'gb', "<cmd>lua require('telescope.builtin').buffers()<CR>", {
  noremap = true,
  silent = true,
  desc = 'List buffers'
})
-- }}}

-- Git bindings {{{
-- List files changed in current branch
vim.keymap.set('n', '<leader>gF', "<cmd>lua require('telescope.builtin').git_files()<CR>", {
  noremap = true,
  silent = true,
  desc = 'Git files'
})

-- List git diffs for current file
vim.keymap.set('n', '<leader>gf', "<cmd>lua require('telescope.builtin').git_status()<CR>", {
  noremap = true,
  silent = true,
  desc = 'Git status'
})
-- }}}

-- Load Telescope extensions
require('telescope').load_extension('zf-native')
