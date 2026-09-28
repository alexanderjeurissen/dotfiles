-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Define the leader key
local leader = { key = 't', mods = 'CTRL' }

-- Pomodoro state
local pomodoro = {
  duration = 1200, -- 20 minutes
  break_duration = 300, -- 5 minutes
  start_time = nil,
  running = false,
  is_break = false,
}

-- Fix the right status bar
wezterm.on('update-status', function(window)
  -- Minimal flat status bar inspired by OpenAI GPT aesthetics
  local date = wezterm.strftime('%I:%M %p')
  local hostname = wezterm.hostname():match('^[^.]+')
  local status = hostname .. ' | ' .. date

  -- Add pomodoro status
  local pomo_status = ''
  if pomodoro.running then
    local current_time = os.time()
    local elapsed = current_time - pomodoro.start_time
    local duration = pomodoro.is_break and pomodoro.break_duration or pomodoro.duration
    local remaining = duration - elapsed

    if remaining <= 0 then
      -- Timer completed
      pomodoro.running = false

      -- Show notification
      local message = pomodoro.is_break and 'Break complete! Time to work.' or 'Pomodoro complete! Take a break.'
      os.execute(string.format('osascript -e \'display notification "%s" with title "Pomodoro"\'', message))

      -- Launch clock in new tab
      window:perform_action(wezterm.action.SpawnCommandInNewTab({
        args = { 'sh', '-c', '/opt/homebrew/bin/tty-clock -c -C 4 || (echo "Install tty-clock: brew install tty-clock" && read)' }
      }), window:active_pane())

      -- Toggle mode
      pomodoro.is_break = not pomodoro.is_break
    else
      -- Show progress bar with time inside (minimal padding)
      local progress = (duration - remaining) / duration
      local full_text = ' ' .. date .. ' '
      local total_width = #full_text

      -- Calculate progress position
      local progress_chars = math.floor(progress * total_width)

      -- Split text at progress point
      local filled_text = string.sub(full_text, 1, progress_chars)
      local unfilled_text = string.sub(full_text, progress_chars + 1)

      window:set_right_status(wezterm.format({
        { Background = { Color = '#0031a9' } }, -- blue from modus palette
        { Foreground = { Color = '#ffffff' } }, -- white text on blue
        { Text = filled_text },
        { Background = { Color = '#000000' } }, -- black background for unfilled
        { Foreground = { Color = '#ffffff' } }, -- white text on black
        { Text = unfilled_text },
      }))
      return
    end
  end

  -- Same minimal padding when not running
  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#ffffff' } },
    { Background = { Color = '#000000' } },
    { Text = ' ' .. date .. ' ' },
  }))
end)

-- Format the tab title: bold for the active tab and omit the index
wezterm.on('format-tab-title', function(tab)
  local title = tab.active_pane.title
  local prefix = '  '
  local intensity = 'Normal'

  if tab.is_active then
    prefix = ' •'
    intensity = 'Bold'
  end

  return wezterm.format({
    { Foreground = { Color = '#ffffff' } },
    { Background = { Color = '#000000' } },
    { Attribute = { Intensity = intensity } },
    { Text =  prefix .. title .. ' ' },
  })
end)

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Modus-Vivendi'
  else
    return 'Modus-Operandi'
  end
end

-- Configuration
  -- Set the font
  config.font = wezterm.font('BlexMono Nerd Font Mono')

  -- Set the font size
  config.font_size = 14.0

  -- Set the color scheme
  config.color_scheme = scheme_for_appearance(get_appearance())

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

    -- Pomodoro toggle (start/stop)
    { key = 't', mods = 'LEADER', action = wezterm.action_callback(function(window)
      if pomodoro.running then
        -- Stop and reset
        pomodoro.running = false
        pomodoro.start_time = nil
        pomodoro.is_break = false
        window:toast_notification('Pomodoro', 'Stopped', nil, 1000)
      else
        -- Start new work session
        pomodoro.start_time = os.time()
        pomodoro.running = true
        pomodoro.is_break = false
        window:toast_notification('Pomodoro', 'Started - 20min focus', nil, 1000)
      end
    end)},
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
