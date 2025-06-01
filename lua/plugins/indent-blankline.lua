-- Define your colors in a single table
-- local colors = {"#1A94E2", "#1AF5C2", "#1A9D78", "#1A76B9", "#1AB0D4", "#1AE7A8"}
local colors = {
    "#f38ba8", -- Pink
    "#fab387", -- Peach
    "#f9e2af", -- Yellow
    "#a6e3a1", -- Green
    "#94e2d5", -- Teal
    "#89b4fa", -- Blue
    "#cba6f7", -- Mauve
    "#f2cdcd" -- Flamingo
}
local current_scope_color = "#FF0000"
local fg_opacity = 0.4
local bg_opacity = 0.1

-- Generate highlight group names dynamically
local highlight = {}
for i = 1, #colors do
    table.insert(highlight, "IndentBlanklineColor" .. i)
end

return {{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "╎",
            tab_char = "h",
            highlight = highlight,
            smart_indent_cap = true
        },
        whitespace = {
            highlight = highlight,
            remove_blankline_trail = false
        },
        scope = {
            highlight = "IndentBlanklineCurrentScore",
            injected_languages = true,
            char = "│"
        }
    },
    lazy = false,
    config = function(_, opts)
        local hooks = require "ibl.hooks"

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            -- Dynamically create highlight groups from colors table
            for i, color in ipairs(colors) do
                vim.api.nvim_set_hl(0, "IndentBlanklineColor" .. i, {
                    fg = color,
                    bg = color
                })
            end
        end)

        vim.api.nvim_set_hl(0, "IndentBlanklineCurrentScore", {
            fg = current_scope_color
        })

        require("ibl").setup(opts)
    end
}}
