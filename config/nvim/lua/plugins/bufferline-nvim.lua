require("bufferline").setup {
  options = {
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = false,
    numbers = function(opts) -- TODO: HACK to display readonly flag
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
    --[[ groups = {
      options = {
        toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
      },
      items = {
        {
          name = " Tests", -- Mandatory
          auto_close = true,
          priority = 2, -- determines where it will appear relative to other groups (Optional)
          matcher = function(buf) -- Mandatory
            local filepath = vim.api.nvim_buf_get_name(buf.id)
            return filepath:match("%_spec") or
            filepath:match("%_test") or
            filepath:match("%.test") or
            filepath:match("%.feature")
          end,
        },
      }
    } ]]
  }
}
