require("lsp_signature").setup()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        require("lsp_signature").on_attach({
            bind = true,
            floating_window = false,
            hint_prefix = "",
            hint_scheme = "Comment",
        }, bufnr)
    end,
})
