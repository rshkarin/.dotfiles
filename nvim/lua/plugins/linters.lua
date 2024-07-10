return {
    {
        "mfussenegger/nvim-lint",

        config = function()
            require('lint').linters_by_ft = {
                lua = { 'selene' },
                sh = { 'shellcheck' },
                bash = { 'shellcheck' },
                zsh = { 'shellcheck' },
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
                golang = { 'revive' },
                python = { 'flake8' },
            }
        end

    },

    {
        "stevearc/conform.nvim",

        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black" },
                    javascript = { { "prettierd", "prettier" } },
                    go = { "gofmt" },
                },
            })
        end
    },

    "rshkarin/mason-nvim-lint",
}
