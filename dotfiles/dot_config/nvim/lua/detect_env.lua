local M = {}

function M.get_environment()
    local uname = vim.loop.os_uname()

    if string.find(uname.sysname, "Windows") ~= nil then
        return "WINDOWS"
    elseif string.find(uname.sysname, "Windows") ~= nil then
        return "LINUX"
    end

    return nil
end

return M
