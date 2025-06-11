local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    defaults = {
        lazy = false,
        version = nil,
    },
    spec = { {
        import = "plugins",
    } },
    install = {
        colorscheme = { "catppuccin" },
    },
    change_detection = {
        enabled = true,
    },
    checker = {
        enabled = true,
        notify = false,
        frequency = 1800,
    },
})

-- Custom update check with single notification
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyCheck",
    callback = function()
        local updated = require("lazy.status").has_updates()
        if updated then
            local updates = require("lazy.status").updates()
            local update_key = table.concat(updates, ",")

            if not notified_updates[update_key] then
                vim.notify("Plugin updates available: " .. #updates .. " plugins", vim.log.levels.INFO)
                notified_updates[update_key] = true
            end
        end
    end,
})
