local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        print(mode, lhs, rhs, opts)
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

local CoreUtil = require "util.core"

map("n", "Y", "y$", { desc = "Yank to end of line", remap = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true }) -- Yank to end of line

-- Use <Tab> and <S-Tab> to navigate through popup menu
map("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { desc = "Go forward in popup menu", expr = true })
map("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { desc = "Go forward in popup menu", expr = true })

-- Window resize
map("i", "<leader>+", ":vertical resize +5<CR>", { desc = "Vertical resize +5" })
map("i", "<leader>-", ":vertical resize -5<CR>", { desc = "Vertical resize -5" })

-- Quick fix
map("n", "<leader>co", "<Cmd>copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>cc", "<Cmd>cclose<CR>", { desc = "Close quickfix" })
map("n", "<leader>cn", "<Cmd>cnext<CR>", { desc = "Next item in quickfix" })
map("n", "<leader>cp", "<Cmd>cprev<CR>", { desc = "Previous item in quickfix" })
map("n", "<leader>cx", "<Cmd>cex []<CR>")

-- lazygit
map("n", "<leader>gg", function()
    CoreUtil.float_term({ "lazygit" }, { cwd = vim.loop.cwd(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
    CoreUtil.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "Lazygit (cwd)" })

-- Keep latest yark in buffer
map("x", "p", "P")

map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })

map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

-- Clear search with <esc>
map({ "n", "i" }, "<esc>", "<Cmd>noh<CR><Esc>")

-- Quit all
map("n", "<leader>qq", "<Cmd>qa<CR>")
