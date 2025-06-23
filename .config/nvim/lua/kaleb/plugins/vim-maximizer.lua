return {
    "szw/vim-maximizer", -- Simple plugin to maximize and restore splits (toggle full-screen for current window)
    -- Useful when working with multiple splits: focus on one, then toggle back to layout

    keys = {
        { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" }, -- Toggle maximized view of current split
    },
}
