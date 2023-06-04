local ok, _ = pcall(require, "undotree")
if not ok then
    return
end

vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
