local ok, _ = pcall(require, "poetv")
if not ok then
    return
end

vim.g.poetv_auto_activate = true
