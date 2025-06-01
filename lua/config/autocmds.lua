-- `autocmd` is `vim.api.nvim_create_autocmd` and `augroup` is the same as in the link you provided
autocmd("VimEnter", {
    group = augroup("autoupdate"),
    callback = function()
        require("lazy").update({
            show = false
        })
    end
})
