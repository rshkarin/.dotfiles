local ok, yanky = pcall(require, "yanky")
if not ok then
    return
end

yanky.setup {
    system_clipboard = {
        sync_with_ring = true,
    },
    highlight = {
        on_put = true,
        on_yank = true,
        timer = 250,
    },
}
