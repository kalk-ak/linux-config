return {
    "mfussenegger/nvim-lint", -- Lightweight linting plugin for Neovim
    -- Automatically checks your code for errors or warnings using external linters. Customize filetypes and linters below.

    event = { "BufReadPre", "BufNewFile" }, -- Load when a file is opened or created

    config = function()
        local lint = require("lint")

        -- Set which linter(s) to use per filetype
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            python = { "pylint" },
        }

        -- Create a dedicated autocmd group for linting events
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        -- Automatically run linting when entering a buffer, saving, or exiting insert mode
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        -- Manually trigger linting with <leader>l
        -- To change the keybinding, edit the line below
        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
