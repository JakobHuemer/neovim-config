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
                enabled = true, -- Start disabled
                auto_trigger = true, -- Start with auto_trigger disabled
                keymap = {
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

            -- Global state variable
            _G.copilot_enabled = false

            -- Function to apply copilot state to current buffer
            local function apply_copilot_state()
                if _G.copilot_enabled then
                    vim.cmd("Copilot enable")
                    -- Enable suggestions for current buffer
                    -- sugg.toggle()
                    if not sugg.is_visible() then
                        -- Make sure auto_trigger is enabled when copilot is enabled
                        require("copilot.suggestion").auto_trigger = true
                    end
                else
                    vim.cmd("Copilot disable")
                    sugg.dismiss()
                    -- Disable auto_trigger when copilot is disabled
                    require("copilot.suggestion").auto_trigger = false
                end
            end

            -- Toggle function with global state persistence
            local function toggle_copilot()
                _G.copilot_enabled = not _G.copilot_enabled
                apply_copilot_state()

                -- Print status
                local status = _G.copilot_enabled and "enabled" or "disabled"
                print("Copilot " .. status .. " globally")
            end

            -- Apply state to new buffers
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
                callback = function()
                    -- Small delay to ensure copilot is ready
                    vim.defer_fn(function()
                        apply_copilot_state()
                    end, 100)
                end,
                desc = "Apply global Copilot state to new buffers",
            })

            -- Add toggle in every mode <M-c>
            vim.keymap.set({ "i", "n" }, "<M-c>", toggle_copilot, { desc = "Toggle Copilot Globally" })
        end,
    },
}
