return {
    "lukas-reineke/indent-blankline.nvim", -- Shows vertical lines to indicate indentation levels
    -- Helps visualize code structure. To change the line style, edit `char` below.

    event = { "BufReadPre", "BufNewFile" }, -- Load when opening or creating a file

    main = "ibl", -- Use the new `ibl` module (modern interface for indent-blankline)

    opts = {
        indent = { char = "┊" }, -- Character used to show indent levels (you can change it to "|", "│", etc.)
    },
}
