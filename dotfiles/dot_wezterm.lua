-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.default_prog = { 'pwsh.exe', '-NoLogo' }

-- For example, changing the color scheme:
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_background_opacity = 1
-- config.window_background_opacity = 0
-- config.win32_system_backdrop = 'Tabbed'
-- config.front_end = "OpenGL" -- needed for backdrop

config.initial_rows = 40
config.initial_cols = 140


-- and finally, return the configuration to wezterm
return config