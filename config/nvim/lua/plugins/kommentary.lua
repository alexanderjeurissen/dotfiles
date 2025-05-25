
vim.g.kommentary_create_default_mappings = false

vim.keymap.set("n", "gcc", "<Plug>kommentary_line_default")
vim.keymap.set("n", "gc", "<Plug>kommentary_motion_default")
vim.keymap.set("v", "gc", "<Plug>kommentary_visual_default<C-c>")
