local M = {}

function M.base64(data)
	data = tostring(data)
	local bit = require("bit")
	local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local b64, len = "", #data
	local rshift, lshift, bor = bit.rshift, bit.lshift, bit.bor

	for i = 1, len, 3 do
		local a, b, c = data:byte(i, i + 2)
		b = b or 0
		c = c or 0

		local buffer = bor(lshift(a, 16), lshift(b, 8), c)
		for j = 0, 3 do
			local index = rshift(buffer, (3 - j) * 6) % 64
			b64 = b64 .. b64chars:sub(index + 1, index + 1)
		end
	end
	local padding = (3 - len % 3) % 3
	b64 = b64:sub(1, -1 - padding) .. ("="):rep(padding)
	return b64
end

function M.set_user_var(key, value)
	io.write(string.format("\027]1337;SetUserVar=%s=%s\a", key, M.base64(value)))
end

-- Helper function for switching tabs forward
local function switch_forward(system_command)
	local current_tab = vim.api.nvim_get_current_tabpage()
	local tabs = vim.api.nvim_list_tabpages()
	local last_tab = tabs[#tabs]

	vim.cmd("stopinsert")
	if current_tab == last_tab then
		vim.fn.system(system_command)
	else
		vim.cmd("tabnext")
	end
end

-- Helper function for switching tabs backward
local function switch_backward(fallback_command)
	local current_tab = vim.api.nvim_get_current_tabpage()

	vim.cmd("stopinsert")
	if current_tab == 1 then
		vim.fn.system(fallback_command)
	else
		vim.cmd("tabprevious")
	end
end

-- Strategies for different environments
local strategies = {
	wezterm = {
		switch_tabs_forward = function()
			switch_forward("wezterm cli activate-tab --no-wrap --tab-relative 1")
		end,
		switch_tabs_backward = function()
			switch_backward("wezterm cli activate-tab --no-wrap --tab-relative -1")
		end,
		select_non_vim_windows = function()
			vim.cmd("stopinsert")
			local wezterm_cli = "wezterm cli list --format json"
			local handle = io.popen(wezterm_cli)
			if not handle then
				print("Error: Unable to execute wezterm CLI")
				return
			end
			local output = handle:read("*a")
			handle:close()

			local wezterm_tabs = vim.fn.json_decode(output)
			if #wezterm_tabs <= 1 then
				vim.fn.system("wezterm cli spawn")
			else
				vim.fn.system("wezterm cli activate-tab --tab-relative 1")
			end
		end,
	},
	tmux = {
		switch_tabs_forward = function()
			switch_forward("tmux next-window")
		end,
		switch_tabs_backward = function()
			switch_backward("tmux previous-window")
		end,
		select_non_vim_windows = function()
			vim.cmd("stopinsert")
			vim.fn.system("tmux select-window -t :.+")
		end,
	},
}

-- Detect environment and return the appropriate strategy
local function detect_environment()
	if vim.fn.exists("$TMUX") == 1 then
		return "tmux"
	elseif vim.fn.exists("$WEZTERM") == 1 then
		return "wezterm"
	else
		return "default"
	end
end

-- Default strategy for unsupported environments
strategies.default = {
	switch_tabs_forward = function()
		vim.cmd("tabnext")
	end,
	switch_tabs_backward = function()
		vim.cmd("tabprevious")
	end,
	select_non_vim_windows = function()
		print("Non-Vim window selection not supported in this environment.")
	end,
}

-- Main setup function
function M.setup()
	M.set_user_var("NVIM_PRESENT", true)
	-- Register autocommands for Neovim activity
	vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
		callback = function()
			M.set_user_var("NVIM_PRESENT", true)
		end,
	})
	vim.api.nvim_create_autocmd({ "FocusLost", "VimLeave" }, {
		callback = function()
			M.set_user_var("NVIM_PRESENT", false)
		end,
	})

	local environment = detect_environment()
	M.strategy = strategies[environment]
end

-- Expose the switching functions
function M.switch_tabs_forward()
	M.strategy.switch_tabs_forward()
end

function M.switch_tabs_backward()
	M.strategy.switch_tabs_backward()
end

function M.select_non_vim_windows()
	M.strategy.select_non_vim_windows()
end

return M
