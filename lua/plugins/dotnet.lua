return {
    "GustavEikaas/easy-dotnet.nvim",
    ft = { "cs" },
    dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
    keys = {
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue / attach" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
        { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
        { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate session" },
        { "<F5>", function() require("dap").continue() end, desc = "Continue / attach" },
        { "<F10>", function() require("dap").step_over() end, desc = "Step over" },
        { "<F11>", function() require("dap").step_into() end, desc = "Step into" },
        { "<F12>", function() require("dap").step_out() end, desc = "Step out" },
    },
    config = function()
        require("easy-dotnet").setup({
            debugger = { bin_path = vim.fn.exepath("netcoredbg") },
        })
    end,
}
