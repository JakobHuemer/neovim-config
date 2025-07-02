-- delete full lines in visual selection
vim.keymap.set("x", "<leader>D", ":'<,'>d<CR>", { desc = "Delete full lines in visual selection" })

-- lsp rename
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

vim.keymap.set("n", "gi", function()
    vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "LSP diagnostic popup" })


-- remove unused imports
vim.keymap.set("n", "<leader>gru", function()
    vim.lsp.buf.code_action({
        apply = true,
        context = {
            only = { "source.removeUnused.ts" },
            diagnostics = {},
        },
    })
end, { desc = "Remove unused imports" })


-- hide hlsearch in normal mode with double escape
local esc_timer = nil
local esc_timeout = 250  -- milliseconds

vim.keymap.set('n', '<Esc>', function()
  if esc_timer then
    esc_timer:stop()
    esc_timer:close()
    esc_timer = nil

    -- Double Esc detected
    if vim.v.hlsearch == 1 then
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })

      if buftype == '' and filetype ~= 'TelescopePrompt' then
        vim.cmd('nohlsearch')
      end
    end
  else
    -- First Esc: start timer, allow default behavior
    esc_timer = vim.loop.new_timer()
    esc_timer:start(esc_timeout, 0, vim.schedule_wrap(function()
      esc_timer:close()
      esc_timer = nil
    end))
    -- Immediately send Esc to behave normally
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  end
end, { noremap = true, silent = true })

--
