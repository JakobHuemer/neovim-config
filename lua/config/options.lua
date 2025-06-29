vim.g.mapleader = " "
vim.cmd.colorscheme("catppuccin")
vim.opt.termguicolors = true

vim.opt.relativenumber = true
vim.opt.number = true
vim.cmd([[set clipboard+=unnamedplus]])

-- indents etc.
vim.cmd([[set tabstop=4]])
vim.cmd([[set shiftwidth=4]])
vim.cmd([[set expandtab]])

-- make statusline global
vim.cmd([[set laststatus=3]])

