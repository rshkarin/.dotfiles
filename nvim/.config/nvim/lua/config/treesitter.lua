local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        ignore_install = { "tlaplus" },
        indent = { enable = true },
        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
        },
        context_commentstring = { enable = true },
        matchup = { enable = true },
    }
end

return M
