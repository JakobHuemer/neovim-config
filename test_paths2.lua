local vue_ls_path = vim.fn.exepath("vue-language-server")
if vue_ls_path ~= "" then
    local resolved_path = vim.fn.resolve(vue_ls_path)
    local bin_dir = vim.fn.fnamemodify(resolved_path, ":h")
    local store_dir = vim.fn.fnamemodify(bin_dir, ":h")

    local paths = {
        store_dir .. "/lib/language-tools/packages/language-server",
        store_dir .. "/lib/node_modules/@vue/language-server",
    }

    for _, p in ipairs(paths) do
        print("Checking:", p, vim.fn.isdirectory(p))
        if vim.fn.isdirectory(p) == 1 then
            print("Found:", p)
        end
    end
end
