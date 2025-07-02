return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-zf-native.nvim",
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup{
        pickers = {
          marks = { layout_config = { height = 30, width = 100 } },
          projects = { layout_config = { height = 30, width = 100 } },
          git_files = { layout_config = { height = 30, width = 100 } },
          find_files = { layout_config = { height = 30, width = 100 } },
          buffers = { layout_config = { height = 30, width = 100 } },
          live_grep = {
            layout_config = { height = 30, width = 200 },
            preview = { hide_on_startup = false },
            debounce = 100,
          },
        },
        defaults = {
          preview = { hide_on_startup = true },
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
              ["<C-a>"] = actions.toggle_all,
              ["<C-o>"] = actions.send_selected_to_loclist + actions.open_loclist,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
              ["<C-a>"] = actions.toggle_all,
              ["<C-o>"] = actions.send_selected_to_loclist + actions.open_loclist,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
          selection_caret = '❯ ',
          entry_prefix = '  ',
          initial_mode = 'insert',
          selection_strategy = 'descending',
        },
        extensions = {
          ["zf-native"] = { file = { enable = true, highlight_results = true, match_filename = true, smart_case = true },
                            generic = { enable = true, highlight_results = true, match_filename = false, smart_case = true } },
        },
      }
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>m', builtin.marks, { noremap = true, silent = true, desc = 'List marks' })
      vim.keymap.set('n', '<leader>tl', ":Telescope<CR>", { noremap = true, silent = true, desc = 'Open Telescope' })
      vim.keymap.set('n', '<leader>pf', builtin.git_files, { noremap = true, silent = true, desc = 'Project files' })
      vim.keymap.set('n', '<leader>p/', builtin.live_grep, { noremap = true, silent = true, desc = 'Grep project' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true, desc = 'Find files' })
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { noremap = true, silent = true, desc = 'List buffers' })
      vim.keymap.set('n', 'gb', builtin.buffers, { noremap = true, silent = true, desc = 'List buffers' })
      vim.keymap.set('n', '<leader>gF', builtin.git_files, { noremap = true, silent = true, desc = 'Git files' })
      vim.keymap.set('n', '<leader>gf', builtin.git_status, { noremap = true, silent = true, desc = 'Git status' })
      require('telescope').load_extension('zf-native')
    end,
  },
}
