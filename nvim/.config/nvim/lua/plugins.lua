local M = {}

function M.setup()
    local packer = require "packer"

    local conf = { compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua" }

    local function plugins(use)
        -- Packer can manage itself as an optional plugin
        use { "wbthomason/packer.nvim", opt = true }

        -- Telescope
        use {
            "ahmedkhalf/project.nvim",
            event = "VimEnter",
            config = function()
                require("project_nvim").setup {}
            end,
        }

        use {
            "nvim-telescope/telescope.nvim",
            cmd = { "Telescope" },
            module = "telescope",
            requires = {
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-frecency.nvim", after = "telescope.nvim", requires = "tami5/sql.nvim" },
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
                { "nvim-telescope/telescope-dap.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-project.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-media-files.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" },
                { "nvim-telescope/telescope-file-browser.nvim", after = "telescope.nvim" },
            },
            wants = {
                "popup.nvim",
                "plenary.nvim",
                "telescope-frecency.nvim",
                "telescope-fzf-native.nvim",
                "telescope-file-browser.nvim",
            },
            config = function()
                require("config.telescope").setup()
            end,
        }

        use {
            "AckslD/nvim-neoclip.lua",
            requires = {
                { "tami5/sqlite.lua", module = "sqlite" },
                { "nvim-telescope/telescope.nvim" },
            },
            config = function()
                require("neoclip").setup()
            end,
        }

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("config.treesitter").setup()
            end,
            requires = {
                { "JoosepAlviste/nvim-ts-context-commentstring" },
                { "jose-elias-alvarez/nvim-lsp-ts-utils" },
                { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
                {
                    "windwp/nvim-autopairs",
                    run = "make",
                    config = function()
                        require("nvim-autopairs").setup {}
                    end,
                },
                { "nvim-treesitter/nvim-treesitter-textobjects" },
            },
        }

        -- Symbols sidemenu
        use {
            "simrat39/symbols-outline.nvim",
            event = "VimEnter",
            config = function()
                require("config.symbols-outline").setup()
            end,
        }

        -- Async task dispatcher
        use { "tpope/vim-dispatch" }

        -- Local text manipulations
        use { "tpope/vim-surround" }
        use { "tpope/vim-commentary" }

        -- Caching compiled lua modules
        use { "lewis6991/impatient.nvim" }

        -- Cmd (wild) menu suggestions
        -- use {
        --     "gelguy/wilder.nvim",
        --     run = ":UpdateRemotePlugins",
        --     config = function()
        --         require("config.wilder").setup()
        --     end
        -- }

        -- Undotree
        use { "mbbill/undotree" }

        -- Git
        use { "tpope/vim-rhubarb", event = "VimEnter" }
        use { "tpope/vim-fugitive" }
        use { "junegunn/gv.vim" }
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("gitsigns").setup()
            end,
        }
        use {
            "sindrets/diffview.nvim",
            cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        }

        -- Testing
        use {
            "rcarriga/vim-ultest",
            run = ":UpdateRemotePlugins",
            requires = { "vim-test/vim-test" },
            config = function()
                require("config.test").setup()
            end,
        }

        -- Movements
        use {
            "phaazon/hop.nvim",
            as = "hop",
            config = function()
                require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
            end,
        }

        -- Filemarks
        use {
            "ThePrimeagen/harpoon",
            module = "harpoon",
            requires = {
                { "nvim-telescope/telescope.nvim" },
            },
            config = function()
                require("config.harpoon").setup()
            end,
        }
        -- use { "easymotion/vim-easymotion" }

        -- Fast left-right movement
        -- use {"unblevable/quick-scope", event = "VimEnter"}

        -- Folder tree (seems to similar to telescope filebroswer)
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = { "NvimTreeToggle", "NvimTreeClose" },
            config = function()
                require("nvim-tree").setup {}
            end,
        }

        -- Colorscheme
        use { "luisiacc/gruvbox-baby" }
        use { "folke/tokyonight.nvim" }
        use { "gruvbox-community/gruvbox" }
        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup { default = true }
            end,
        }

        -- DAP
        use { "mfussenegger/nvim-dap" }
        use { "mfussenegger/nvim-dap-python" }
        use { "theHamsta/nvim-dap-virtual-text" }
        use { "rcarriga/nvim-dap-ui" }
        use { "Pocco81/DAPInstall.nvim" }
        use { "jbyuki/one-small-step-for-vimkind" }

        -- LSP
        use {
            "neovim/nvim-lspconfig",
            config = function()
                require("config.lsp").setup()
                require("config.dap").setup()
            end,
        }
        use { "jose-elias-alvarez/null-ls.nvim" }
        use { "williamboman/nvim-lsp-installer" }

        -- LSP Improvements
        use {
            "onsails/lspkind-nvim",
            config = function()
                require("lspkind").init()
            end,
        }
        use { "sbdchd/neoformat" }
        use { "ray-x/lsp_signature.nvim" }
        -- -- use {"szw/vim-maximizer"}
        -- use {"kevinhwang91/nvim-bqf"}
        -- use {"andymass/vim-matchup", event = "CursorMoved"}
        -- use {
        --     "folke/trouble.nvim",
        --     requires = "kyazdani42/nvim-web-devicons",
        --     event = "VimEnter",
        --     cmd = {"TroubleToggle", "Trouble"},
        --     config = function()
        --         require("trouble").setup({auto_open = false})
        --     end
        -- }
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            cmd = { "TodoTrouble", "TodoTelescope" },
            event = "BufReadPost",
            config = function()
                require("todo-comments").setup {}
            end,
        }

        -- Peek to a specific line
        use {
            "nacro90/numb.nvim",
            config = function()
                require("numb").setup()
            end,
        }

        -- Easy text alignment
        -- use {"junegunn/vim-easy-align"}

        -- Documentation generator
        use {
            "kkoomen/vim-doge",
            run = ":call doge#install()",
            config = function()
                require("config.doge").setup()
            end,
            event = "VimEnter",
        }

        -- Snippet runner
        use {
            "michaelb/sniprun",
            run = "bash ./install.sh",
            config = function()
                require("config.sniprun").setup()
            end,
        }

        -- Identation guide to all lines
        use { "lukas-reineke/indent-blankline.nvim" }

        -- Notifications
        -- use {
        --     "rcarriga/nvim-notify",
        --     event = "VimEnter",
        --     config = function()
        --         vim.notify = require("notify")
        --     end
        -- }

        -- Keys mapping
        use {
            "folke/which-key.nvim",
            config = function()
                require("config.which-key").setup()
            end,
        }

        -- Markdown
        -- use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install", ft = "markdown", cmd = {"MarkdownPreview"}}
        -- use {"plasticboy/vim-markdown", ft = "markdown", requires = {"godlygeek/tabular"}, event = "VimEnter"}

        -- Lua
        use { "folke/lua-dev.nvim", event = "VimEnter" }

        -- Go
        use { "fatih/vim-go", run = ":GoUpdateBinaries" }

        -- Zen mode
        use {
            "folke/zen-mode.nvim",
            cmd = "ZenMode",
            config = function()
                require("zen-mode").setup()
            end,
        }

        -- use {
        --     "windwp/nvim-autopairs",
        --     event = "BufRead",
        --     run = "make",
        --     config = function()
        --         require("nvim-autopairs").setup {}
        --     end,
        --     after = "nvim-cmp",
        -- }

        -- Snippets
        use {
            "SirVer/ultisnips",
            requires = { "honza/vim-snippets" },
            event = "VimEnter",
            config = function()
                vim.g.UltiSnipsRemoveSelectModeMappings = 0
            end,
        }

        -- RFC
        use { "mhinz/vim-rfc" }

        -- Python
        use { "ambv/black" }

        -- Code completion
        use {
            "hrsh7th/nvim-cmp",
            event = "BufRead",
            config = function()
                require("config.cmp").setup()
            end,
            requires = {
                { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "quangnguyen30192/cmp-nvim-ultisnips", after = "nvim-cmp" },
                { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
                { "octaltree/cmp-look", after = "nvim-cmp" },
                { "hrsh7th/cmp-path", after = "nvim-cmp" },
                { "hrsh7th/cmp-calc", after = "nvim-cmp" },
                { "f3fora/cmp-spell", after = "nvim-cmp" },
                { "hrsh7th/cmp-emoji", after = "nvim-cmp" },
                { "ray-x/cmp-treesitter", after = "nvim-cmp" },
            },
        }
        -- use { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp", after = "nvim-cmp" }

        -- Dashboard
        use { "mhinz/vim-startify" }
        -- -- use {
        -- --     "glepnir/dashboard-nvim",
        -- --     config = function()
        -- --         require("config.dashboard").setup()
        -- --     end
        -- -- }

        -- Status line
        use {
            "nvim-lualine/lualine.nvim",
            event = "VimEnter",
            config = function()
                require("config.lualine").setup()
            end,
        }

        -- Cheatsheet
        -- use {"sudormrfbin/cheatsheet.nvim"}
        use {
            "SmiteshP/nvim-gps",
            module = "nvim-gps",
            config = function()
                require("nvim-gps").setup()
            end,
        }

        -- Metrics
        use { "dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 10]] }

        -- Copilot
        use { "github/copilot.vim" }
    end

    packer.init(conf)
    packer.startup(plugins)
end

return M

--[[


    " Indent vertical lines
    Plug

    " Move over doc via automatically created mark
    Plug 'phaazon/hop.nvim'

    " Zen mode
    Plug 'folke/zen-mode.nvim'

    " Icons
    Plug 'kyazdani42/nvim-web-devicons'

    " Folder tree (seems to similar to telescope filebroswer)
    Plug 'kyazdani42/nvim-tree.lua'

    " Debug adapter protocol
    Plug 'mfussenegger/nvim-dap'
    Plug 'nvim-telescope/telescope-dap.nvim'

    " Debug individual test
    Plug 'leoluz/nvim-dap-go'

    " Quickfix list with issues
    Plug 'folke/trouble.nvim'

    " Pictograms on completion window
    Plug 'onsails/lspkind-nvim'

    " Add support more flexible selection within pair characters
    Plug 'wellle/targets.vim' ]]
