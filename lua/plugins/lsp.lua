return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "rnix",
                "jdtls",
                -- "efm",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                    },
                },
            })
            -- lspconfig.efm.setup({
            --     capabilities = capabilities,
            --     init_options = { documentFormatting = true },
            --     filetypes = { "xml" },
            --     settings = {
            --         rootMarkers = { ".git" },
            --         languages = {
            --             xml = {
            --                 formatCommand = "xmllint --format -",
            --                 foramtStdin = true,
            --             },
            --         },
            --     },
            -- })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.rnix.setup({ capabilities = capabilities })
            lspconfig.jdtls.setup({
                capabilities = capabilities,
            })
            lspconfig.nixd.setup({
                capabilities = capabilities,
                cmd = { "nixd" },
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = "import <nixpkgs> { }",
                        },
                        formatting = {
                            command = { "nixfmt" },
                        },
                        options = {
                            nixos = {
                                expr =
                                '(builtins.getFlake ("git+file://" + toString ~/nix)).nixosConfigurations.someProfile.options',
                            },
                            darwin = {
                                expr =
                                '(builtins.getFlake ("git+file://" + toString ~/nix)).darwinConfigurations.mbp2p.options',
                            },
                            nix_darwin = {
                                expr =
                                '(builtins.getFlake ("git+file://" + toString ~/nix)).darwinConfigurations.mbp2p.options',
                            },
                            home_manager = {
                                expr =
                                '(builtins.getFlake ("git+file://" + toString ~/nix)).homeConfigurations."ruixi@k-on".options',
                            },
                        },
                    },
                },
            })

            vim.diagnostic.enable = true
            vim.diagnostic.config({
                virtual_text = true,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.declaration, {})
            vim.keymap.set(
                { "n", "v" },
                "<leader>ca",
                vim.lsp.buf.code_action,
                {}
            )
        end,
    },
}
