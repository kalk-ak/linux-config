return {
    "kylechui/nvim-surround", -- Easily add, delete, or change surrounding characters (quotes, brackets, etc.)

    -- TODO: Learn how this works on youtube

    -- Lets you do things like change `"hello"` to `'hello'`, or wrap text in `()` or `<tag>`

    event = { "BufReadPre", "BufNewFile" }, -- Load when opening or creating a file

    version = "*", -- Use for stability; omit to use `main` branch for the latest features

    config = true, -- Uses default configuration; change to `config = function() ... end` to customize
}
