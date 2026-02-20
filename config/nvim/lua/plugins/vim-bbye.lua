return {
  {
    "moll/vim-bbye",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>wc", ":q<CR>", desc = "Close window" },
      { "<leader>bd", ":Bdelete<CR>", desc = "Delete buffer" },
      { "<leader>tC", ":tabnew<CR>", desc = "New tab" },
      { "<leader>tc", ":tabclose<CR>", desc = "Close tab" },
      { "<leader>tp", ":tabprevious<CR>", desc = "Previous tab" },
      { "<leader>tn", ":tabnext<CR>", desc = "Next tab" },
      { "<leader>bo", ":DeleteHiddenBuffers<CR>", desc = "Delete hidden buffers" },
      { "<leader>bw", ":bufdo :Bdelete<CR>", desc = "Wipe all buffers" },
    },
    config = function()
    end,
  },
}
