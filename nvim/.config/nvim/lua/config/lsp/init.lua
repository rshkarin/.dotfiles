local M = {}

local lsp_installer = require "nvim-lsp-installer"

local lsp_providers = { sumneko_lua = true, tsserver = true, gopls = true, pyright = true }

local function install_servers()
    for name, _ in pairs(lsp_providers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found and not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
end

local function setup_servers()
    require("config.lsp.null-ls").setup()

    lsp_installer.on_server_ready(function(server)
        if lsp_providers[server.name] then
            local server_opts = require("config.lsp." .. server.name).setup(server)
            if server_opts then
                server:setup(server_opts)
            end
        else
            local lsputils = require "config.lsp.utils"
            local opts = {
                on_attach = lsputils.lsp_attach,
                capabilities = lsputils.get_capabilities(),
                on_init = lsputils.lsp_init,
                on_exit = lsputils.lsp_exit,
            }
            server:setup(opts)
        end
    end)
end

function M.setup()
    install_servers()
    setup_servers()
end

return M
