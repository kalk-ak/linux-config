return {
    "goolord/alpha-nvim", -- Startup dashboard plugin for Neovim
    -- Shows a welcome screen with custom header and buttons when you open Neovim. To change buttons or header, edit below.

    event = "VimEnter", -- Load dashboard when Neovim starts

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set custom highlight for the header text (bright blue and bold)
        vim.api.nvim_set_hl(0, "DashboardHeader", {
            fg = "#57B9FF", -- color code
            bold = true,
        })

        -- Set ASCII art header displayed at the top of the dashboard
        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }

        -- Apply color and center the header text
        dashboard.section.header.opts = {
            hl = "DashboardHeader", -- Use the highlight group we defined
            position = "center", -- Center the header on the screen
        }

        -- Define menu buttons for quick access to common actions
        -- You can add, remove, or customize buttons here
        dashboard.section.buttons.val = {
            dashboard.button("e", "    New File", "<cmd>ene<CR>"),
            dashboard.button("SPC ee", "    Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
            dashboard.button("SPC ff", "󰱼    Find File", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fw", "    Find Word", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("SPC wr", "󰁯    Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
            dashboard.button("q", "    Quit NVIM", "<cmd>qa<CR>"),
        }

        -- Finalize and apply the dashboard configuration
        alpha.setup(dashboard.opts)

        -- Disable code folding on the dashboard screen
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
