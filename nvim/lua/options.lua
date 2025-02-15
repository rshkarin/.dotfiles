vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.python3_host_prog = '~/.asdf/shims/python'

local opt = vim.opt

opt.tabstop = 4           -- Number of spaces tabs count for
opt.softtabstop = 4       -- Number of spaces tabs count for
opt.hidden = true         -- Keep hidden buffers
opt.shiftwidth = 4        -- Size of an indent
opt.expandtab = true      -- Use spaces instead of tabs
opt.smartindent = true    -- Insert indents automatically
opt.guicursor = ''        -- Configures the cursor style for each mode
opt.number = true         -- Print line number
opt.relativenumber = true -- Print relative line number
opt.wrap = false          -- Don't wrap lines
opt.swapfile = false      -- Disable swap files
opt.backup = false        -- Disable backup files

opt.undofile = true
opt.undolevels = 10000
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 8        -- Lines of context
opt.signcolumn = "yes"   -- Always show the signcolumn
opt.termguicolors = true -- True color support


opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true            -- Confirm to save changes before exiting modified buffer
--opt.cursorline = true         -- Enable highlighting of the current line ?????
--opt.grepformat = "%f:%l:%c:%m"
--opt.grepprg = "rg --vimgrep"
--opt.ignorecase = true -- Ignore case
opt.shiftround = true -- Round indent
opt.showmode = false  -- Dont show mode since we have a statusline
opt.spelllang = { "en" }
opt.timeoutlen = 300
opt.updatetime = 50 -- Save swap file and trigger CursorHold
opt.winminwidth = 5 -- Minimum window width
opt.wildignore = "*.pyc,*_build/*,**/coverage/*,**/node_modules/*,**/.git/*"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
