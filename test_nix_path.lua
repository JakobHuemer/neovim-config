local vue_ls_path = vim.fn.exepath("vue-language-server")
if vue_ls_path ~= "" then
    local resolved_path = vim.fn.resolve(vue_ls_path)
    local bin_dir = vim.fn.fnamemodify(resolved_path, ":h")
    local store_dir = vim.fn.fnamemodify(bin_dir, ":h")
    print("Executable:", vue_ls_path)
    print("Resolved:", resolved_path)
    print("Store Dir:", store_dir)
    print("Plugin Path:", store_dir .. "/lib/node_modules/@vue/language-server")
else
    print("vue-language-server not found in PATH")
end
