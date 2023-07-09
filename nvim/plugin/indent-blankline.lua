local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
    return
end

indent_blankline.setup {
    char = "▏",
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = { "help", "packer" },
}
