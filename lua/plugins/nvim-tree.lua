local function edit_or_open(api)
    return function()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- open file
            api.node.open.edit()
            -- Close the tree if file was opened
            api.tree.close()
        end
    end
end

local function vsplit_preview(api)
    return function()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- open file as vsplit
            api.node.open.vertical()
        end

        -- Finally refocus on tree if it was lost
        api.tree.focus()
    end
end

local function delete(api)
    return function()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- delete file
            return
        end

        -- Finally refocus on tree if it was lost
        api.tree.focus()
    end
end

return {
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            {
                "<C-h>",
                "<cmd>NvimTreeToggle<cr>",
                desc = "Toggle NvimTree",
                silent = true,
                noremap = true,
            },
        },
        opts = {
            on_attach = function(bufnr)
                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                local api = require("nvim-tree.api")

                vim.keymap.set("n", "l", edit_or_open(api), opts("Edit Or Open"))
                vim.keymap.set("n", "L", vsplit_preview(api), opts("Vsplit Preview"))
                vim.keymap.set("n", "h", api.tree.close, opts("Close"))
                vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
                vim.keymap.set("n", "a", api.fs.create, opts("Collapse All"))
                vim.keymap.set("n", "a", api.fs.create, opts("Create File"))
                vim.keymap.set("n", "r", api.fs.rename, opts("Delete File"))
                vim.keymap.set("n", "d", delete(api), opts("Delete File"))
            end,
        },
    },
}
