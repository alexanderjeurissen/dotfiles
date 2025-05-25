
require("neotest").setup({
  adapters = {
    require("neotest-rspec")({
      -- Optionally your function can take a position_type which is one of:
      -- - "file"
      -- - "test"
      -- - "dir"
      rspec_cmd = function(position_type)
        if position_type == "test" then
          return vim.tbl_flatten({
            "docker-compose",
            "exec",
            "-T",                 -- Use non-interactive mode
            "-e", "RAILS_ENV=test", -- Set the environment variable
            "core-specs",         -- Service name in docker-compose
            "rspec",
            "--fail-fast"
          })
        else
          return vim.tbl_flatten({
            "docker-compose",
            "exec",
            "-T",                 -- Use non-interactive mode
            "-e", "RAILS_ENV=test", -- Set the environment variable
            "core-specs",         -- Service name in docker-compose
            "rspec"
          })
        end
      end,

      transform_spec_path = function(path)
        -- Adjust the spec path transformation as needed
        local prefix = require('neotest-rspec').root(path)
        return string.sub(path, string.len(prefix) + 2, -1)
      end,

      results_path = "tmp/rspec.output" -- Path to store results
    }),
    require("neotest-jest"),
  }
})
