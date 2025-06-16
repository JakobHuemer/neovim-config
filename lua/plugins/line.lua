return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "catppuccin",
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
            lualine_c = { "filename" },
            lualine_x = { "copilot", "encoding", "fileformat", "filetype" }, -- I added copilot here
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    },
    config = function(_, opts)
        -- global line
        vim.cmd([[ set laststatus=3 ]])

        local line = require("lualine")
        line.setup(opts)
    end,
}
