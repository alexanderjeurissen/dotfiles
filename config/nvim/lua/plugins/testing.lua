return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-rspec", "nvim-neotest/neotest-jest" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")({
            rspec_cmd = function(position_type)
              if position_type == "test" then
                return vim.tbl_flatten({
                  "docker-compose","exec","-T","-e","RAILS_ENV=test","core-specs","rspec","--fail-fast"
                })
              else
                return vim.tbl_flatten({
                  "docker-compose","exec","-T","-e","RAILS_ENV=test","core-specs","rspec"
                })
              end
            end,
            transform_spec_path = function(path)
              local prefix = require('neotest-rspec').root(path)
              return string.sub(path, string.len(prefix) + 2, -1)
            end,
            results_path = "tmp/rspec.output"
          }),
          require("neotest-jest"),
        }
      })
    end,
  },
}
