local M = {}

function M.setup()
    require("zen-mode").setup { window = { width = 0.5 }, kitty = { font = "+4" } }
end

return M
