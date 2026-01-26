return {
    -- {
    --     "jay-babu/mason-null-ls.nvim",
    --     dependencies = {
    --         -- "mason-org/mason.nvim",
    --         "nvimtools/none-ls.nvim",
    --     },
    --     opts = {
    --         ensure_installed = {
    --             "stylua",
    --             "prettierd",
    --             "prettier",
    --             "xmllint",
    --             "alejandra",
    --             "clang-format",
    --         },
    --     },
    --     config = function(_, opts)
    --         require("mason-null-ls").setup(opts)
    --     end,
    -- },
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "jay-babu/mason-null-ls.nvim",
        },
        opts = {
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                xml = { "xmlformat_4space" },
                -- lua = { "stylua" },
                -- add these options: ["--indent-type", "Spaces", "--indent-width", "4"]
                lua = { "stylua_4spaces" },
                -- Conform will run multiple formatters sequentially
                -- python = { "isort", "black" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = {
                    "prettierd",
                    "prettier",
                    stop_after_first = true,
                },
                nix = { "alejandra" },
                -- setup c/c++ formatters
                c = { "clang-format" },
                cpp = { "clang-format" },
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4}" },
                },
                xmlformat_4space = {
                    command = "xmlformat",
                    args = {
                        "-i",
                        "4",
                    },
                    stdin = true,
                },
                stylua_4spaces = {
                    command = "stylua",
                    args = {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                        "--search-parent-directories",
                        "--respect-ignores",
                        "-",
                    },
                },
            },
        },

        keys = {
            {
                "<leader>gf",
                function()
                    require("conform").format({ lsp_fallback = true })
                end,
                desc = "Format",
            },
        },
    },
}
