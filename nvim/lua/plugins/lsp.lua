return {
    {
        "williamboman/mason-lspconfig.nvim",

        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",

            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "saadparwaiz1/cmp_luasnip",

            "j-hui/fidget.nvim",
        },

        config = function()
            require("fidget").setup()
            require("mason").setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "bashls",
                    "tsserver",
                    "cssls",
                    "gopls",
                    "pyright",
                    "terraformls",
                    "dockerls",
                    "graphql",
                    "yamlls",
                    "cmake",
                    "html",
                    "jsonls",
                    "marksman",
                    "taplo",
                },
                handlers = {
                    function(sever_name)
                        local capabilities = require('cmp_nvim_lsp').default_capabilities()

                        require('lspconfig')[sever_name].setup {
                            capabilities = capabilities
                        }
                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        }
                    end,
                }
            })

            -- Set up nvim-cmp.
            local cmp = require 'cmp'
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })


            -- cmp.setup.cmdline({ '/', '?' }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = {
            --         { name = 'buffer' }
            --     }
            -- })
            --
            -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline(':', {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources({
            --         { name = 'path' }
            --     }, {
            --         { name = 'cmdline' }
            --     }),
            --     matching = { disallow_symbol_nonprefix_matching = false }
            -- })

            vim.diagnostic.config({
                update_on_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end
    },


    -- {
    --     "VonHeikemen/lsp-zero.nvim",
    --     branch = "v3.x",
    --     dependencies = {
    --         -- LSP Support
    --         "neovim/nvim-lspconfig",             -- Required
    --         "williamboman/mason.nvim",           -- Optional
    --         "williamboman/mason-lspconfig.nvim", -- Optional
    --
    --         -- Autocompletion
    --         "hrsh7th/nvim-cmp",     -- Required
    --         "hrsh7th/cmp-nvim-lsp", -- Required
    --         "L3MON4D3/LuaSnip",     -- Required
    --         "hrsh7th/cmp-buffer",
    --     },
    --
    --     config = function()
    --         local lsp_zero = require('lsp-zero')
    --
    --         lsp_zero.on_attach(function(client, bufnr)
    --             lsp_zero.default_keymaps({ buffer = bufnr })
    --
    --             local opts = { buffer = bufnr, remap = false }
    --             vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    --             vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
    --             vim.keymap.set('n', '<leader>gD', function() vim.lsp.buf.declaration() end, opts)
    --             vim.keymap.set('n', '<leader>gi', function() vim.lsp.buf.implementation() end, opts)
    --             vim.keymap.set('n', '<leader>gT', function() vim.lsp.buf.type_definition() end, opts)
    --             vim.keymap.set('n', '<leader>gr', function() vim.lsp.buf.references() end, opts)
    --             vim.keymap.set('n', '<leader>gk', function() vim.lsp.buf.signature_help() end, opts)
    --             vim.keymap.set('n', '<leader>gl', function() vim.diagnostic.open_float() end, opts)
    --             vim.keymap.set('n', '<leader>gc', function() vim.lsp.buf.code_action() end, opts)
    --
    --             vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
    --             vim.keymap.set('n', '<leader>fn',
    --                 function() require("conform").format({ async = true, lsp_fallback = true }) end,
    --                 opts)
    --
    --             vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    --             vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    --         end)
    --
    --         lsp_zero.format_on_save({
    --             format_opts = {
    --                 async = false,
    --                 timeout_ms = 10000,
    --             },
    --             servers = {
    --                 ['lua_ls'] = { 'lua' },
    --             }
    --         })
    --
    --         require('mason').setup({})
    --         require('mason-lspconfig').setup({
    --             ensure_installed = {
    --                 "lua_ls",
    --                 "bashls",
    --                 "tsserver",
    --                 "cssls",
    --                 "gopls",
    --                 "pyright",
    --                 "terraformls",
    --                 "dockerls",
    --                 "graphql",
    --                 "yamlls",
    --                 "cmake",
    --                 "html",
    --                 "jsonls",
    --                 "marksman",
    --                 "taplo",
    --             },
    --             handlers = {
    --                 lsp_zero.default_setup,
    --                 lua_ls = function()
    --                     local lua_opts = lsp_zero.nvim_lua_ls()
    --                     require('lspconfig').lua_ls.setup(lua_opts)
    --                 end,
    --             }
    --         })
    --
    --         lsp_zero.set_sign_icons({
    --             error = '✘',
    --             warn = '▲',
    --             hint = '⚑',
    --             info = '»'
    --         })
    --     end
    -- },
    -- {
    --     "hrsh7th/nvim-cmp",
    --
    --     dependencies = {
    --         "onsails/lspkind.nvim"
    --     },
    --
    --     config = function()
    --         local cmp = require('cmp')
    --         local cmp_format = lsp_zero.cmp_format()
    --         local lspkind = require('lspkind')
    --
    --         cmp.setup({
    --             formatting = {
    --                 format = lspkind.cmp_format({
    --                     mode = 'text_symbol',  -- show only symbol annotations
    --                     maxwidth = 120,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    --                     ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    --                 })
    --             },
    --             sources = {
    --                 { name = 'nvim_lsp' },
    --                 { name = 'buffer' },
    --             },
    --             mapping = cmp.mapping.preset.insert({
    --                 ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    --                 ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    --                 ['<CR>'] = cmp.mapping.confirm({ select = true }),
    --                 ["<S-CR>"] = cmp.mapping.confirm {
    --                     behavior = cmp.ConfirmBehavior.Replace,
    --                     select = true,
    --                 },
    --                 ['<C-y>'] = cmp.mapping.complete(),
    --                 ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --                 ['<C-d>'] = cmp.mapping.scroll_docs(4),
    --             }),
    --         })
    --     end
    -- }
}
