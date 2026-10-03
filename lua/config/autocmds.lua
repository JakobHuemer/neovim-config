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

-- reload buffers changed on disk (sqlc regen, git checkout, external tools).
-- checktime only reloads unmodified buffers; modified ones prompt (W12) instead.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose", "TermLeave" }, {
    command = "checktime",
})
