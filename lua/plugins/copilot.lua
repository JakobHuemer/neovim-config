return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            "AndreM222/copilot-lualine",
        },
        opts = {
            panel = {
                enabled = false,
                auto_refresh = true,
                keymap = {},
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    -- all in insert mode
                    accept = "<M-CR>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-n>",
                    prev = "<M-p>",
                    dismiss = "<M-e>",
                },
            },
        },
        config = function(_, opts)
            local copilot = require("copilot").setup(opts)
            local sugg = require("copilot.suggestion")
            local cmp = require("cmp")

            -- add toggle in every mode <M-c>
            vim.keymap.set({ "i", "n" }, "<M-c>", function()
                vim.cmd("Copilot toggle")
                sugg.dismiss()
            end, { desc = "Toggle Copilot Panel" })

        end,
    },
}
