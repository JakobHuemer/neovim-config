return {
    "lewis6991/hover.nvim",
    config = function()
        require("hover").config({
            providers = {
                "hover.providers.diagnostic",
                "hover.providers.lsp",
                "hover.providers.dap",
                "hover.providers.man",
                -- "hover.providers.gh",
                -- "hover.providers.highlight",
                -- "hover.providers.dictionary",
            },
            preview_opts = {
                border = "rounded",
            },
            preview_window = false,
            title = true,
        })

        -- hover.nvim forces the float buffer to filetype markdown (util.lua:373),
        -- so no LSP ever attaches to it and gD inside the float does nothing.
        -- Put the source filetype back on the float so the server attaches via
        -- the FileType autocmd from vim.lsp.enable. Trade-off: markdown renders
        -- raw (### and backticks are visible) instead of prettified.
        --
        -- Wrapping open() rather than using a FileType autocmd: assigning the
        -- filetype fires FileType with the float already the current buffer, so
        -- the source filetype is not readable from inside the autocmd.
        local hover = require("hover")
        local open = hover.open

        --- The float window tags itself via vim.w[winid].hover_preview.
        local function find_float()
            for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                if vim.w[winid].hover_preview == winid then
                    return winid
                end
            end
        end

        hover.open = function(...)
            local ft = vim.bo.filetype
            open(...)

            if ft == "" or ft == "markdown" then
                return
            end

            -- Providers resolve asynchronously, so poll for the float. The
            -- filetype is assigned on a later tick than hover.nvim's own
            -- vim.treesitter.start(), which needs to see markdown -- starting it
            -- against a language with no installed parser throws.
            local tries = 0
            local function apply()
                tries = tries + 1
                local winid = find_float()
                if not winid then
                    if tries < 20 then
                        vim.defer_fn(apply, 25)
                    end
                    return
                end

                local buf = vim.api.nvim_win_get_buf(winid)
                if vim.bo[buf].filetype == "markdown" then
                    vim.bo[buf].filetype = ft
                end
            end
            vim.defer_fn(apply, 25)
        end
    end,
}

