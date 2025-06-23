return {
    "folke/which-key.nvim", -- Displays a popup with possible keybindings as you type
    -- Helps you learn keymaps, discover shortcuts, and avoid keybinding conflicts

    event = "VeryLazy", -- Load when idle (non-critical time) to speed up startup

    init = function()
        vim.o.timeout = true -- Enable timeout for mapped sequences
        vim.o.timeoutlen = 500 -- Wait 500ms before showing the which-key popup
    end,

    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration below
        --
        -- Example:
        -- plugins = {
        --   marks = true,
        --   registers = true,
        --   spelling = {
        --     enabled = true,
        --     suggestions = 20,
        --   },
        -- },
        -- window = {
        --   border = "single",
        -- },
    },
}
