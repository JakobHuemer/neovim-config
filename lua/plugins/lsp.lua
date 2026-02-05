return {
    -- {
    --     "mason-org/mason.nvim",
    --     opts = {},
    -- },
    -- {
    --     "mason-org/mason-lspconfig.nvim",
    --     opts = {
    --         ensure_installed = {
    --             -- "lua_ls",
    --             -- "ts_ls",
    --             -- "jdtls",
    --             -- "rust_analyzer",
    --             --
    --             -- -- c...
    --             -- "clangd",
    --             -- -- "buf_ls",
    --             -- "protols",
    --             -- "mesonlsp",
    --
    --             -- webdev
    --             -- "vuels",
    --             -- "emmet_language_server",
    --         },
    --         automatic_enable = false,
    --     },
    -- },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "echasnovski/mini.completion" },
        opts = {
            servers = {
                lua_ls = {},
                ast_grep = {},
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                targetDir = true,
                            },
                            checkOnSave = true,
                            inlayHints = {
                                enable = true,
                                typeHints = true,
                                parameterHints = true,
                            },
                        },
                    },
                },
                ts_ls = {},
                protols = {},
                mesonlsp = {},
                vuels = {},
                emmet_language_server = {},
                gopls = {},
                nixd = {
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
                },
            },
            diagnostics = {
                virtual_text = true,
            },
            inlay_hints = true,
        },
        config = function(_, opts)
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

            for server, server_opts in pairs(opts.servers or {}) do
                local merged_opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_opts)
                vim.lsp.config(server, merged_opts)
                vim.lsp.enable(server)
            end

            if opts.inlay_hints and vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(true, { 0 })
            end

            if opts.diagnostics then
                vim.diagnostic.config(opts.diagnostics)
            end

            local _border = "rounded"
            local function bordered_hover(_opts)
                _opts = _opts or {}
                return vim.lsp.buf.hover(vim.tbl_deep_extend("force", _opts, {
                    border = _border,
                }))
            end

            vim.keymap.set("n", "K", bordered_hover, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.declaration, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
