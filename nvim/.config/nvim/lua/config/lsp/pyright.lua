local M = {}

local lsputils = require "config.lsp.utils"

function M.config(installed_server)
    return {
        cmd = installed_server._default_options.cmd,
        settings = {
            python = {
                analysis = {
                    diagnosticSeverityOverrides = {
                        reportGeneralTypeIssues = "none",
                        reportOptionalIterable = "none",
                        reportOptionalSubscript = "none",
                        reportOptionalMemberAccess = "none",
                        reportOptionalCall = "none",
                        reportOptionalIterable = "none",
                        reportOptionalContextManager = "none",
                        reportOptionalOperand = "none",
                    },
                },
            },
        },
    }
end

function M.setup(installed_server)
    lsputils.setup_server("pyright", M.config(installed_server))
    M.autocmds()
    M.keymappings()
end

function M.autocmds()
    vim.api.nvim_exec(
        [[
      augroup PYTHON
        autocmd!
        autocmd BufEnter *.py lua require("config.lsp.pyright").keymappings()
      augroup END
    ]],
        false
    )
end

function M.keymappings()
    local opts = { mode = "n", prefix = "<leader>", buffer = nil, silent = false, noremap = true, nowait = true }

    local wk = require "which-key"
    local mappings = {
        ["r"] = {
            name = "Run",
            c = { ":PyrightOrganizeImports<CR>", "Organize imports" },
        },
    }
    wk.register(mappings, opts)
end

return M
