local M = {}

local gps = require "nvim-gps"

function M.setup()
    require("lualine").setup {
        options = { theme = "gruvbox" },
        sections = { lualine_c = { "filename", { gps.get_location, cond = gps.is_available } } },
    }
end

return M
