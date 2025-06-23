return { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter", -- Modern syntax highlighting and code navigation using Treesitter
    -- Provides better syntax awareness than traditional regex-based highlighting

    build = ":TSUpdate", -- Automatically update parsers after install

    main = "nvim-treesitter.configs", -- Sets main module to use for `opts`

    event = { "BufReadPre", "BufNewFile" }, -- Load Treesitter when opening or creating a file

    dependencies = {
        "windwp/nvim-ts-autotag", -- Automatically close and rename HTML/JSX tags
    },

    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({
            -- enable syntax highlighting
            highlight = {
                enable = true,
            },

            -- enable auto indentation based on syntax
            indent = {
                enable = true,
            },

            -- enable autotagging (w/ nvim-ts-autotag plugin)
            -- Automatically closes and renames paired tags in HTML, JSX, etc.
            autotag = {
                enable = true,
            },

            -- ensure these language parsers are installed
            ensure_installed = {
                "json",
                "javascript",
                "typescript",
                "python",
                "rust",
                "sql",
                "tsx",
                "yaml",
                "html",
                "css",
                "prisma",
                "markdown",
                "markdown_inline",
                "bash",
                "lua",
                "luadoc",
                "vim",
                "dockerfile",
                "gitignore",
                "vimdoc",
                "c",
                "cpp",
            },

            -- incremental selection lets you expand or shrink code selection by syntax nodes
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>", -- Start selection
                    node_incremental = "<C-space>", -- Expand to next syntax node
                    scope_incremental = false, -- (Optional) Expand by scope (like function or block)
                    node_decremental = "<bs>", -- Shrink to previous syntax node
                },
            },
        })
    end,
}
