return {
    {
        "lewis6991/gitsigns.nvim", -- Shows Git changes (add/delete/change) in the sign column and allows Git actions
        -- Adds git indicators and shortcuts for staging/resetting changes. To customize keymaps, edit the `map(...)` lines below.

        event = { "BufReadPre", "BufNewFile" }, -- Load when opening or creating a file

        opts = {
            on_attach = function(bufnr)
                local gs = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                -- 🔀 Navigation
                -- nav between Git hunks (chunks of changes)
                map("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
                map("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })

                -- nav between Git Changes
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, { desc = "Jump to next git [c]hange" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, { desc = "Jump to previous git [c]hange" })

                --Actions
                --Visual Mode
                map("v", "<leader>hs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) -- stage selected lines in visual mode
                end, { desc = "Stage selected hunk lines" })

                map("v", "<leader>hr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) -- reset selected lines in visual mode
                end, { desc = "Reset selected hunk lines" })

                -- Git Actions
                -- actions on current hunk
                map("n", "<leader>hs", gs.stage_hunk, { desc = "git [s]tage hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "git [r]eset hunk" })

                -- 🌐 Stage/reset all changes in buffer
                map("n", "<leader>hS", gs.stage_buffer, { desc = "git [S]tage buffer" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "git [R]eset buffer" })

                -- ↩️ Undo a staged hunk
                map("n", "<leader>hu", gs.stage_hunk, { desc = "git [u]ndo stage hunk" })

                -- 👀 Preview the diff of the current hunk
                map("n", "<leader>hp", gs.preview_hunk, { desc = "git [p]review hunk" })

                -- 🕵️ Show Git blame info for the current line
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true }) -- full git commit info
                end, { desc = "git [B]lame line" })

                --  View file diffs
                map("n", "<leader>hd", gs.diffthis, { desc = "git [d]iff against index" })
                map("n", "<leader>hD", function()
                    gs.diffthis("@")
                end, { desc = "git [D]iff against last commit" })

                --  Git text object for selecting hunks
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Git hunk as text object" })

                -- Toggles
                map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
                map("n", "<leader>htd", gs.preview_hunk_inline, { desc = "[T]oggle git show [d]eleted" })
            end,
        },
    },
}
