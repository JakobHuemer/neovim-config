return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.opt.termguicolors = true
            _G.__cached_neo_tree_selector = nil
            _G.__get_selector = function()
                return _G.__cached_neo_tree_selector
            end
            local bufferline = require("bufferline")

            bufferline.setup({
                options = {
                    -- or you can combine these e.g.
                    style_preset = {
                        bufferline.style_preset.no_italic,
                        bufferline.style_preset.no_bold,
                    },
                    diagnostics = "nvim_lsp",
                    separator_style = "slope",
                    color_icons = true,
                    themable = true,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            raw = " %{%v:lua.__get_selector()%} ",
                            highlight = { sep = { link = "WinSeparator" } },
                            separator = "┃",
                        },
                    },
                },
            })
        end,
    },
}
