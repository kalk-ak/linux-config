return {
    "akinsho/bufferline.nvim", -- Plugin that shows a buffer/tab line at the top of the editor

    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Optional: Adds file-type icons to the tab labels using devicons
    },

    version = "*", -- Use the latest stable version of the plugin

    opts = {
        options = {
            mode = "tabs",
        },
        highlights = {
            fill = {
                bg = "#1A1B26",
            },
            background = {
                bg = "#1A1B26",
            },

            -- For the currently selected tab
            tab_selected = {
                fg = "#ffffff",
                bg = "#7AA2F7",
                bold = true,
            },

            close_button_selected = {
                fg = "#ff8080",
            },
        },
    },
}
