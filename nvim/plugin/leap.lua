local ok, leap = pcall(require, "leap")
if not ok then
    return
end

leap.setup {
    case_sensitive = true,
}

vim.keymap.set({'n', 'x', 'o'}, 'r', '<Plug>(leap-forward-to)')
vim.keymap.set({'n', 'x', 'o'}, 'R', '<Plug>(leap-backward-to)')
