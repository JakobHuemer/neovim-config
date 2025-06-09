return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        keys = {
            {
                "<leader>gp",
                "<cmd>Gitsigns preview_hunk<cr>",
                mode = "n",
                desc = "previews hunks in git",
            },
            {
                "<leader>gtl",
                "<cmd>Gitsigns toggle_linehl<cr>",
                mode = "n",
                desc = "toggle highlighted colors in git",
            },
            {
                "<leader>gh",
                "<cmd>Gitsigns blame_line<cr>",
                mode = "n",
                desc = "get the blame fpr the currnt line",
            },
        },
        opts = {
            -- current_line_blame = true,
            current_line_blame_opts = {
                delay = 200,
            },
        },
    },
    {
        "tpope/vim-fugitive",
        enable = false,
        keys = {
            {
                "<leader>gb",
                "<cmd>Git blame<cr>",
                mode = "n",
                desc = "show git blame for current file in new pane",
            },
        },
    },
}
