return {
    "stevearc/conform.nvim", -- Code formatter plugin for many languages
    -- Automatically formats your code on save or with <leader>mp.
    -- To change which formatter is used, update `formatters_by_ft` below.
    -- To change the shortcut or formatting behavior, edit the keymap near the bottom.

    event = { "BufReadPre", "BufNewFile" }, -- Load plugin when opening or creating a file

    config = function()
        local conform = require("conform")

        conform.setup({
            -- Set formatter(s) to use per filetype
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
                c = { "clang_format" },
                cpp = { "clang_format" },
            },

            -- Auto format files on save
            format_on_save = {
                lsp_fallback = true, -- Use LSP formatting if no specific formatter is configured
                async = false, -- Wait for formatting to finish before saving
                timeout_ms = 1000, -- Stop formatting if it takes longer than 1 second
            },
        })

        -- Press <leader>mp to manually format the current file or selected text
        -- To change the shortcut or behavior, edit this keymap
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
