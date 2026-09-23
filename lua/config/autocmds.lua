-- dont wrap in gitcommits
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.cmd("set textwidth&")
    end,
})

-- no auto-wrap while typing in nix (breaks strings); gq still reflows
vim.api.nvim_create_autocmd("FileType", {
    pattern = "nix",
    callback = function()
        vim.opt_local.formatoptions:remove("t")
    end,
})

-- show diff color highlighting in gitcommit
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.cmd("setlocal syntax=diff")
  end,
})
