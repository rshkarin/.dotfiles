local utils = require "utils"
local M = {}

function M.setup()
    utils.map("n", "<leader>u", ":UndotreeToggle<CR>")
end

return M
