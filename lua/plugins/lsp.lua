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
                "ts_ls",
                "jdtls",
                "rust_analyzer",

                -- c...
                "clangd",
                -- "buf_ls",
                "protols",
                "mesonlsp",
            },
            automatic_enable = false,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "echasnovski/mini.completion" },
        config = function()
            -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local capabilities = require("mini.completion").get_lsp_capabilities()
            capabilities.textDocument.completion.completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    },
                },
            }

            -- vim.lsp.set_log_level("debug")

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
                        checkOnSave = true,
                        -- performance is heavily influenced by inlayHints
                        -- inlayHints = {
                        -- 	enable = true,
                        -- 	-- typeHints = true,
                        -- 	-- parameterHints = true,
                        -- },
                    },
                },
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })

            -- c....
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.protols.setup({
                capabilities = capabilities,
            })
            lspconfig.mesonlsp.setup({
                capabilities = capabilities,
            })

            lspconfig.jdtls.setup({
                capabilities = capabilities,
                settings = {
                    java = {
                        configuration = {
                            runtimes = {
                                -- {
                                -- 	name = "JavaSE-21",
                                -- 	path = "/opt/jdk-21",
                                -- 	default = true,
                                -- },
                            },
                        },
                    },
                },
            })
            lspconfig.nixd.setup({
                capabilities = capabilities,
                cmd = { "nixd" },
                flags = {
                    inlayHints = true,
                },
                settings = {
                    nixd = {
                        autowatch = true,
                        nixpkgs = {
                            expr = "import <nixpkgs> { }",
                        },
                        formatting = {
                            command = { "alejandra" },
                        },
                        options = {
                            nixos = {
                                expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).nixosConfigurations.someProfile.options',
                            },
                            darwin = {
                                expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).darwinConfigurations.mbp2p.options',
                            },
                            nix_darwin = {
                                expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).darwinConfigurations.mbp2p.options',
                            },
                            home_manager = {
                                expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).homeConfigurations.mbp2p.options',
                            },
                            flake_parts = {
                                expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).debug.options',
                            },
                        },
                    },
                },
            })

            -- enable inlay inlay
            vim.lsp.inlay_hint.enable(true, { 0 })
            vim.diagnostic.enable = true

            -- just a single one or else duplicated warnings
            vim.diagnostic.config({
                virtual_text = true,
                -- virtual_lines = true,
            })

            local _border = "rounded"

            local function bordered_hover(_opts)
                _opts = _opts or {}
                return vim.lsp.buf.hover(vim.tbl_deep_extend("force", _opts, {
                    border = _border,
                }))
            end

            -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "K", bordered_hover, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.declaration, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
