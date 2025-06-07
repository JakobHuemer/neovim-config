return { {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
            "vue",
            "rust",
            "javascript",
            "java",
            "php",
            "python",
            "sql",
            "swift",
            "latex"
        },
        auto_install = true,
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        },
    },
    config = function(_, opts)
        local configs = require("nvim-treesitter.configs")

        configs.setup(opts)
    end
} }
