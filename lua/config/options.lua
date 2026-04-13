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
