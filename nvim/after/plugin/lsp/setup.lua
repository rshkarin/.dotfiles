local ok, lspconfig, util, cmp_lsp, mason_lspconfig = pcall(function()
    return require "lspconfig", require "lspconfig.util", require "cmp_nvim_lsp", require "mason-lspconfig"
end)
if not ok then
    return
end

-- local capabilities
-- do
--     local default_capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities = {
--         textDocument = {
--             completion = {
--                 completionItem = {
--                     snippetSupport = true,
--                     preselectSupport = true,
--                     insertReplaceSupport = true,
--                     labelDetailsSupport = true,
--                     deprecatedSupport = true,
--                     commitCharactersSupport = true,
--                 },
--             },
--             codeAction = {
--                 resolveSupport = {
--                     properties = vim.list_extend(default_capabilities.textDocument.codeAction.resolveSupport.properties, {
--                         "documentation",
--                         "detail",
--                         "additionalTextEdits",
--                     }),
--                 },
--             },
--         },
--     }
-- end

local capabilities
do
    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
            codeAction = {
                resolveSupport = {
                    properties = vim.list_extend(default_capabilities.textDocument.codeAction.resolveSupport.properties,
                        {
                            "documentation",
                            "detail",
                            "additionalTextEdits",
                        }),
                },
            },
        },
    }
end

util.default_config = vim.tbl_deep_extend("force", util.default_config, {
    capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities(capabilities)
    ),
})

mason_lspconfig.setup {}

mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities,
        }
    end,
    ["lua_ls"] = function()
        require("neodev").setup {}
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    format = {
                        enable = false,
                    },
                    hint = {
                        enable = true,
                        arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                        await = true,
                        paramName = "Disable", -- "All", "Literal", "Disable"
                        paramType = false,
                        semicolon = "Disable", -- "All", "SameLine", "Disable"
                        setType = true,
                    },
                    diagnostics = {
                        globals = { "P", "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        }
    end,
    -- ["sumneko_lua"] = function()
    --     require("neodev").setup {}
    --     lspconfig.sumneko_lua.setup {
    --         settings = {
    --             Lua = {
    --                 runtime = {
    --                     -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    --                     version = "LuaJIT",
    --                 },
    --                 diagnostics = {
    --                     -- Get the language server to recognize the `vim` global
    --                     globals = { "vim" },
    --                 },
    --                 workspace = {
    --                     -- Make the server aware of Neovim runtime files
    --                     library = vim.api.nvim_get_runtime_file("", true),
    --                 },
    --                 -- Do not send telemetry data containing a randomized but unique identifier
    --                 telemetry = {
    --                     enable = false,
    --                 },
    --             },
    --         },
    --         -- settings = {
    --         --     Lua = {
    --         --         format = {
    --         --             enable = false,
    --         --         },
    --         --         hint = {
    --         --             enable = true,
    --         --             arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
    --         --             await = true,
    --         --             paramName = "Disable", -- "All", "Literal", "Disable"
    --         --             paramType = false,
    --         --             semicolon = "Disable", -- "All", "SameLine", "Disable"
    --         --             setType = true,
    --         --         },
    --         --         diagnostics = {
    --         --             globals = { "vim", "P" },
    --         --         },
    --         --     },
    --         -- },
    --     }
    -- end,
    ["pyright"] = function()
        lspconfig.pyright.setup {
            -- settings = {
            --     python = {
            --         analysis = {
            --             diagnosticSeverityOverrides = {
            --                 reportGeneralTypeIssues = "none",
            --                 reportOptionalSubscript = "none",
            --                 reportOptionalMemberAccess = "none",
            --                 reportOptionalCall = "none",
            --                 reportOptionalIterable = "none",
            --                 reportOptionalContextManager = "none",
            --                 reportOptionalOperand = "none",
            --             },
            --         },
            --     },
            -- },
        }
    end,
    ["gopls"] = function()
        lspconfig.gopls.setup {
            settings = {
                gopls = {
                    experimentalPostfixCompletions = true,
                    analyses = { unusedparams = true, unreachable = false },
                    usePlaceholders = true,
                    completeUnimported = true,
                    staticcheck = true,
                    symbolMatcher = "Fuzzy",
                    gofumpt = true,
                },
            },
        }
    end,
    ["tsserver"] = function()
        require("typescript").setup {
            server = {
                capabilities = capabilities,
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            },
        }
    end, ["jsonls"] = function()
        lspconfig.jsonls.setup {
            capabilities = capabilities,
            filetypes = { "json", "jsonc", "json5" },
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                },
            },
        }
    end,
    ["yamlls"] = function()
        lspconfig.yamlls.setup {
            capabilities = capabilities,
            settings = {
                yaml = {
                    hover = true,
                    completion = true,
                    validate = true,
                    schemas = require("schemastore").yaml.schemas {
                        extra = {
                            {
                                fileMatch = { "**/packages/*/package.yaml" },
                                name = "Mason Registry",
                                description = "Mason Registry",
                                url = "https://raw.githubusercontent.com/mason-org/json-schema/main/bundled-schema.json",
                            },
                        },
                    },
                },
            },
        }
    end,
}
