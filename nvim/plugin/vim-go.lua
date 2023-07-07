local ok, _ = pcall(require, "vim-go")
if not ok then
    return
end

vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_test_show_name = 1
vim.g.go_fmt_command = "goimports"
