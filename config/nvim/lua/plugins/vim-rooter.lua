return {
  {
    "airblade/vim-rooter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_patterns = {'.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile'}
    end,
  },
}
