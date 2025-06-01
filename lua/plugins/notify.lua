return {{
    "rcarriga/nvim-notify",
    enabled = true,
    opts = {
        background_colour = "#000000",
        stages = "fade_in_slide_out",
        timeout = 3000,
        minimum_width = 50,
        max_height = 10,
        max_width = 50,
        icons = {
            ERROR = " ",
            WARN = " ",
            INFO = " ",
            DEBUG = " ",
            TRACE = "✎ "
        },
        render = "compact"
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts) -- you must call this manually now
        vim.notify = notify
    end
}}
