-- Yank to end of line
vim.keymap.set("n", "Y", "y$")

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.keymap.set("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })

-- Window resize
vim.keymap.set("n", "<leader>+", ":vertical resize +5<CR>")
vim.keymap.set("n", "<leader>-", ":vertical resize -5<CR>")

-- Quick fix
vim.keymap.set("n", "<leader>co", "<Cmd>copen<CR>")
vim.keymap.set("n", "<leader>cc", "<Cmd>cclose<CR>")
vim.keymap.set("n", "<leader>cn", "<Cmd>cnext<CR>")
vim.keymap.set("n", "<leader>cp", "<Cmd>cprev<CR>")
vim.keymap.set("n", "<leader>cx", "<Cmd>cex []<CR>")

-- Keep latest yark in buffer
vim.keymap.set("x", "p", "P")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true} )
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true} )

vim.keymap.set("n", "n", "nzzzv", { noremap = true} )
vim.keymap.set("n", "N", "Nzzzv", { noremap = true} )
