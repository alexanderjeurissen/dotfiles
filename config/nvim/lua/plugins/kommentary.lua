return {
  {
    "b3nj5m1n/kommentary",
    config = function()
      vim.g.kommentary_create_default_mappings = false
      vim.keymap.set("n", "gcc", "<Plug>kommentary_line_default", { desc = 'Toggle comment line' })
      vim.keymap.set("n", "gc", "<Plug>kommentary_motion_default", { desc = 'Toggle comment motion' })
      vim.keymap.set("v", "gc", "<Plug>kommentary_visual_default<C-c>", { desc = 'Toggle comment selection' })
    end,
  },
}
