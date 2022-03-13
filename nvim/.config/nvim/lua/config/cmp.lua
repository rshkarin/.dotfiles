local M = {}

function M.setup()
    local cmp = require "cmp"
    local cmp_ultisnips_mappings = require "cmp_nvim_ultisnips.mappings"

    cmp.setup {
        formatting = {
            format = require("lspkind").cmp_format {
                with_text = true,
                menu = {
                    nvim_lsp = "[LSP]",
                    buffer = "[Buffer]",
                    nvim_lua = "[Lua]",
                    ultisnips = "[UltiSnips]",
                    vsnip = "[vSnip]",
                    treesitter = "[treesitter]",
                    look = "[Look]",
                    path = "[Path]",
                    spell = "[Spell]",
                    calc = "[Calc]",
                    emoji = "[Emoji]",
                    neorg = "[Neorg]",
                    cmp_tabnine = "[TN]",
                },
            },
        },
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
                cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            end, {
                "i",
                "s",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                cmp_ultisnips_mappings.jump_backwards(fallback)
            end, {
                "i",
                "s",
            }),
            ["<CR>"] = cmp.mapping.confirm { select = true },
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-y>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-e>"] = cmp.mapping {
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            },
        },
        sources = cmp.config.sources {
            { name = "nvim_lsp" },
            { name = "cmp_tabnine" },
            { name = "ultisnips" },
            { name = "buffer" },
        },
    }

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })

    -- Autopairs
    -- require("nvim-autopairs.completion.cmp").setup {
    --     map_cr = true, --  map <CR> on insert mode
    --     map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    --     auto_select = true, -- automatically select the first item
    --     insert = false, -- use insert confirm behavior instead of replace
    --     map_char = { -- modifies the function or method delimiter by filetypes
    --         all = "(",
    --         tex = "{"
    --     }
    -- }

    -- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    -- local cmp = require "cmp"
    -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

    -- TabNine
    local tabnine = require "cmp_tabnine.config"
    tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = { -- default is not to ignore
            -- uncomment to ignore in lua:
            -- lua = true
        },
    }
end

return M
