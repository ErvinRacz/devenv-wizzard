local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local i = luasnip.insert_node
local c = luasnip.choice_node

-- Define commit message snippet using fmt
local commit_snippets = {
	luasnip.s(
		"gitmsg",
		fmt(
			[[
    {}: {}
    
    {}

    {} #{}
  ]],
			{
				i(1, "Module name"), -- Placeholder for module name
				i(2, "What changed"), -- Placeholder for commit description
				i(3, "Why this change was made"), -- Placeholder for commit body
				c(4, { -- Choice node for "Fixes", "Closes", etc.
					luasnip.text_node("See"),
					luasnip.text_node("Fixes"),
					luasnip.text_node("Closes"),
					luasnip.text_node("Refs"),
				}),
				i(5, "issue_number"), -- Placeholder for issue number
			}
		)
	),
}

-- luasnip.add_snippets("gitcommit", commit_snippets)
luasnip.add_snippets("NeogitCommitMessage", commit_snippets)

local function expand_git_message_snippet()
	print("Expanding snippet for NeogitCommitMessage!") -- Debug message
	local gitmsg_snip = luasnip.get_snippets()["NeogitCommitMessage"][1]
	-- print(luasnip.expandable(gitmsg_snip)) -- Debug message
	luasnip.snip_expand(gitmsg_snip)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "NeogitCommitMessage",
	callback = function()
		vim.cmd("startinsert") -- Switch to insert mode
		expand_git_message_snippet()
	end,
})
