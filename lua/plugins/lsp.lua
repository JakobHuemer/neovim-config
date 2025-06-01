return {{
    "dundalek/lazy-lsp.nvim",
    dependencies = {"neovim/nvim-lspconfig", {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x"
    }, "hrsh7th/cmp-nvim-lsp", "hrsh7th/nvim-cmp"},
    config = function()
        local lsp_zero = require("lsp-zero")

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings to learn the available actions
            lsp_zero.default_keymaps({
                buffer = bufnr,
                preserve_mappings = false
            })
        end)

        require("lazy-lsp").setup({
            servers = {
                nixd = {
                    cmd = {"nixd"},
                    settings = {
                        nixd = {
                            nixpkgs = {
                                expr = "import <nixpkgs> { }"
                            },
                            formatting = {
                                command = {"nixfmt"}
                            },
                            options = {
                                nixos = {
                                    expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).nixosConfigurations.someProfile.options'
                                },
                                darwin = {
                                    expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).darwinConfigurations.mbp2p.options'
                                },
                                nix_darwin = {
                                    expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).darwinConfigurations.mbp2p.options'
                                },
                                home_manager = {
                                    expr = '(builtins.getFlake ("git+file://" + toString ~/nix)).homeConfigurations."ruixi@k-on".options'
                                }
                            }
                        }
                    }
                }
            }
        })
    end
}}
