return { -- Autocompletion
    "hrsh7th/nvim-cmp", -- Main autocompletion engine
    -- Shows suggestions while typing in insert mode. Highly extensible with various sources.

    event = "InsertEnter", -- Load autocompletion when entering insert mode

    dependencies = {
        -- snippet engine & its associated nvim-cmp source
        {
            "L3MON4D3/LuaSnip", -- Powerful snippet engine
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load() -- Load all vscode-style snippets
                    end,
                },
            },
        },

        "saadparwaiz1/cmp_luasnip", -- Add LuaSnip as a source for nvim-cmp

        -- adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. they are split
        --  into multiple repos for maintenance purposes.
        "hrsh7th/cmp-nvim-lsp", -- Completion from LSP
        "hrsh7th/cmp-buffer", -- Completion from current file content
        "hrsh7th/cmp-path", -- Completion for file paths
        "hrsh7th/cmp-nvim-lsp-signature-help", -- Inline function signature help
        "onsails/lspkind.nvim", -- vs-code like pictograms in autocomplete menu
    },

    config = function()
        -- See `:help cmp`
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        luasnip.config.setup({})

        cmp.setup({
            snippet = {
                -- Configure how snippets are expanded when selected
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            completion = { completeopt = "menu,menuone,noinsert" }, -- How the completion behaves

            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            --
            -- No, but seriously. Please read `:help ins-completion`, it is really good!
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ["<C-j>"] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<C-k>"] = cmp.mapping.select_prev_item(),

                -- Scroll the documentation window [b]ack / [f]orward
                -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                -- ['<C-f>'] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                -- ['<C-y>'] = cmp.mapping.confirm { select = true },

                -- If you prefer more traditional completion keymaps,
                -- you can uncomment the following lines
                ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Use <Tab> to confirm selection
                -- ['<Tab>'] = cmp.mapping.select_next_item(),
                -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end

                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            }),

            -- Completion sources
            sources = {
                {
                    name = "lazydev",
                    -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                    group_index = 0,
                },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lsp_signature_help" },
            },

            -- Add icons and formatting to suggestions
            formating = {
                format = lspkind.cmp_format({
                    maxwidth = 50, -- Truncate long labels
                    ellipsis_char = "...",
                }),
            },
        })
    end,
}
