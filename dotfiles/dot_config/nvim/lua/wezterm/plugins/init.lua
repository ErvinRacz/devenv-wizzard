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

return M
