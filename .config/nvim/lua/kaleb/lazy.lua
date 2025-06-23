local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- [[ Install `lazy.nvim` plugin manager ]]
-- If lazy vim is not installed then it would install it
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--------------------------------------------- Auto Commands -------------------------------------------------------------
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- Flashes the text that was recently copied with color
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Disable comment continuation on new lines
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        -- Remove 'o' and 'r' from formatoptions to stop auto-inserting comment on new line
        vim.opt_local.formatoptions:remove({ "o", "r" })
    end,
})

-- import all the lua scripts in the plugins module and lsp module
require("lazy").setup({ { import = "kaleb.plugins" }, { import = "kaleb.plugins.lsp" } }, {
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})
