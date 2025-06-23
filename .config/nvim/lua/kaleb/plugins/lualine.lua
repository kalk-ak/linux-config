return {
    "nvim-lualine/lualine.nvim", -- Statusline plugin for Neovim
    -- Adds a customizable and themed statusline at the bottom of the editor

    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: enables file type icons in the statusline

    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to show plugin updates in the statusline

        -- Tokyo Night Color Palette (used to style the statusline)
        local colors = {
            blue = "#7aa2f7",
            green = "#9ece6a",
            violet = "#bb9af7",
            yellow = "#e0af68",
            red = "#f7768e",
            fg = "#c0caf5",
            bg = "#1a1b26",
            inactive_bg = "#292e42",
            dark = "#1A1B26",
        }

        -- Define custom color theme for different modes (normal, insert, visual, etc.)
        local my_lualine_theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.dark, gui = "bold" },
                b = { bg = colors.dark, fg = colors.fg },
                c = { bg = colors.dark, fg = colors.fg },
            },
            insert = {
                a = { bg = colors.green, fg = colors.dark, gui = "bold" },
                b = { bg = colors.dark, fg = colors.fg },
                c = { bg = colors.dark, fg = colors.fg },
            },
            visual = {
                a = { bg = colors.violet, fg = colors.dark, gui = "bold" },
                b = { bg = colors.dark, fg = colors.fg },
                c = { bg = colors.dark, fg = colors.fg },
            },
            command = {
                a = { bg = colors.yellow, fg = colors.dark, gui = "bold" },
                b = { bg = colors.dark, fg = colors.fg },
                c = { bg = colors.dark, fg = colors.fg },
            },
            replace = {
                a = { bg = colors.red, fg = colors.dark, gui = "bold" },
                b = { bg = colors.dark, fg = colors.fg },
                c = { bg = colors.dark, fg = colors.fg },
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.fg },
                c = { bg = colors.inactive_bg, fg = colors.fg },
            },
        }

        -- Configure lualine with custom theme and sections
        lualine.setup({
            options = {
                theme = my_lualine_theme, -- Apply the custom Tokyo Night-style theme
            },
            sections = {
                -- Right side of the statusline (X section)
                lualine_x = {
                    {
                        lazy_status.updates, -- Show number of available plugin updates
                        cond = lazy_status.has_updates, -- Only show when updates exist
                        color = { fg = colors.yellow },
                    },
                    { "encoding" }, -- Show file encoding (e.g. UTF-8)
                    { "fileformat" }, -- Show line ending format (e.g. unix, dos)
                    { "filetype" }, -- Show file type (e.g. lua, python)
                },
            },
        })
    end,
}
