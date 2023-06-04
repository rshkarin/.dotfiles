local cmd = vim.cmd

vim.o.termguicolors = true
vim.g.gruvbox_contrast_dark = "medium"

cmd "colorscheme gruvbox"
cmd "highlight Normal guibg=none"
