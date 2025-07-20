-- dont wrap in gitcommits
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.cmd("set textwidth&")
    end,
})

-- show diff color highlighting in gitcommit
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.cmd("setlocal syntax=diff")
  end,
})
