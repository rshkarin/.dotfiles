local ok, hop = pcall(require, "hop")
if not ok then
    return
end

hop.setup { keys = "etovxqpdygfblzhckisuran" }

vim.keymap.set("n", "ff", "<Cmd>HopWordCurrentLine<CR>")
vim.keymap.set("n", "ft", "<Cmd>HopWord<CR>")
