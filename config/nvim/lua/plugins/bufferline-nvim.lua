return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup {
        options = {
          diagnostics = 'nvim_lsp',
          show_buffer_close_icons = false,
          numbers = function(opts)
            if vim.bo[opts.id].readonly then
              return ""
            else
              return ""
            end
          end,
          name_formatter = function(buf)
            local len = #buf.path
            local sep = "/"
            local max_len = 18
            local path = vim.fn.expand('%:~:.')
            if len <= max_len then
              return path
            end
            local segments = vim.split(path, sep)
            for idx = 1, #segments - 1 do
              if len <= max_len then
                break
              end
              local segment = segments[idx]
              local shortened = segment:sub(1, vim.startswith(segment, '.') and 2 or 1)
              segments[idx] = shortened
              len = len - (#segment - #shortened)
            end
            return table.concat(segments, sep)
          end,
        }
      }
    end,
  }
}
