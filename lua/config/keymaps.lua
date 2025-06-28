-- delete full lines in visual selection
vim.keymap.set("x", "<leader>D", ":'<,'>d<CR>", { desc = "Delete full lines in visual selection" })

-- lsp rename
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

vim.keymap.set("n", "gi", function()
    vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "LSP diagnostic popup" })

vim.keymap.set("n", "<leader>gru", function()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.removeUnused.ts" },
            diagnostics = {},
        },
    })
end, { desc = "Remove unused imports" })
