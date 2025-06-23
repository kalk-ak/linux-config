return {
    "nvim-tree/nvim-tree.lua", -- File explorer sidebar for Neovim
    -- Provides a visual file tree with Git integration and icons. Use <leader>e* to toggle and control it.

    dependencies = "nvim-tree/nvim-web-devicons", -- Adds icons to files and folders

    config = function()
        local nvimtree = require("nvim-tree")

        -- recomended settings from nvim-documentation
        vim.g.loaded_netrw = 1 -- Disable netrw (default file explorer)
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = {
                width = 35, -- Width of the file explorer window
                relativenumber = false, -- Disable relative line numbers
            },

            -- change folder arrow icons
            renderer = {
                indent_markers = {
                    enable = true, -- Show indent markers to indicate folder structure
                },
            },

            -- disable window_picker for
            -- explorer to work well with
            -- window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false, -- Don't prompt to pick a window when opening files
                    },
                },
            },

            filters = {
                custom = { ".DS_Store" }, -- Hide macOS system files
            },

            git = {
                ignore = false, -- Show all files including those ignored by Git
            },
        })

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
        keymap.set(
            "n",
            "<leader>ef",
            "<cmd>NvimTreeFindFileToggle<CR>",
            { desc = "Toggle file explorer on current file" }
        ) -- toggle file explorer on current file
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

        keymap.set("n", "<leader>ej", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
    end,
}
