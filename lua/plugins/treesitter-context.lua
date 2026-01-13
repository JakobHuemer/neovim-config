return {
    {
        -- pinning current context scope to the top
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            max_lines = 5,
            mode = "cursor",
        },
    },
}
