return {
    -- better vim.ui
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                enabled = false, -- native vim input is pretty nice for many reasons
                border = "single",
                win_options = {
                    winblend = 10,
                    winhighlight = "Normal:DressingInputNormalFloat,NormalFloat:DressingInputNormalFloat,FloatBorder:DressingInputFloatBorder",
                },
            },
        },
    },

    -- lsp symbol navigation for lualine. This shows where
    -- in the code structure you are - within functions, classes,
    -- etc - in the statusline.
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        init = function()
            vim.g.navic_silence = true
            require("util.telescope.lsp").on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        opts = function()
            return {
                separator = " ",
                highlight = true,
                depth_limit = 5,
                icons = require("config").defaults.icons.kinds,
            }
        end,
    },

    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local icons = require("config").defaults.icons

            return {
                options = {
                    theme = "gruvbox",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        {
                            function()
                                return require("nvim-navic").get_location()
                            end,
                            cond = function()
                                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                            end,
                        },
                    },
                    lualine_x = {
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_y = {
                        "encoding",
                        {
                            function()
                                return "  " .. require("dap").status()
                            end,
                            cond = function()
                                return package.loaded["dap"] and require("dap").status() ~= ""
                            end,
                        },
                    },
                    lualine_z = {
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                },
                extensions = { "neo-tree", "lazy", "fugitive" },
            }
        end,
    },

    -- statusline
    -- {
    --     "nvim-lualine/lualine.nvim",
    --     event = "VeryLazy",
    --     -- dependencies = {
    --     --     {
    --     --         "SmiteshP/nvim-navic",
    --     --         lazy = true,
    --     --         dependencies = {
    --     --             "neovim/nvim-lspconfig",
    --     --         },
    --     --         init = function()
    --     --             vim.api.nvim_create_autocmd("LspAttach", {
    --     --                 callback = function(args)
    --     --                     local bufnr = args.buf
    --     --                     local client = vim.lsp.get_client_by_id(args.data.client_id)
    --     --                     if client.supports_method "textDocument/documentSymbol" then
    --     --                         require("navic").attach(client, bufnr)
    --     --                     end
    --     --                 end,
    --     --             })
    --     --         end,
    --     --     },
    --     -- },
    --     opts = function()
    --         local icons = require("config").defaults.icons
    --
    --         return {
    --             options = {
    --                 disabled_filetypes = { "neo-tree" },
    --                 theme = "gruvbox",
    --                 globalstatus = true,
    --             },
    --             sections = {
    --                 lualine_a = { "mode" },
    --                 lualine_b = { "branch", "diff" },
    --                 lualine_c = {
    --                     {
    --                         "diagnostics",
    --                         symbols = {
    --                             error = icons.diagnostics.Error,
    --                             warn = icons.diagnostics.Warn,
    --                             info = icons.diagnostics.Info,
    --                             hint = icons.diagnostics.Hint,
    --                         },
    --                     },
    --                     { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
    --                     { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
    --                     {
    --                         function()
    --                             return require("nvim-navic").get_location()
    --                         end,
    --                         cond = function()
    --                             return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
    --                         end,
    --                     },
    --                 },
    --                 lualine_c = { "filename", navic.get_location },
    --                 lualine_x = {
    --                     {
    --                         function()
    --                             return "  " .. require("dap").status()
    --                         end,
    --                         cond = function()
    --                             return package.loaded["dap"] and require("dap").status() ~= ""
    --                         end,
    --                     },
    --                     {
    --                         "diff",
    --                         symbols = {
    --                             added = icons.git.added,
    --                             modified = icons.git.modified,
    --                             removed = icons.git.removed,
    --                         },
    --                     },
    --                 },
    --                 lualine_x = {
    --                     { "diagnostics", sources = { "nvim_diagnostic" } },
    --                     "filesize",
    --                     "encoding",
    --                     { "filetype", separator = { right = "" }, right_padding = 0 },
    --                     { attached_clients, separator = { left = "" }, left_padding = 0 },
    --                 },
    --             },
    --             inactive_sections = {},
    --             extensions = { "quickfix", "toggleterm", "fugitive" },
    --         }
    --     end,
    -- },

    -- indent guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "│",
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },

    -- icons
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- dashboard
    { "mhinz/vim-startify" },

    -- LSP loading progress
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
    },

    -- ui components
    { "MunifTanjim/nui.nvim", lazy = true },
}
