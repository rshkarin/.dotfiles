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
