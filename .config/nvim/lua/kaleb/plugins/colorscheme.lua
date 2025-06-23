return {
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.	--
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

    "folke/tokyonight.nvim", -- A popular dark colorscheme for Neovim

    priority = 1000, -- Ensures this colorscheme plugin loads before all others (important for correct theming)

    config = function()
        -- Configure the Tokyonight colorscheme
        ---@diagnostic disable-next-line: missing-fields
        require("tokyonight").setup({
            styles = {
                comments = { italic = true }, -- Make comments appear in italics for better readability
            },
        })
        -- Apply the specific variant of the colorscheme
        vim.cmd.colorscheme("tokyonight-night") -- Options include "tokyonight", "tokyonight-night", "tokyonight-storm", etc.
    end,
}
