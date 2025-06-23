return {
    -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim", -- Powerful fuzzy finder for files, symbols, help, diagnostics, and more

    event = "VimEnter", -- Load on startup for immediate access to search tools

    branch = "0.1.x", -- Use stable branch

    dependencies = {
        "nvim-lua/plenary.nvim", -- Required utility library for Telescope to work

        "folke/todo-comments.nvim", -- Optional: integrates TODO comments into Telescope via `<leader>ft`

        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            "nvim-telescope/telescope-fzf-native.nvim", -- Native FZF sorter for faster search results

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = "make",

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable("make") == 1 -- Only load if `make` is available (required to compile native code)
            end,
        },

        { "nvim-telescope/telescope-ui-select.nvim" }, -- Makes Telescope work nicely with `vim.ui.select()` (e.g., LSP pickers)

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- Icons for file types (only loads if nerd font is available)
    },

    -- edit the configration
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" }, -- Clean up long file paths
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to the previous result
                        ["<C-j>"] = actions.move_selection_next, -- move to the next result

                        -- send selected items to quick fix list
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        -- Load extra extensions for faster search and prettier UI
        telescope.load_extension("fzf") -- Native fuzzy search performance boost
        telescope.load_extension("ui-select") -- Use Telescope as UI selector (e.g., for LSP or code actions)

        -- set keymaps
        local keymap = vim.keymap

        -- See `:help telescope.builtin` for more available functions
        local builtin = require("telescope.builtin")

        -- Keybindings to launch different Telescope pickers
        keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" }) -- Search Neovim help
        keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" }) -- Search all keymaps
        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" }) -- Search files in cwd
        keymap.set("n", "<leader>fx", builtin.builtin, { desc = "search select Telescope" }) -- Search Telescope functions
        keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord under cursor" }) -- Search current word
        -- make sure grep is installed first
        keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" }) -- Live grep through files
        keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" }) -- Show LSP diagnostics
        keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" }) -- Resume last Telescope search
        keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "[F]ind [T]odo's" }) -- Show TODO comments
        keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' }) -- Open recent files
        keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" }) -- Search open buffers
        keymap.set(
            "n",
            "<leader>fs",
            "<cmd>Telescope lsp_document_symbols<CR>",
            { -- search for declared symbols in current script
                noremap = true,
                silent = true,
                desc = "[F]ind [s]ymbols in current file (LSP)",
            }
        )
    end,
}
