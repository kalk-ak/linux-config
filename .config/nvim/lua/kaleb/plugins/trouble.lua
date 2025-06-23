return {
    "folke/trouble.nvim", -- A better UI for lists like diagnostics, quickfix, and TODOs
    -- Provides a toggleable window that shows errors, warnings, TODOs, etc., in a readable format

    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Adds icons to the list
        "folke/todo-comments.nvim", -- Enables displaying TODO/FIXME/NOTE in the Trouble UI
    },

    opts = {
        focus = true, -- Focus the Trouble window when opened
    },

    cmd = "Trouble", -- Lazy-load on running :Trouble

    -- Keybindings for toggling different Trouble views
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open/close trouble list" }, -- Show all diagnostics
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" }, -- Show workspace-wide diagnostics
        {
            "<leader>xd",
            "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "Open trouble document diagnostics",
        }, -- Show diagnostics for current file
        { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" }, -- Show quickfix list
        { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" }, -- Show location list
        { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" }, -- Show TODO comments from todo-comments.nvim
    },
}
