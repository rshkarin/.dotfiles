local ok, lsp_lines = pcall(require, "lsp_lines")
if not ok then
    return
end

lsp_lines.setup()

local DEFAULT_CONFIG = {
    virtual_text = true,
    virtual_lines = false,
    underline = true,
    signs = false,
    severity_sort = true,
    float = {
        header = false,
        source = "always",
    },
}

-- Default config
vim.diagnostic.config(DEFAULT_CONFIG)

vim.keymap.set("n", "<M-d>", function()
    local interved_virtual_text_value = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = interved_virtual_text_value })
    lsp_lines.toggle()
end, { desc = "Toggle lsp_lines" })
