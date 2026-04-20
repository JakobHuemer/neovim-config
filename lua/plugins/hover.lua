return {
    "lewis6991/hover.nvim",
    config = function()
        require("hover").config({
            providers = {
                "hover.providers.diagnostic",
                "hover.providers.lsp",
                "hover.providers.dap",
                "hover.providers.man",
                -- "hover.providers.gh",
                -- "hover.providers.highlight",
                -- "hover.providers.dictionary",
            },
            preview_opts = {
                border = "rounded",
            },
            preview_window = false,
            title = true,
        })
    end,
}

