local M = {}

function M.auto_cmds()
    vim.cmd [[
        let g:gruvbox_contrast_dark = "medium"
        colorscheme gruvbox
        highlight Normal guibg=none
        ]]

    vim.api.nvim_exec(
        [[
            fun! TrimWhitespace()
                let l:save = winsaveview()
                keeppatterns %s/\s\+$//e
                call winrestview(l:save)
            endfun

            augroup REPEATED
                autocmd!
                autocmd BufWritePre * :call TrimWhitespace()
            augroup END
        ]],
        false
    )

    vim.api.nvim_exec(
        [[
            augroup YankHighlight
                autocmd!
                autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
            augroup END
        ]],
        false
    )
end

function M.setup()
    M.auto_cmds()

    -- vim.g.python3_host_prog = "/usr/local/bin/python3"
end

return M
