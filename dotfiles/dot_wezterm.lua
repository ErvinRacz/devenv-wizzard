-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = require("wezterm").mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_close_confirmation = "NeverPrompt"

local function is_nvim(pane)
	return pane:get_user_vars().NVIM_PRESENT == "true" or pane:get_foreground_process_name():find("n?vim")
end

local wez_nvim_action = function(window, pane, action_wez, forward_key_nvim)
	if is_nvim(pane) then
		window:perform_action(forward_key_nvim, pane)
	else
		window:perform_action(action_wez, pane)
	end
end

-- Function to find the pane with nvim
local function find_nvim_pane(window)
    for _, tab in ipairs(window:tabs()) do
        for _, pane in ipairs(tab:panes()) do
            if is_nvim(pane) then
                return tab, pane
            end
        end
    end
    return nil, nil
end

-- Action for Ctrl+Shift+T to go back to nvim tab
wezterm.on("find-nvim-tab", function(window, pane)
    local nvim_tab, nvim_pane = find_nvim_pane(window)
    if nvim_tab then
        wez_nvim_action(window, pane, act.ActivateTab(nvim_tab), act.SendKey({ key = "t", mods = "CTRL|SHIFT" }))
    else
        wezterm.log_info("No nvim tab found")
        window:perform_action(act.SendKey({ key = "t", mods = "CTRL|SHIFT" }), pane)
    end
end)

wezterm.on("move-tab-forward", function(window, pane)
	wez_nvim_action(window, pane, act.ActivateTabRelativeNoWrap(1), act.SendKey({ key = "Tab", mods = "CTRL" }))
end)

wezterm.on("move-tab-backward", function(window, pane)
	wez_nvim_action(window, pane, act.ActivateTabRelativeNoWrap(-1), act.SendKey({ key = "Tab", mods = "CTRL|SHIFT" }))
end)

wezterm.on("new-tab", function(window, pane)
	wez_nvim_action(window, pane, act.SpawnTab("DefaultDomain"), act.SendKey({ key = "t", mods = "CTRL" }))
end)

config.keys = {
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{ key = "t", mods = "CTRL", action = wezterm.action({ EmitEvent = "new-tab" }) },
	{ key = "Tab", mods = "CTRL", action = wezterm.action({ EmitEvent = "move-tab-forward" }) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action({ EmitEvent = "move-tab-backward" }) },
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action({ EmitEvent = "find-nvim-tab" }) },
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_background_opacity = 1

config.initial_rows = 40
config.initial_cols = 140

local def_dom = "WSL:Ubuntu-24.04"
config.default_domain = def_dom

-- and finally, return the configuration to wezterm
return config
