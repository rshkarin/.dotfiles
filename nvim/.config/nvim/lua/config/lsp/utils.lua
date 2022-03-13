local M = {}

function M.lsp_diagnostics()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        underline = false,
        signs = true,
        update_in_insert = false,
    })

    local on_references = vim.lsp.handlers["textDocument/references"]
    vim.lsp.handlers["textDocument/references"] = vim.lsp.with(on_references, { loclist = true, virtual_text = true })
end

function M.lsp_highlight(client, bufnr)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                hi LspReferenceRead cterm=bold ctermbg=DarkRed guibg=#282f45
                hi LspReferenceText cterm=bold ctermbg=DarkRed guibg=#282f45
                hi LspReferenceWrite cterm=bold ctermbg=DarkRed guibg=#282f45
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

function M.lsp_config(client, bufnr)
    require("lsp_signature").on_attach { bind = true, handler_opts = { border = "single" } }

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(...)
    end
    buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- LSP and DAP menu
    local whichkey = require "config.which-key"
    whichkey.register_lsp(client)

    if client.resolved_capabilities.document_formatting then
        vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()"
    end
end

function M.lsp_init(client, bufnr)
    -- LSP init
end

function M.lsp_exit(client, bufnr)
    -- LSP exit
end

function M.lsp_attach(client, bufnr)
    M.lsp_config(client, bufnr)
    M.lsp_highlight(client, bufnr)
    M.lsp_diagnostics()
end

function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- for nvim-cmp
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    -- Code actions
    capabilities.textDocument.codeAction = {
        dynamicRegistration = true,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = (function()
                    local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                    table.sort(res)
                    return res
                end)(),
            },
        },
    }

    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    }
    capabilities.experimental = {}
    capabilities.experimental.hoverActions = true

    return capabilities
end

function M.setup_server(server, config)
    local options = {
        on_attach = M.lsp_attach,
        on_exit = M.lsp_exit,
        on_init = M.lsp_init,
        capabilities = M.get_capabilities(),
        flags = { debounce_text_changes = 150 },
    }
    for k, v in pairs(config) do
        options[k] = v
    end

    local lspconfig = require "lspconfig"
    lspconfig[server].setup(vim.tbl_deep_extend("force", options, {}))

    local cfg = lspconfig[server]
    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
        print(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
    end
end

return M
