-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.default_prog = { 'wsl.exe', '-d', 'Ubuntu-24.04', '--cd', '~' }

-- For example, changing the color scheme:
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 1
-- config.window_background_opacity = 0
-- config.win32_system_backdrop = 'Tabbed'
-- config.front_end = "OpenGL" -- needed for backdrop

config.initial_rows = 40
config.initial_cols = 140

config.default_domain = 'WSL:Ubuntu'

-- and finally, return the configuration to wezterm
return config
