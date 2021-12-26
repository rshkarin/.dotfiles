local M = {}

function M.auto_cmds()
    vim.api.nvim_exec(
        [[
            fun! LspLocationList()
                lua vim.lsp.diagnostic.set_loclist({ open_loclist = false })
            endfun

            augroup LspFillLocationList
                autocmd!
                autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
            augroup END
        ]],
        false
    )

    vim.api.nvim_exec(
        [[
            autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
            autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
            autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
            autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 100)
        ]],
        false
    )
end

function M.setup()
    M.auto_cmds()
end

return M
