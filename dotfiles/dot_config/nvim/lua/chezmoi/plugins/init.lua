local detect_env = require("detect_env")

local M = {}

-- Function to check if the root directory matches the chezmoi source path
local function is_root_chezmoi_source_path()
    local root_dir = vim.fn.getcwd()
    local chezmoi_source_path = ""

    local env = detect_env.get_environment()
    if env == "WINDOWS"  then
        chezmoi_source_path = "~/.local/share/chezmoi"
    elseif env == "LINUX" then
        chezmoi_source_path = "~/.local/share/chezmoi"
    end

    local chezmoi_source_path = vim.fn.expand(chezmoi_source_path)
    -- print("env: ", env)
    -- print("chezmoi sp:", chezmoi_source_path)
    -- print("root dir", root_dir)
    return root_dir == chezmoi_source_path
end

-- Function to trigger on save
function M.on_save_callback()
    -- print(is_root_chezmoi_source_path())
    if is_root_chezmoi_source_path() then
        -- Run asynchronously
        vim.system({ "chezmoi", "apply", "--force" }, { detach = true }, function(result)
            if result.code == 0 then
                print("Chezmoi changes applied!")
            else
                print("Chezmoi apply failed:", result.stderr)
            end
        end)
    end
end

-- Setup function
function M.setup()
    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = M.on_save_callback,
        desc = "Trigger chezmoi apply on save in chezmoi root directory",
    })
end

return M
