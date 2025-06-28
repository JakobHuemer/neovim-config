return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
        options = {
            theme = "catppuccin",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = {
                        error = " ",
                        warn = " ",
                        info = " ",
                        hint = " ",
                    },
                },
            },
            lualine_c = {
                "filename",
                "lsp_status",
            },
            lualine_x = { "searchcount", "copilot", "encoding", "fileformat", "filetype" }, -- I added copilot here
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    },
    config = function(_, opts)
        local line = require("lualine")

        line.setup(opts)
    end,
}
