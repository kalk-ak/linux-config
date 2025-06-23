return {
    "rmagatti/auto-session", -- Plugin to automatically save and restore Neovim sessions

    config = function()
        -- Import the auto-session module
        local auto_session = require("auto-session")

        -- Configure auto-session
        auto_session.setup({
            auto_restore_enabled = false, -- Disable automatic restoration when opening Neovim (manual only)
            auto_session_suppress_dirs = {
                "~/",
                "~/Dev/",
                "~/Downloads",
                "~/Documents",
                "~/Desktop/",
            }, -- Don't save/restore sessions in these directories (usually general or temporary folders)
        })

        -- Define a shorter alias for setting keymaps
        local keymap = vim.keymap

        -- Keybindings for session control:

        -- <leader>wr: Restore the last saved session for the current working directory
        keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", {
            desc = "Restore session for cwd",
        })

        -- <leader>ws: Save the current session manually
        keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", {
            desc = "Save session for auto session root dir",
        })
    end,
}
