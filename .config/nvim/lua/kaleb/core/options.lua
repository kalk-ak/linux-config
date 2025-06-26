vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- makes sure the mode is displayed
vim.o.showmode = true
-- Tabs and Indentations

opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- spaces for indent are the same as a tab
opt.softtabstop = 4
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting  new one
opt.smartindent = true
-- back space
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- [[setting options]]
-- see ':help vim.opt'
-- NOTE 	You can change these options as you wish
-- For more options, you can see ':help option-list'

-- Make line numbers default
opt.number = true
-- You can add relative line number, for help with jumping
-- Experiment to see if you like it
opt.relativenumber = true -- If off you can just jump with #D

-- Enable mouse mode, can be helpful for resizing splits for example
opt.mouse = "n"

-- Sync clipboard between Os and Neovim
-- Remove this option if you want your OS clipboard to remain independent
-- see ':help clipboard'
-- opt.clipboard:append("unnamedplus")

-- Enable break indent
-- Makes it easer to read lines that read end of screen and wrap around
-- Example:
-- def long_function_name(argument_one, argument_two,
--                        argument_three, argument_four):  # Aligned with indentation
opt.breakindent = true

-- saves undo history for each file
opt.undofile = true

-- Uses case insesetive searching
opt.ignorecase = true

-- Case sensetive searching if one or more capital letters are present
opt.smartcase = true

-- Displays sign column.
-- By default vim only shows sign columns when an error appears dynamically and this can be frustrating because the text gets misalligned
opt.signcolumn = "yes"

-- Decrease the update time (default = 4000 or 4 seconds)
-- Useful to save temporary files quicly if vim crashes
-- Useful for faster coding because vim shows auto completions and git signs quickly when you stop timing for 200 mili seconds
opt.updatetime = 200

-- Configure how new splits (windows)  should be opened. Left or right. I choose right. (command = ':vsplit', splits new window to the right)
opt.splitright = true
-- Enables splitting horizontally
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}

-- Enable spell checking
vim.opt.spell = true
-- Set spell checking language(s)
vim.opt.spelllang = { "en_us" } -- You can add more languages like "es", "fr", etc.

-- Show which line your cursor is on
opt.cursorline = true

-- Preview substitutions live, as you type! By defalult vim only shows you the substitution after you pressed enter
opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
