-- set <space> as the leader key
-- see ':help mapleader' NOTE
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "

local keymap = vim.keymap -- for consiseness
vim.g.maplocalleader = " "

-- Ensure <Space> is only used as <Leader> and NOT for movement
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, noremap = true })

-- Unbind `s` in normal mode
vim.api.nvim_set_keymap("n", "s", "<NOP>", { noremap = true, silent = true })

-- Unbind `s` in visual mode
-- vim.api.nvim_set_keymap("v", "s", "<NOP>", { noremap = true, silent = true })

-- Unbind `s` in operator-pending mode
--- vim.api.nvim_set_keymap("o", "s", "<NOP>", { noremap = true, silent = true })

-- s in visual mode changes selected text
-- vim.api.nvim_set_keymap("v", "s", ":'<,'>s///g<Left><Left>", { noremap = true, silent = false })

-- Easy exit normal mode
keymap.set("i", "<C-]>", "<ESC>", { desc = "Exit insert mode with CTRL-j" })

-- Tab and untab all selected texts
-- Tab and Shift-Tab to indent/unindent in visual mode
-- Custom Tab behavior to align to the next multiple of `shiftwidth`
vim.api.nvim_set_keymap(
    "v",
    "<Tab>",
    ":'<,'>execute 'normal! '.(&shiftwidth - virtcol('.') % &shiftwidth).'i '<CR>gv",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "v",
    "<S-Tab>",
    ":'<,'>execute 'normal! '.(virtcol('.') % &shiftwidth == 0 ? &shiftwidth : virtcol('.') % &shiftwidth).'di'<CR>gv",
    { noremap = true, silent = true }
)

-- if you have something searched, that word would be highlighted right. To stop the highlighting just press ESC or CTRL-C to erase the highlilgh
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- set control + e to open the explorer
keymap.set("n", "<C-e>", ":Explore<CR>", { desc = "Open explorer" })

-- System copy
-- Normal mode: Y copies the whole line to system clipboard (like `yy`)
vim.keymap.set("n", "Y", '"+yy', { desc = "Yank line to system clipboard" })

-- Visual mode: Y copies selection to system clipboard (like `y`)
vim.keymap.set("v", "Y", '"+y', { desc = "Yank selection to system clipboard" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- When you press Leader key in normal mode (space key) you get to see errors and warning from your LSP.
-- When you press space this function is vim.diagnostic.setloclist() is run
-- Comunicates With the Langauage server protocol which is downloaded for potential errors, warnings or autocompletions
-- Diagnostic keymaps
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all termiual emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- sure I accept the tip
keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>') -- ✅ Correct
keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- use the leader key + s + {v, h, e, x} to split windows vertically, horizontally, equaly, and to close the current split
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Split window equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- use the leader key + t + {o, x, n, p, f} to manipulate the tab
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- opens a new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- closes the current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to the next tab" }) -- changes the view to the next tab in the buffer
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to the previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- creats a copy of the current tab
-- Keybinds to make split navigation easier.
-- By defualt I have to press Contro W + control hihk to switch window but now made it faster by just using the control + hijk
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Inserts a new line when leader + o is pressed
-- commented because the same thing can be achived with ] + <space>
--vim.keymap.set("n", "<leader>o", "o<esc>", { desc = "insert new line below and stay in normal mode" })

-- File: ~/.config/nvim/init.lua (or a file required by it)

-- Map <Leader>i to insert a single character before the cursor.
-- After pressing <Leader>i, it waits for your next keypress.
-- That key is then inserted, and you are immediately returned to Normal mode.
-- Map <Leader>i to insert a single character and immediately return to Normal mode.
vim.keymap.set("n", "<leader>i", function()
    -- Get one character of input from the user
    local char_code = vim.fn.getchar()

    -- If the user presses <Esc> during the wait, do nothing
    if char_code == 27 then
        return
    end

    -- Convert the keypress code to a character string
    local char_to_insert = vim.fn.nr2char(char_code)

    -- Construct the sequence of keys to simulate:
    -- 'i'         => enter insert mode
    -- {char}      => the character you typed
    -- '<Esc>'     => the Escape key
    local keys_to_feed = "i" .. char_to_insert .. "<Esc>"

    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(keys_to_feed, true, false, true),
        "m", -- 'm' mode allows remapping and simulates typed input
        false -- 'false' tells feedkeys not to re-escape special characters
    )
end, {
    noremap = true,
    silent = true,
    desc = "Insert single character and return to Normal mode",
})
