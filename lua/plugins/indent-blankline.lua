-- Define your colors in a single table
local colors = {
    "#f38ba8", -- Pink
    "#fab387", -- Peach
    "#f9e2af", -- Yellow
    "#a6e3a1", -- Green
    "#94e2d5", -- Teal
    "#89b4fa", -- Blue
    "#cba6f7", -- Mauve
    "#f2cdcd", -- Flamingo
}
local current_scope_color = "white"
local highlight = {}
for i = 1, #colors do
    table.insert(highlight, "indents.IndentBlanklineColor" .. i)
end

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "▏",
                highlight = highlight,
                smart_indent_cap = true,
            },
            scope = {
                highlight = "indents.IndentBlanklineCurrentScore",
                injected_languages = true,
                char = "▏",
            },
        },
        lazy = false,
        config = function(_, opts)
            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                for i, color in ipairs(colors) do
                    vim.api.nvim_set_hl(0, "indents.IndentBlanklineColor" .. i, {
                        fg = color,
                    })
                end
                vim.api.nvim_set_hl(0, "indents.IndentBlanklineCurrentScore", {
                    fg = current_scope_color,
                })
            end)

            require("ibl").setup(opts)
        end,
    },
}
