-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    pattern = { "*" },
    callback = function(ev)
        vim.highlight.on_yank { timeout = 40, higroup = "IncSearch" }
    end,
})

-- Trim whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("trim_whitespaces", {}),
    pattern = { "*" },
    callback = function(ev)
        local save_cursor = vim.fn.getpos "."
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.setpos(".", save_cursor)
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = vim.api.nvim_create_augroup("resize_splits", {}),
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = vim.api.nvim_create_augroup("LspConfig", {}),
    callback = function(e)
        vim.bo[e.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = e.buf }

        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', '<leader>gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', '<leader>gD', function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set('n', '<leader>gi', function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set('n', '<leader>gT', function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set('n', '<leader>gr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', '<leader>gk', function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set('n', '<leader>gl', function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '<leader>gc', function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set('n', '<leader>gwl', function() vim.lsp.buf.workspace_symbol() end, opts)

        vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', '<leader>fn',
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            opts)

        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    end,
})

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
