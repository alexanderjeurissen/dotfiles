return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      local home = vim.env.HOME
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = home .. "/Documents/Notes",
              },
              default_workspace = "notes",
            },
          },
        },
      }
    end,
  },
}
