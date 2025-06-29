return {
    {
        "echasnovski/mini.snippets",
        version = "*",
        opts = {
            mappings = {
                -- doesn't seem to change anything
                -- only keymap in config works
                expand = "<C-s>",

                jump_next = "<C-g>",
                jump_prev = "<C-b>",
                stop = "<C-c>",
            },

            expand = {
                prepate = nil,
                match = nil,
                select = nil,
                insert = nil,
            },
        },

        config = function(_, opts)
            local snippets = require("mini.snippets")
            snippets.setup(opts)

            vim.keymap.set({ "i", "n" }, "<C-s>", function()
                snippets.session.get()
            end, { desc = "Expand Snippet" })

            vim.keymap.set("i", "<C-g>", function()
                snippets.session.jump("next")
            end, { desc = "Jump to Next Snippet" })

            vim.keymap.set({ "i" }, "<C-b>", function()
                snippets.session.jump("prev")
            end, { desc = "Jump to Previous Snippet" })

            vim.keymap.set({ "i", "n" }, "<C-c>", function()
                snippets.session.stop()
            end, { desc = "Stop Snippet" })
        end,
    },
    {
        "echasnovski/mini.completion",
        version = "*",
        dependencies = {
            { "echasnovski/mini.icons", version = "*" },
            "echasnovski/mini.snippets",
            "rafamadriz/friendly-snippets",
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
                build = "make install_jsregexp",
            },
        },

        opts = {
            -- Delay (debounce type, in ms) between certain Neovim event and action.
            -- This can be used to (virtually) disable certain automatic actions by
            -- setting very high delay time (like 10^7).
            delay = { completion = 100, info = 100, signature = 50 },

            -- Configuration for action windows:
            -- - `height` and `width` are maximum dimensions.
            -- - `border` defines border (as in `nvim_open_win()`; default "single").
            window = {
                info = { height = 25, width = 80, border = "single" },
                signature = { height = 25, width = 80, border = "single" },
            },

            -- Way of how module does LSP completion
            lsp_completion = {
                -- `source_func` should be one of 'completefunc' or 'omnifunc'.
                source_func = "completefunc",

                -- `auto_setup` should be boolean indicating if LSP completion is set up
                -- on every `BufEnter` event.
                auto_setup = true,

                -- A function which takes LSP 'textDocument/completion' response items
                -- (each with `client_id` field for item's server) and word to complete.
                -- Output should be a table of the same nature as input. Common use case
                -- is custom filter/sort. Default: `default_process_items`
                process_items = nil,

                -- A function which takes a snippet as string and inserts it at cursor.
                -- Default: `default_snippet_insert` which tries to use 'mini.snippets'
                -- and falls back to `vim.snippet.expand` (on Neovim>=0.10).
                snippet_insert = nil,
            },

            -- Fallback action as function/string. Executed in Insert mode.
            -- To use built-in completion (`:h ins-completion`), set its mapping as
            -- string. Example: set '<C-x><C-l>' for 'whole lines' completion.
            fallback_action = "<C-n>",

            -- Module mappings. Use `''` (empty string) to disable one. Some of them
            -- might conflict with system mappings.
            mappings = {
                -- Force two-step/fallback completions
                force_twostep = "<C-Space>",
                force_fallback = "<A-Space>",

                -- Scroll info/signature window down/up. When overriding, check for
                -- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
                -- for 'completefunc'/'omnifunc' source function; or `<C-n>`/`<C-p>`).
                -- scroll_down = "<C-f>",
                -- scroll_up = "<C-b>",
            },
        },

        config = function(_, opts)
            local comp = require("mini.completion")
            local snippets = require("mini.snippets")

            require("luasnip.loaders.from_vscode").lazy_load()

            local gen_loader = snippets.gen_loader

            local kind_priority = { Text = -1, Snippet = 99 }
            local filter_opts = { filtersort = "fuzzy", kind_priority = kind_priority }

            local process_items = function(items, base)
                return comp.default_process_items(items, base, filter_opts)
            end

            snippets.setup({
                snippets = {
                    gen_loader.from_lang(),
                },
            })

            opts.lsp_completion = {
                process_items = process_items,
            }

            comp.setup(opts)
        end,
    },
}
