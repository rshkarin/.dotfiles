return {
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     init = function()
    --         vim.o.background = "dark" -- or "light" for light mode
    --         vim.cmd [[colorscheme gruvbox]]
    --     end,
    -- },
    {
        "luisiacc/gruvbox-baby",
        lazy = false,
        priority = 1000,
        init = function()
            vim.g.gruvbox_contrast_dark = "medium"
            vim.cmd [[colorscheme gruvbox-baby]]
            vim.cmd [[highlight Normal guibg=none]]
        end,
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     priority = 1000,
    --     init = function()
    --         vim.cmd [[colorscheme tokyonight-moon]]
    --     end,
    -- },
}
