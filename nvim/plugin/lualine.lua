local ok, lualine, navic = pcall(function()
    return require "lualine", require "nvim-navic"
end)

if not ok then
    return
end

-- lualine.setup {
--     options = { theme = "gruvbox" },
--     sections = {
--         lualine_c = { "filename", { navic.get_location, cond = navic.is_available },
--         },
--     },
-- }


local function attached_clients()
    return "(" .. vim.tbl_count(vim.lsp.buf_get_clients(0)) .. ")"
end

local function cwd()
    return vim.fn.fnamemodify(vim.loop.cwd(), ":~")
end

lualine.setup {
    options = {
        disabled_filetypes = { "neo-tree" },
        theme = "gruvbox",
    },
    sections = {
        lualine_b = { "branch", "diff", cwd },
        lualine_c = { "filename", navic.get_location },
        lualine_x = {
            { "diagnostics", sources = { "nvim_diagnostic" } },
            "filesize",
            "encoding",
            { "filetype", separator = { right = "" }, right_padding = 0 },
            { attached_clients, separator = { left = "" }, left_padding = 0 },
        },
    },
    inactive_sections = {},
    extensions = { "quickfix", "toggleterm", "fugitive" },
}
