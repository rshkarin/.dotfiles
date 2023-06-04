local ok, zen_mode = pcall(require, "zen-mode")
if not ok then
    return
end

zen_mode.setup {
    window = { width = 0.5 },
    kitty = { font = "+4" },
    tmux = { enabled = false },
    alacritty = {
        enabled = true,
        font = "28", -- font size
    },
}
