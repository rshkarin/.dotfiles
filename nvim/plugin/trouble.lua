local ok, trouble = pcall(require, "trouble")
if not ok then
    return
end

trouble.setup {
    mode = "workspace_diagnostics",
}

vim.keymap.set("n", "<leader>gt", "<Cmd>TroubleToggle workspace_diagnostics<CR>")
