return {

    -- measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    -- dispatch async commands
    { "tpope/vim-dispatch" },

    -- markdown preview
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
}
