-- dont wrap in gitcommits
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.cmd("set textwidth&")
    end,
})
