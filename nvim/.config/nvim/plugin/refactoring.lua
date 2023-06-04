local ok, refactoring, telescope = pcall(function()
    return require "refactoring", require "telescope"
end)

if not ok then
    return
end

refactoring.setup {}

telescope.load_extension("refactoring")

vim.keymap.set("n", "<leader>rr", "<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>")
