local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        profile = {
            enable = true,
            threshold = 0, -- the amount in ms that a plugin's load time must be over for it to be included in the profile
        },
        max_jobs = 10,
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file

    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            vim.cmd [[packadd packer.nvim]]
        end

        -- Run PackerCompile if there are changes in this file
        local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
        vim.api.nvim_create_autocmd(
            { "BufWritePost" },
            { pattern = "plugins.lua", command = "source <afile> | PackerCompile", group = packer_grp }
        )
    end

    -- Plugins
    local function plugins(use)
        use { "wbthomason/packer.nvim" }

        -- Performance
        use { "lewis6991/impatient.nvim" }

        -- Load only when require
        use { "nvim-lua/plenary.nvim", module = "plenary" }

        -- Telescope
        use { "ahmedkhalf/project.nvim" }

        use {
            "nvim-telescope/telescope.nvim",
            cmd = { "Telescope" },
            module = "telescope",
            requires = {
                "nvim-lua/popup.nvim",
                { "nvim-telescope/telescope-frecency.nvim", after = "telescope.nvim", requires = "kkharji/sqlite.lua" },
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                },
                { "nvim-telescope/telescope-dap.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-project.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-media-files.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-file-browser.nvim", after = "telescope.nvim" },
                {
                    "AckslD/nvim-neoclip.lua",
                    requires = {
                        { "kkharji/sqlite.lua", module = "sqlite" },
                        { "nvim-telescope/telescope.nvim" },
                    },
                },
            },
            wants = {
                "popup.nvim",
                "plenary.nvim",
                "telescope-frecency.nvim",
                "telescope-fzf-native.nvim",
                "telescope-file-browser.nvim",
            },
        }

        -- Refactoring
        use {
            "ThePrimeagen/refactoring.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" },
            },
        }

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            requires = {
                { "JoosepAlviste/nvim-ts-context-commentstring" },
                { "jose-elias-alvarez/nvim-lsp-ts-utils" },
                { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
                { "windwp/nvim-autopairs" },
                { "nvim-treesitter/nvim-treesitter-textobjects" },
            },
        }

        -- UI Improvements
        use { "stevearc/dressing.nvim" }

        -- Symbols sidemenu
        use { "simrat39/symbols-outline.nvim" }

        -- Display a code outline window
        use { "stevearc/aerial.nvim" }

        -- Restore session
        use { "tpope/vim-obsession" }

        -- Async task dispatcher
        use { "tpope/vim-dispatch" }

        -- Local text manipulations
        use { "tpope/vim-surround" }
        use { "numToStr/Comment.nvim" }

        -- Escape insert mode with double j
        use { "max397574/better-escape.nvim" }

        -- Undotree
        use { "mbbill/undotree" }

        -- Git
        use { "tpope/vim-rhubarb", event = "VimEnter" }
        use { "tpope/vim-fugitive" }
        use { "junegunn/gv.vim" }
        use { "lewis6991/gitsigns.nvim" }
        use {
            "sindrets/diffview.nvim",
            cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        }
        -- use { "rhysd/committia.vim" }

        -- Database
        -- use {
        --     "tpope/vim-dadbod",
        --     event = "VimEnter",
        --     requires = { "kristijanhusak/vim-dadbod-ui", "kristijanhusak/vim-dadbod-completion" },
        --     config = function()
        --         require("config.dadbod").setup()
        --     end,
        -- }

        -- Testing
        use {
            "nvim-neotest/neotest",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-neotest/neotest-go",
                "nvim-neotest/neotest-python",
                "haydenmeade/neotest-jest",
                "nvim-neotest/neotest-plenary",
            },
        }

        -- Automatic indentation detection
        use { "tpope/vim-sleuth" }

        -- Movements
        use {
            "phaazon/hop.nvim",
            branch = "v2", -- optional but strongly recommended
        }
        use { "ggandor/leap.nvim" }

        ---- f/F/t/T movements on steroids
        use { "ggandor/flit.nvim" }

        -- -- use { "psliwka/vim-smoothie" }
        -- -- use {
        -- --     "karb94/neoscroll.nvim",
        -- --     config = function()
        -- --         require("neoscroll").setup()
        -- --     end,
        -- -- }
        -- use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }

        -- Filemarks
        -- use {
        --     "ThePrimeagen/harpoon",
        --     module = "harpoon",
        --     requires = {
        --         { "nvim-telescope/telescope.nvim" },
        --     },
        -- }

        -- Improved yank
        use { "gbprod/yanky.nvim" }

        -- Fast left-right movement
        use { "unblevable/quick-scope", event = "VimEnter" }

        -- Folder tree (seems to similar to telescope filebroswer)
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
        }

        -- Colorscheme
        use { "luisiacc/gruvbox-baby" }
        use { "folke/tokyonight.nvim" }
        use { "gruvbox-community/gruvbox" }
        use { "projekt0n/github-nvim-theme" }
        use { "nvim-tree/nvim-web-devicons" }

        -- DAP
        use { "mfussenegger/nvim-dap" }
        use { "rcarriga/nvim-dap-ui" }
        use { "theHamsta/nvim-dap-virtual-text" }
        use { "mxsdev/nvim-dap-vscode-js" }
        use { "leoluz/nvim-dap-go" }
        use { "mfussenegger/nvim-dap-python" }
        use { "HiPhish/debugpy.nvim" }
        -- -- use { "Pocco81/dap-buddy.nvim", branch = "dev", after = "nvim-dap" }
        -- use { "jbyuki/one-small-step-for-vimkind", after = "nvim-dap" }

        -- Environment Management
        -- use { "petobens/poet-v" }

        -- LSP
        use {
            "williamboman/mason.nvim",
            as = "mason.nvim",
        }
        use {
            "neovim/nvim-lspconfig",
            as = "nvim-lspconfig",
            after = "mason.nvim",
        }
        use {
            "williamboman/mason-lspconfig.nvim",
            after = "nvim-lspconfig",
        }

        -- Formatters
        use {
            "jose-elias-alvarez/null-ls.nvim",
            as = "null-ls.nvim",
            after = "mason.nvim",
        }
        use {
            "jayp0521/mason-null-ls.nvim",
            after = "null-ls.nvim",
        }
        use { "jose-elias-alvarez/typescript.nvim" }

        -- LSP Improvements
        use { "onsails/lspkind-nvim" }
        use { "folke/lsp-colors.nvim" }
        -- use { "sbdchd/neoformat" }
        use { "lewis6991/hover.nvim" }
        use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", as = "lsp_lines.nvim" }

        -- Dim unused parts of code
        use { "zbirenbaum/neodim" }

        -- Function signature annotation
        use { "ray-x/lsp_signature.nvim" }

        -- Pretty list to show diagnostics
        use {
            "folke/trouble.nvim",
            requires = "nvim-tree/nvim-web-devicons",
            event = "VimEnter",
            cmd = { "TroubleToggle", "Trouble" },
        }
        use { "b0o/schemastore.nvim" }

        -- LSP Loading spinner
        use { "j-hui/fidget.nvim" }

        -- Peek to a specific line
        use { "nacro90/numb.nvim" }

        -- Documentation generator
        -- use {
        --     "kkoomen/vim-doge",
        --     run = ":call doge#install()",
        --     config = function()
        --         require("config.doge").setup()
        --     end,
        --     event = "VimEnter",
        -- }

        -- Snippet runner
        -- use {
        --     "michaelb/sniprun",
        --     run = "bash ./install.sh",
        --     config = function()
        --         require("config.sniprun").setup()
        --     end,
        -- }

        -- Indentation guide to all lines
        use { "lukas-reineke/indent-blankline.nvim" }

        -- Markdown
        use {
            "iamcco/markdown-preview.nvim",
            run = "cd app && npm install",
            setup = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        }

        -- Lua
        use { "folke/neodev.nvim" }

        -- Go
        use { "fatih/vim-go", run = ":GoUpdateBinaries" }

        -- Zen mode
        use {
            "folke/zen-mode.nvim",
            cmd = "ZenMode",
        }

        -- Dim inactive portions of the code
        -- use {
        --     "folke/twilight.nvim",
        --     event = "VimEnter",
        --     config = function()
        --         require("twilight").setup {}
        --     end,
        -- }

        -- Snippets
        -- use {
        --     "SirVer/ultisnips",
        --     requires = { "honza/vim-snippets" },
        --     event = "VimEnter",
        --     config = function()
        --         vim.g.UltiSnipsRemoveSelectModeMappings = 0
        --     end,
        -- }

        -- RFC
        use { "mhinz/vim-rfc" }

        -- Code completion
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                { "andersevenrud/cmp-tmux" },
                { "hrsh7th/cmp-buffer" },
                { "hrsh7th/cmp-calc" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "hrsh7th/cmp-path" },
                { "lukas-reineke/cmp-rg" },
                { "onsails/lspkind-nvim" },
                { "petertriho/cmp-git" },
                { "rcarriga/cmp-dap" },
                { "saadparwaiz1/cmp_luasnip" },
                {
                    "L3MON4D3/LuaSnip",
                    requires = { "rafamadriz/friendly-snippets" },
                },
                { "hrsh7th/cmp-cmdline" },
                -- { "quangnguyen30192/cmp-nvim-ultisnips" },
                -- { "hrsh7th/cmp-nvim-lua" },
                -- { "octaltree/cmp-look" },
                -- { "f3fora/cmp-spell" },
                -- { "hrsh7th/cmp-emoji" },
                -- { "ray-x/cmp-treesitter" },
                -- { "hrsh7th/vim-vsnip" },
                -- { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            },
        }
        use { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" }
        use { "github/copilot.vim" }

        -- Dashboard
        use { "mhinz/vim-startify" }

        -- Status line
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }
        use {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig",
        }

        -- Metrics
        use { "tweekmonster/startuptime.vim", cmd = { "StartupTime" } }

        -- Bootstrap Neovim
        if packer_bootstrap then
            print "Neovim restart is required after installation!"
            require("packer").sync()
        end
    end

    -- Init and start packer
    packer_init()
    local packer = require "packer"

    -- Performance
    pcall(require, "impatient")

    packer.init(conf)
    packer.startup(plugins)
end

return M
