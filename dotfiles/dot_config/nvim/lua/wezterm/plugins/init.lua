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
end

-- Function to switch tabs forward
function M.switch_tabs_forward()
	local current_tab = vim.api.nvim_get_current_tabpage()

	local tabs = vim.api.nvim_list_tabpages()
	local last_tab = tabs[#tabs]

	print("current_tab", current_tab)
	print("last_tab", last_tab)
	vim.cmd("stopinsert")
	if current_tab == last_tab then
		vim.fn.system("wezterm.exe cli activate-tab --no-wrap --tab-relative 1")
	else
		vim.cmd("tabnext")
	end
end

-- Function to switch tabs backward
function M.switch_tabs_backward()
	local current_tab = vim.api.nvim_get_current_tabpage()

	vim.cmd("stopinsert")
	if current_tab == 1  then
		vim.fn.system("wezterm.exe cli activate-tab --no-wrap --tab-relative -1")
	else
		vim.cmd("tabprevious")
	end
end

function M.tmux_select_non_vim_windows()
	vim.cmd("stopinsert")
	local wezterm_cli = "wezterm.exe cli list --format json"

	-- Execute the wezterm CLI to fetch the tabs list
	local handle = io.popen(wezterm_cli)
	if not handle then
		print("Error: Unable to execute wezterm CLI")
		return
	end
	local output = handle:read("*a")
	handle:close()

	local wezterm_tabs = vim.fn.json_decode(output)

	if #wezterm_tabs <= 1 then
		vim.fn.system("wezterm.exe cli spawn")
	else
		vim.fn.system("wezterm.exe cli activate-tab --tab-relative 1")
	end
end

return M
