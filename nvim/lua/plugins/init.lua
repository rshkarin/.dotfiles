return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "moon",
            })
            vim.cmd("colorscheme rose-pine")
        end,
    },

    {
        "numToStr/Comment.nvim",

        config = function()
            require("Comment").setup()
        end
    },

    {
        "lewis6991/gitsigns.nvim",

        config = function()
            require('gitsigns').setup {
                signs = {
                    add = { text = "▎" },
                    change = { text = "▎" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "▎" },
                    untracked = { text = "▎" },
                },
                on_attach = function(buffer)
                    local gs = package.loaded.gitsigns

                    vim.keymap.set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { buffer = buffer })
                end
            }
        end
    },

    {
        "tpope/vim-fugitive",

        config = function()
            vim.keymap.set("n", "<leader>gs", "<Cmd>Git<CR>")
            vim.keymap.set("n", "<leader>gp", "<Cmd>Git push<CR>")
            vim.keymap.set("n", "<leader>gb", "<Cmd>Git branch<CR>")
            vim.keymap.set("n", "<leader>ge", "<Cmd>Git commit<CR>")
            vim.keymap.set("n", "<leader>gx", "<Cmd>Gvdiffsplit<CR>")
            vim.keymap.set("n", "<leader>gf", "<Cmd>Git fetch --all<CR>")
            vim.keymap.set("n", "<leader>gx", "<Cmd>Gvdiffsplit<CR>")
        end
    },

    {
        "ray-x/lsp_signature.nvim",

        config = function()
            require("lsp_signature").setup()

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
        end
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({})

            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle quickfix<cr>")
            vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
        end,
    },

    -- Do I really need both of you?
    -- {
    --     "windwp/nvim-autopairs",
    --
    --     config = function()
    --         require("nvim-autopairs").setup({})
    --     end,
    -- },

    -- {
    --     "stevearc/oil.nvim",
    --
    --     config = function()
    --         require("oil").setup()
    --     end,
    -- },

    {
        "nvim-lualine/lualine.nvim",

        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            require('lualine').setup {
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            }
        end
    },

    "mhinz/vim-startify",
}
