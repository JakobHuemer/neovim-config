return {
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"xmllint",
				"alejandra",
			},
		},
		config = function(_, opts)
			require("mason-null-ls").setup(opts)
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
		},
		opts = {
			formatters_by_ft = {
				xml = { "xmllint_4space" },
				lua = { "stylua" },
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
			},
			formatters = {
				xmllint_4space = {
					command = "sh",
					args = {
						"-c",
						"XMLLINT_INDENT='    ' xmllint --format -",
					},
					stdin = true,
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
