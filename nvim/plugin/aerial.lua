local ok, aerial = pcall(require, "aerial")
if not ok then
    return
end

aerial.setup {
    layout = {
        width = 40,
        default_direction = "right",
        placement = "edge",
    },
}

vim.keymap.set("n", "<leader>l", "<cmd>AerialToggle<CR>")
