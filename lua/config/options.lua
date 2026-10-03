vim.g.mapleader = " "
vim.cmd.colorscheme("catppuccin")
vim.opt.termguicolors = true
vim.cmd("filetype plugin indent on")

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.cmd([[set clipboard+=unnamedplus]])

-- indents etc.
vim.cmd([[set tabstop=4]])
vim.cmd([[set shiftwidth=4]])
vim.cmd([[set expandtab]])
vim.cmd("set indentkeys-=0)")  -- no re-indent on closing paren as first char
vim.cmd("set indentkeys-=0]}")  -- no re-indent on closing brace/bracket

-- make statusline global
vim.cmd([[set laststatus=3]])

vim.opt.cc = "+0,+20,+40"
vim.opt.textwidth = 80
-- no auto-wrap while typing (breaks code/strings); gq still reflows
vim.opt.formatoptions:remove("t")

-- Override ftplugin textwidth/formatoptions settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        -- Defer to run after ftplugin
        vim.schedule(function()
            vim.opt_local.textwidth = 80
            vim.opt_local.formatoptions:remove("t")
        end)
    end,
})
