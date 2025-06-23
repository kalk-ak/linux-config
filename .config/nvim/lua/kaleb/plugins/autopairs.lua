return {
    {
        "windwp/nvim-autopairs", -- Plugin for auto-inserting matching pairs
        event = { "InsertEnter" }, -- Load when entering Insert mode
        dependencies = {
            "hrsh7th/nvim-cmp", -- Completion engine
            "L3MON4D3/LuaSnip", -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- nvim-cmp source for LuaSnip
        },
        config = function()
            -------------------------------
            -- 1. Setup nvim-autopairs
            -------------------------------
            local autopairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            autopairs.setup({
                check_ts = true, -- Enable Treesitter for context-aware pairing
                ts_config = {
                    lua = { "string" },
                    javascript = { "template_string" },
                    java = false,
                },
                fast_wrap = {}, -- Enable fast wrapping
                map_cr = true, -- Map <CR> for smart newline handling inside pairs
            })

            -- Rule for angle brackets: if a closing ">" is already present,
            -- pressing ">" moves the cursor over it.
            autopairs.add_rules({
                Rule("<", ">"):with_move(function(opts)
                    return opts.next_char == ">"
                end):use_key(">"),
            })

            -- Rule for commas: if a comma is already present,
            -- pressing "," overjumps it.
            autopairs.add_rules({
                Rule(",", ""):with_move(function(opts)
                    return opts.next_char == ","
                end):use_key(","),
            })

            -------------------------------
            -- 2. Setup nvim-cmp integration for autopairs
            -------------------------------
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done({
                    map_char = { cpp = "<" }, -- For C++ completions, use "<" to trigger pairing.
                })
            )

            -------------------------------
            -- 3. Setup nvim-cmp with LuaSnip integration
            -------------------------------
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- Use LuaSnip for snippet expansion.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        else
                            local luasnip = require("luasnip")
                            if luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        local luasnip = require("luasnip")
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        fallback()
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP-based completions
                    { name = "luasnip" }, -- LuaSnip snippets
                }, {
                    { name = "buffer" }, -- Fallback: buffer words
                }),
            })

            -------------------------------
            -- 4. Configure LuaSnip for immediate placeholder update
            -------------------------------
            require("luasnip").config.setup({
                history = true,
                update_events = "TextChanged,TextChangedI", -- Clear placeholder text as soon as you type
            })
        end,
    },
}
