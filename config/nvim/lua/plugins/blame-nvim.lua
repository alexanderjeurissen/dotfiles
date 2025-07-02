return {
  {
    "FabijanZulj/blame.nvim",
    config = function()
      local blame = require('blame')
      local window_view = require("blame.views.window_view")
      local virtual_view = require("blame.views.virtual_view")
      local commit_date_author_fn = function(line_porcelain, config, idx)
        local hash = string.sub(line_porcelain.hash, 0, 7)
        local line_with_hl = {}
        local is_commited = hash ~= "0000000"
        local function trim_to_width(str, width)
          if #str > width then
            return string.sub(str, 1, width) .. "…"
          else
            return str
          end
        end
        if is_commited then
          local trimmed_author = trim_to_width(line_porcelain.author, config.max_summary_width)
          local values = {
            { textValue = hash, hl = "Comment" },
            { textValue = trimmed_author, hl = hash },
          }
          if config.show_date then
            table.insert(values, 2, { textValue = os.date(config.date_format, line_porcelain.committer_time), hl = hash })
          end
          line_with_hl = {
            idx = idx,
            values = values,
            format = config.show_date and "%s  %s  %s" or "%s  %s",
          }
        else
          line_with_hl = {
            idx = idx,
            values = {
              { textValue = "Not commited", hl = "Comment" },
            },
            format = "%s",
          }
        end
        return line_with_hl
      end
      blame.setup({
        date_format = "%Y.%m.%d",
        focus_blame = true,
        merge_consecutive = false,
        virtual_style = "right_align",
        show_date = true,
        views = {
          window = window_view,
          virtual = virtual_view,
          default = window_view,
        },
        max_summary_width = 15,
        colors = { "#595959" },
        blame_options = nil,
        commit_detail_view = "vsplit",
        format_fn = commit_date_author_fn,
        mappings = {
          commit_info = "i",
          stack_push = "<TAB>",
          stack_pop = "<BS>",
          show_commit = "<CR>",
          close = { "<esc>", "q" },
        }
      })
    end,
  },
}
