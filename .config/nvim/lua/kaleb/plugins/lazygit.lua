return {
    "kdheepak/lazygit.nvim", -- Neovim wrapper for LazyGit, a simple terminal UI for Git
    -- Use this to open a Git UI inside Neovim. Great for staging, commits, branches, and more.

    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },

    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim", -- Needed for the plugin to function correctly
    },

    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" }, -- Press <leader>lg to launch LazyGit
    },
}
