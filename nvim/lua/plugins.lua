local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
   augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
   augroup end
]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use({ "wbthomason/packer.nvim" })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({
        "folke/trouble.nvim",
        requires = { { "nvim-tree/nvim-web-devicons" } },
        config = function()
            require("trouble").setup({
                -- icons = false,
            })
        end,
    })

    -- use({
    --     "ellisonleao/gruvbox.nvim",
    --     config = function()
    --         vim.cmd.colorscheme("gruvbox")
    --     end,
    -- })

    -- use({
    --     "projekt0n/github-nvim-theme",
    --     config = function()
    --         vim.cmd.colorscheme("github_dark_dimmed")
    --     end,
    -- })

    -- use({
    --     "rebelot/kanagawa.nvim",
    --     config = function()
    --         vim.cmd.colorscheme("kanagawa")
    --     end,
    -- })

    -- use({
    --     "EdenEast/nightfox.nvim",
    --     config = function()
    --         vim.cmd.colorscheme("duskfox")
    --     end,
    -- })

    -- use({
    --     "folke/tokyonight.nvim",
    --     config = function()
    --         vim.cmd.colorscheme("tokyonight-night")
    --     end,
    -- })

    -- use({
    --     "catppuccin/nvim",
    --     as = "catppuccin",
    --     config = function()
    --         vim.cmd.colorscheme("catppuccin-mocha")
    --     end,
    -- })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "moon",
            })
            vim.cmd("colorscheme rose-pine")
        end,
    })

    use({
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    })

    use({
        "j-hui/fidget.nvim",
        tag = "v1.2.0",
        config = function()
            require("fidget").setup({
                -- options
            })
        end,
    })

    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

    use("ThePrimeagen/harpoon")

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })

    use("mbbill/undotree")

    use("tpope/vim-fugitive")

    use("lewis6991/gitsigns.nvim")

    use("numToStr/Comment.nvim")

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required
            { "hrsh7th/cmp-buffer" },
        },
    })

    use("onsails/lspkind.nvim")

    use("mhinz/vim-startify")

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })

    use("ray-x/lsp_signature.nvim")

    use("mfussenegger/nvim-lint")

    use("stevearc/conform.nvim")

    use("rshkarin/mason-nvim-lint")

    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
    })

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
