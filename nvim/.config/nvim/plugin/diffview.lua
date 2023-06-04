local ok, _ = pcall(require, "diffview")
if not ok then
    return
end

vim.keymap.set("n", "<leader>gv", "<Cmd>DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>gc", "<Cmd>DiffviewClose<CR>")
