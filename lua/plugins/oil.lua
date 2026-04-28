return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            },
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("oil").open(vim.fn.expand("%:p:h"))
                end,
                desc = "Oil (file dir)",
            },
            {
                "<leader>E",
                function()
                    require("oil").open(vim.uv.cwd())
                end,
                desc = "Oil (cwd)",
            },
        },
    },
}
