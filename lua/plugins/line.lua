return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "catppuccin",
        },
    },
    config = function(_, opts)
        -- global line
        vim.cmd([[ set laststatus=3 ]])

        local line = require("lualine")
        line.setup(opts)
    end,
}
