return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        lazy = false,
        opts = {
            window = {
                position = "right",
            },
            event_handlers = {
                {
                    event = "after_render",
                    handler = function(state)
                        if state.current_position == "left" or state.current_position == "right" then
                            vim.api.nvim_win_call(state.winid, function()
                                local str = require("neo-tree.ui.selector").get()
                                if str then
                                    _G.__cached_neo_tree_selector = str
                                end
                            end)
                        end
                    end,
                },
                {
                    event = "file_opened",
                    handler = function()
                        vim.cmd([[Neotree close]])
                    end,
                },
            },
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({
                        toggle = true,
                        source = "filesystem",
                        position = "right",
                    })
                end,
                desc = "Buffers (root dir)",
            },
        },
    },
}
