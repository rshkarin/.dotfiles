vim.cmd [[
    let g:gruvbox_contrast_dark = "medium"
    colorscheme gruvbox
    highlight Normal guibg=none

    " let g:gruvbox_material_background = "medium"
    " let g:gruvbox_material_palette = "original"
    " colorscheme gruvbox-material
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
