return {
    "folke/todo-comments.nvim", -- Highlights and searches TODO/FIXME/NOTE comments in code
    -- Useful for tracking tasks, warnings, or reminders right in your code. Also integrates with Telescope.

    event = { "BufReadPre", "BufNewFile" }, -- Load on file open or new file creation

    dependencies = { "nvim-lua/plenary.nvim" }, -- Required by many plugins, provides async utilities

    config = function()
        local todo_comments = require("todo-comments")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        -- Go to the next TODO-style comment (e.g. TODO, FIX, HACK, etc.)
        keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next todo comment" })

        -- Go to the previous TODO-style comment
        keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous todo comment" })

        -- Default keywords that will be highlighted:
        -- TODO      - general task
        -- FIX       - something broken (aliases: FIXME, BUG)
        -- HACK      - workaround or dirty fix
        -- WARN      - caution or potential issue (alias: WARNING)
        -- PERF      - performance issue (aliases: OPTIM, OPTIMIZE)
        -- NOTE      - general notes or important context
        -- TEST      - test-related code (aliases: TESTING)

        todo_comments.setup() -- Initialize plugin with default settings
    end,
}
