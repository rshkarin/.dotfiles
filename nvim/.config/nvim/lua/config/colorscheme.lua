local utils = require "utils"
local cmd = vim.cmd

utils.opt("o", "termguicolors", true)
vim.g.gruvbox_contrast_dark = "medium"

cmd "colorscheme gruvbox"
cmd "highlight Normal guibg=none"
