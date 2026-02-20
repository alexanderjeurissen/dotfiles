return {
  {
    "b3nj5m1n/kommentary",
    keys = {
      { "gcc", "<Plug>kommentary_line_default", mode = "n", desc = "Toggle comment line" },
      { "gc", "<Plug>kommentary_motion_default", mode = "n", desc = "Toggle comment motion" },
      { "gc", "<Plug>kommentary_visual_default<C-c>", mode = "v", desc = "Toggle comment selection" },
    },
    config = function()
      vim.g.kommentary_create_default_mappings = false
    end,
  },
}
