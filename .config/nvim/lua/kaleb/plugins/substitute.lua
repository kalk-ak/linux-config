return {
    "gbprod/substitute.nvim", -- Plugin for quick substitution similar to `change` but keeps content in place
    -- Lets you replace text using motions like `cw`, `s}`, etc. without affecting the layout/indentation

    event = { "BufReadPre", "BufNewFile" }, -- Load the plugin on file open or creation

    config = function()
        local substitute = require("substitute")

        substitute.setup() -- Initialize plugin with default settings

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        -- first unbound s
        vim.api.nvim_set_keymap("n", "s", "<NOP>", { noremap = true, silent = true }) -- unbind default 's' (which deletes a character)

        -- set s + motion to change words
        -- These mappings let you substitute text similarly to how you'd use 'd' or 'c':
        keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" }) -- e.g. `siw` to substitute inner word
        keymap.set("n", "ss", substitute.line, { desc = "Substitute line" }) -- replaces the whole line
        keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" }) -- replaces from cursor to end of line
        keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" }) -- replaces selection in visual mode
    end,
}
