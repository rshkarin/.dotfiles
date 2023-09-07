return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        build = "make install_jsregexp",
    },

    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-calc",
            "lukas-reineke/cmp-rg",
            "onsails/lspkind-nvim",
            "petertriho/cmp-git",
            "hrsh7th/cmp-cmdline",
        },
        opts = function()
            local cmp = require "cmp"
            local mapping = cmp.mapping
            local lspkind = require "lspkind"
            local types = require "cmp.types"
            local luasnip = require "luasnip"

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
            end

            return {
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                end,
                formatting = {
                    format = lspkind.cmp_format {
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        symbol_map = {
                            Text = "󰉿",
                            Method = "󰆧",
                            Function = "󰊕",
                            Constructor = "",
                            Field = "󰜢",
                            Variable = "󰀫",
                            Class = "󰠱",
                            Interface = "",
                            Module = "",
                            Property = "󰜢",
                            Unit = "󰑭",
                            Value = "󰎠",
                            Enum = "",
                            Keyword = "󰌋",
                            Snippet = "",
                            Color = "󰏘",
                            File = "󰈙",
                            Reference = "󰈇",
                            Folder = "󰉋",
                            EnumMember = "",
                            Constant = "󰏿",
                            Struct = "󰙅",
                            Event = "",
                            Operator = "󰆕",
                            TypeParameter = "",
                        },
                    },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-d>"] = mapping(mapping.scroll_docs(8), { "i" }),
                    ["<C-u>"] = mapping(mapping.scroll_docs(-8), { "i" }),
                    ["<C-k>"] = mapping(function(fallback)
                        if cmp.open_docs_preview() then
                            cmp.close()
                        else
                            fallback()
                        end
                    end),
                    ["<S-Space>"] = mapping.complete(),
                    ["<S-e>"] = mapping.abort(),
                    ["<CR>"] = mapping.confirm { select = false },
                    ["<S-CR>"] = mapping.confirm {
                        behavior = types.cmp.ConfirmBehavior.Replace,
                        select = true,
                    }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items
                    ["<C-n>"] = mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
                    ["<C-p>"] = mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
                    ["<Tab>"] = mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item { behavior = types.cmp.SelectBehavior.Select }
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Select }
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "rg" },
                    { name = "calc" },
                    { name = "git" },
                },
            }
        end,
    },

    -- autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true, fast_wrap = {} },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            local cmp = require "cmp"
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
        end,
    },

    -- refactoring tool
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },

    -- show function signature when you type
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            require("lsp_signature").setup(opts)

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    require("lsp_signature").on_attach({
                        bind = true,
                        floating_window = false,
                        hint_prefix = "",
                        hint_scheme = "Comment",
                    }, bufnr)
                end,
            })
        end,
    },

    -- escape insert mode with double j
    {
        "max397574/better-escape.nvim",
        config = function(_, opts)
            require("better_escape").setup(opts)
        end,
    },

    -- hover window with d
    {
        "lewis6991/hover.nvim",
        opts = {
            init = function()
                require "hover.providers.lsp"
                require "hover.providers.gh"
                require "hover.providers.man"
                require "hover.providers.dictionary"
            end,
            title = true,
            preview_window = true,
        },
        keys = {
            {
                "K",
                mode = { "n" },
                function()
                    require("hover").hover()
                end,
                desc = "Hover",
            },
            {
                "gK",
                mode = { "n" },
                function()
                    require("hover").hover_select()
                end,
                desc = "Hover (select)",
            },
        },
    },

    -- GitHub Copilot
    {
        "github/copilot.vim",
        init = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        end,
    },

    -- continuously update session files
    { "tpope/vim-obsession" },

    -- mapping to handle session
    { "tpope/vim-surround" },

    -- comments
    {
        "numToStr/Comment.nvim",
        opts = {
            -- add any options here
        },
        lazy = false,
    },
}
