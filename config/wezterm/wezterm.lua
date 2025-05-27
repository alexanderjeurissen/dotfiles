-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()


-- Define the leader key
local leader = { key = 't', mods = 'CTRL' }

-- Fix the right status bar
wezterm.on('update-status', function(window)
  -- Minimal flat status bar inspired by OpenAI GPT aesthetics
  local date = wezterm.strftime('%I:%M %p')
  local hostname = wezterm.hostname():match('^[^.]+')
  local status = hostname .. ' | ' .. date

  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#ffffff' } },
    { Background = { Color = '#000000' } },
    { Text = ' ' .. status .. ' ' },
  }))
end)

-- Format the tab title: bold for the active tab and omit the index
wezterm.on('format-tab-title', function(tab)
  local title = tab.active_pane.title
  if tab.is_active then
    return wezterm.format({
      { Attribute = { Intensity = 'Bold' } },
      { Text = ' ' .. title .. ' ' },
    })
  end
  return ' ' .. title .. ' '
end)

-- Configuration
  -- Set the font
  config.font = wezterm.font('BlexMono Nerd Font Mono')

  -- Set the font size
  config.font_size = 14.0

  -- Set the color scheme
  config.color_scheme = "Modus Operandi"
  -- config.color_scheme = "Modus Operandi"

  -- Set the window background opacity
  config.window_background_opacity = 1.0

  -- Use native full screen mode
  config.native_macos_fullscreen_mode = true

  -- Disable the title bar but retain resizable border
  config.window_decorations = "RESIZE"

  -- Enable tab bar and configure it
  config.enable_tab_bar = true
  -- hide_tab_bar_if_only_one_tab = true
  config.show_new_tab_button_in_tab_bar = false
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = false

  -- Don't prompt when closing windows
  config.window_close_confirmation = "NeverPrompt"

  -- Automatically reload Configuration
  -- automatically_reload_config = false,

  -- Define the leader key
  config.leader = leader

  -- Basic keybindings for tmux-like behavior
  config.keys = {
    -- Split horizontally
    { key = '"', mods = 'LEADER|SHIFT', action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } } },
    -- Split vertically
    { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } } },
    -- New tab
    { key = 'c', mods = 'LEADER',       action = wezterm.action { SpawnTab = 'CurrentPaneDomain' } },
    -- Close tab
    { key = 'x', mods = 'LEADER',       action = wezterm.action { CloseCurrentTab = { confirm = true } } },
    -- Navigate between panes
    { key = 'h', mods = 'LEADER',       action = wezterm.action { ActivatePaneDirection = 'Left' } },
    { key = 'j', mods = 'LEADER',       action = wezterm.action { ActivatePaneDirection = 'Down' } },
    { key = 'k', mods = 'LEADER',       action = wezterm.action { ActivatePaneDirection = 'Up' } },
    { key = 'l', mods = 'LEADER',       action = wezterm.action { ActivatePaneDirection = 'Right' } },
    -- Navigate between tabs
    { key = 'n', mods = 'LEADER',       action = wezterm.action { ActivateTabRelative = 1 } },
    { key = 'p', mods = 'LEADER',       action = wezterm.action { ActivateTabRelative = -1 } },
    -- Copy and paste
    { key = 'v', mods = 'CTRL|SHIFT',   action = wezterm.action { PasteFrom = 'Clipboard' } },
    { key = 'c', mods = 'CTRL|SHIFT',   action = wezterm.action { CopyTo = 'Clipboard' } },
    -- Zoom pane
    { key = 'z', mods = 'LEADER',       action = wezterm.action.TogglePaneZoomState },
    -- Toggle full screen
    { key = 'f', mods = 'CMD|CTRL',     action = wezterm.action.ToggleFullScreen },

    -- Enter Copy Mode (mimicking tmux visual mode)
    { key = 'v', mods = 'LEADER',       action = wezterm.action.ActivateCopyMode },
  }

  -- Scrollback lines
  config.scrollback_lines = 3500

  -- Enable ligatures
  config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

  config.window_padding = {
    left = 4,
    right = 4,
    top = 0,
    bottom = 0,
  }

return config
