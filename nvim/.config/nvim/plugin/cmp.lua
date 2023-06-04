local ok, cmp, types, luasnip, tabnine, lspkind = pcall(function()
    return require "cmp", require "cmp.types", require "luasnip", require "cmp_tabnine.config", require "lspkind"
end)

if not ok then
    return
end

local mapping = cmp.mapping

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
    end,
    formatting = {
        format = lspkind.cmp_format {
            mode = "text",
            maxwidth = 50,
            ellipsis_char = '...'
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = mapping(mapping.scroll_docs(8), { "i" }),
        ["<C-u>"] = mapping(mapping.scroll_docs(-8), { "i" }),
        ["<C-k>"] = mapping(function(fallback)
            if cmp.open_docs_preview() then
                cmp.close()
            else
                fallback()
            end
        end),
        ["<C-Space>"] = mapping.complete(),
        ["<C-e>"] = mapping.abort(),
        ["<CR>"] = mapping.confirm { select = false },
        ["<C-n>"] = mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
        ["<C-p>"] = mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
        ["<Tab>"] = mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item { behavior = types.cmp.SelectBehavior.Select }
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Select }
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "cmp_tabnine" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
        { name = "tmux" },
        { name = "rg" },
        { name = "calc" },
        { name = "git" },
    },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline("/", {
--     sources = {
--         { name = "buffer" },
--     },
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(":", {
--     sources = cmp.config.sources({
--         { name = "path" },
--     }, {
--         { name = "cmdline" },
--     }),
-- })

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
