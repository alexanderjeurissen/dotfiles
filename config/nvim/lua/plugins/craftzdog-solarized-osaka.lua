vim.o.background = "dark" -- or "light" for light mode
vim.o.termguicolors = true -- set termguicolors

require("solarized-osaka").setup({
  -- transparent = true,
  terminal_colors = true,
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  on_highlights = function(hl, c)
    local border = "#001a1d"
    local background = "none"

    -- Unlink highlight groups so we can higlhight them individually
    vim.api.nvim_set_hl(0, 'TelescopBorder', {})
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', {})
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', {})
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', {})

    hl.TelescopeNormal = {
      bg = background,
      fg = c.fg_dark,
    }

    --[[ hl.TelescopeBorder = {
      bg = "none",
      fg = "none",
    } ]]

    hl.TelescopePromptTitle = {
      bg = c.yellow,
      fg = border,
    }

    hl.TelescopePromptNormal = {
      bg = background,
    }

    hl.TelescopePromptCounter = {
      bg = background,
      fg = c.yellow,
    }

    hl.TelescopePromptPrefix = {
      bg = background,
      fg = c.yellow,
    }

    hl.TelescopePromptBorder = {
      bg = border,
      fg = c.yellow,
    }

    hl.TelescopePreviewTitle = {
      bg = c.cyan,
      fg = border,
    }

    hl.TelescopePreviewNormal = {
      bg = background,
      fg = c.fg,
    }

    hl.TelescopePreviewBorder = {
      bg = "none",
      fg = c.cyan,
    }

    hl.TelescopeResultsTitle = {
      bg = background,
      -- bg = c.blue,
      fg = border,
    }

    hl.TelescopeNormal = {
      bg = background,
      fg = c.fg,
    }

    hl.TelescopeResultsBorder = {
      bg = "none",
      fg = c.blue,
    }
  end
})

-- setup must be called before loading
vim.cmd.colorscheme "solarized-osaka"

