return { {
    "rcarriga/nvim-notify",
    enabled = true,
    opts = {
        stages = "static",
        -- IMPORTANT: the icons have a special formattings with spaces
        --              DO NOT REMOVE
        icons = {
            ERROR = " ",
            WARN = " ",
            INFO = " ",
            DEBUG = " ",
            TRACE = " ✎"
        },
        render = "compact",
        -- make notification last 3 seconds
        timeout = 5000,
        fps = 45
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)
        vim.notify = notify
    end
} }
