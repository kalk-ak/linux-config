return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        -- import mason-tool-installer
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- Ensure all relevant LSPs are installed
        mason_lspconfig.setup({
            ensure_installed = {
                -- Web Development
                "tsserver",      -- TypeScript / JavaScript LSP
                "html",          -- HTML LSP
                "cssls",         -- CSS LSP
                "tailwindcss",   -- Tailwind CSS LSP
                "svelte",        -- Svelte LSP
                "graphql",       -- GraphQL LSP
                "emmet_ls",      -- Emmet (HTML/CSS auto-completion)
                "prismals",      -- Prisma LSP
                "eslint",        -- ESLint LSP for JS/TS

                -- Lua Development
                "lua_ls",        -- Lua LSP

                -- Python Development
                "pyright",       -- Python LSP
                "ruff_lsp",      -- Python linting & formatting (alternative to pylint)

                -- System & Scripting Languages
                "bashls",        -- Bash LSP
                "dockerls",      -- Dockerfile LSP
                "yamlls",        -- YAML LSP
                "jsonls",        -- JSON LSP
                "sqls",          -- SQL LSP
                "vimls",         -- Vimscript LSP
                "lemminx",       -- XML LSP (useful for some HTML projects)

                -- C/C++ Development
                "clangd",        -- C/C++ LSP

                -- Rust Development
                "rust_analyzer", -- Rust LSP

                -- Markdown & Documentation
                "marksman",      -- Markdown LSP
                "vimls",         -- Vimscript LSP
            },
        })

        -- Ensure necessary formatters and linters are installed
        mason_tool_installer.setup({
            ensure_installed = {
                -- Formatters
                "prettier",     -- JS/TS/CSS/HTML formatter
                "stylua",       -- Lua formatter
                "isort",        -- Python formatter
                "black",        -- Python formatter

                -- Linters
                "pylint",       -- Python linter
                "eslint_d",     -- JavaScript/TypeScript linter
                "jsonlint",     -- JSON linter
                "yamllint",     -- YAML linter
                "shellcheck",   -- Bash linter
                "markdownlint", -- Markdown linter
                "sqlfluff",     -- SQL linter
            },
        })
    end,
}

