return {
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        lazy = false,
        config = function(_, opts)
            vim.cmd([[
                let g:undotree_WindowLayout=1
                let g:undotree_SetFocusWhenToggle=1
                let g:undotree_ShortIndicators=1
            ]])

            vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle, {})
        end,
    },
}
