return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>m", "<cmd>Telescope marks<CR>", desc = "List marks" },
      { "<leader>tl", "<cmd>Telescope<CR>", desc = "Open Telescope" },
      { "<leader>pf", "<cmd>Telescope git_files<CR>", desc = "Project files" },
      { "<leader>p/", "<cmd>Telescope live_grep<CR>", desc = "Grep project" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "List buffers" },
      { "gb", "<cmd>Telescope buffers<CR>", desc = "List buffers" },
      { "<leader>gF", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>gf", "<cmd>Telescope git_status<CR>", desc = "Git status" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "natecraddock/telescope-zf-native.nvim",
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
        },
        extensions = {
          ["zf-native"] = { file = { enable = true, highlight_results = true, match_filename = true, smart_case = true },
                            generic = { enable = true, highlight_results = true, match_filename = false, smart_case = true } },
        },
      }
      require('telescope').load_extension('zf-native')
    end,
  },
}
