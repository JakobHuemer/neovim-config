local mini_path = vim.fn.stdpath("config") .. "/lua/plugins/mini"
local handle = vim.loop.fs_scandir(mini_path)
local imports = {}

if handle then
    while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then
            break
        end
        if type == "file" and name:sub(-4) == ".lua" then
            local modname = name:sub(1, -5) -- strip .lua
            table.insert(imports, { import = "plugins.mini." .. modname })
        end
    end
end

return imports
