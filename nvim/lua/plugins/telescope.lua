return {
    {
        "nvim-telescope/telescope.nvim",

        tag = "0.1.8",

        dependencies = {
            "plenary"
        },

        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set("n", '<leader>ff', builtin.find_files, {})
            vim.keymap.set("n", '<leader>fg', builtin.live_grep, {})
            vim.keymap.set("n", '<leader>fs', builtin.current_buffer_fuzzy_find, {})
            vim.keymap.set("n", '<leader>fb', builtin.buffers, {})

            vim.keymap.set("n", "<leader>pws", function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end)

            vim.keymap.set("n", "<leader>pWs", function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end)
        end
    }
}
