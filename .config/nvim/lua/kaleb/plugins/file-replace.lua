return {
    "nvim-lua/plenary.nvim", -- Required dependency for this command
    lazy = false, -- Force load immediately so the command is registered
    config = function()
        vim.api.nvim_create_user_command("RenameFile", function()
            -- Get the full path of the current file
            local old_name = vim.api.nvim_buf_get_name(0)
            if old_name == "" then
                vim.notify("Current buffer is not associated with a file!", vim.log.levels.ERROR)
                return
            end
            -- Ensure we're in a normal file buffer (not a nofile, help, or prompt buffer)
            if vim.bo.buftype ~= "" then
                vim.notify(
                    "Current buffer is not a normal file (buftype: " .. vim.bo.buftype .. ")",
                    vim.log.levels.ERROR
                )
                return
            end

            -- Get the directory of the current file and the file's name (basename)
            local dir = vim.fn.fnamemodify(old_name, ":h")
            local default_new = vim.fn.fnamemodify(old_name, ":t")

            -- Prompt the user for the new filename; default is the current filename
            vim.ui.input({ prompt = "New filename: ", default = default_new }, function(new_name)
                -- Check if new_name is nil, empty, or only whitespace
                if not new_name or new_name:match("^%s*$") then
                    vim.notify("Empty filename entered. Rename aborted.", vim.log.levels.WARN)
                    return
                end

                -- Construct the new full path so the file remains in the same directory
                local new_path = dir .. "/" .. new_name

                -- Check if the new filename is the same as the current filename
                if new_path == old_name then
                    vim.notify("New filename is the same as the current one. Rename aborted.", vim.log.levels.WARN)
                    return
                end

                local esc_new = vim.fn.fnameescape(new_path)

                -- Save the buffer as the new file, delete the old file, and reopen the new file
                vim.cmd("saveas " .. esc_new)
                vim.fn.delete(old_name)
                vim.cmd("edit " .. esc_new)

                -- Notify all attached LSP clients (if they support it) so they can update import/include references
                local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                for _, client in ipairs(clients) do
                    if client.supports_method("workspace/willRenameFiles") then
                        client.request(
                            "workspace/willRenameFiles",
                            {
                                files = {
                                    {
                                        oldUri = vim.uri_from_fname(old_name),
                                        newUri = vim.uri_from_fname(new_path),
                                    },
                                },
                            },
                            -- Provide a simple handler to catch errors
                            function(err, result, context, config)
                                if err then
                                    vim.notify("Error updating rename: " .. vim.inspect(err), vim.log.levels.WARN)
                                end
                            end,
                            0
                        )
                    end
                end
            end)
        end, { desc = "Rename file and update LSP references (preserves directory)" })
    end,
}
