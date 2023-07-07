local ok, harpoon = pcall(require, "harpoon")
if not ok then
    return
end

harpoon.setup {
    global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
    },
}

vim.keymap.set("n", "<C-a>", "<Cmd>lua require('harpoon.mark').add_file()<CR>")
vim.keymap.set("n", "<C-e>", "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
