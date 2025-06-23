return {
    "numToStr/Comment.nvim", -- Plugin to easily toggle comments in code (like `gcc` to comment a line)

    event = { "BufReadPre", "BufNewFile" }, -- Lazy-load the plugin when opening or creating a file

    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring", -- Helps handle context-aware comment strings for mixed-language files (e.g., JSX, Vue, HTML)
    },

    config = function()
        -- import comment plugin safely
        local comment = require("Comment")

        -- import the integration with ts-context-commentstring
        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

        -- enable comment
        comment.setup({
            -- for commenting tsx, jsx, svelte, html files
            pre_hook = ts_context_commentstring.create_pre_hook(),
            -- This hook uses treesitter to determine the correct comment string based on cursor position
            -- For example, `<!-- -->` in HTML and `{/* */}` in JSX within the same file
        })
    end,
}
