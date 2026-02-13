return {
    {
        "xiyaowong/virtcolumn.nvim",
        config = function()
            vim.g.virtcolumn_char = "▕"
            vim.g.virtcolumn_priority = 10

            vim.opt.cc = "+0,+20,+40"
            vim.opt.textwidth = 80

            -- Override ftplugin textwidth settings
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function()
                    -- Defer to run after ftplugin
                    vim.schedule(function()
                        vim.opt_local.textwidth = 80
                    end)
                end,
            })
        end,
    },
}
