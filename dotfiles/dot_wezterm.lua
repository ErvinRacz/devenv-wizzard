-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_close_confirmation = 'NeverPrompt'

config.keys = {
  {
    key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = false }
  },
  { key = 't', mods = 'CTRL', action = act.SpawnTab 'DefaultDomain' },
}
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'wsl',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
}

config.window_background_opacity = 1

config.initial_rows = 40
config.initial_cols = 140


local def_dom = 'WSL:Ubuntu-24.04'
config.default_domain = def_dom

-- and finally, return the configuration to wezterm
return config
