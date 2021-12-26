local utils = require "utils"

utils.map("n", "Y", "y$") -- Yank to end of line

-- Use <Tab> and <S-Tab> to navigate through popup menu
utils.map("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
utils.map("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })

-- Window resize
utils.map("i", "<leader>+", ":vertical resize +5<CR>")
utils.map("i", "<leader>-", ":vertical resize -5<CR>")
