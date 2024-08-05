require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "/Users/alexander/Documents/Notes",
        },
        default_workspace = "notes",
      },
    },
    -- ["external.context"] = {},
  },
}
