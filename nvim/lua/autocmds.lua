-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", {}),
    callback = function(ev)
        vim.highlight.on_yank { timeout = 40 }
    end,
})

-- Trim whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = vim.api.nvim_create_augroup("trim_whitespaces", {}),
    pattern = { "*" },
    callback = function(ev)
        local save_cursor = vim.fn.getpos "."
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.setpos(".", save_cursor)
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = vim.api.nvim_create_augroup("resize_splits", {}),
    callback = function()
        vim.cmd "tabdo wincmd ="
    end,
})
