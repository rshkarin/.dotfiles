local M = {}

function M.setup()
    vim.cmd(
        [[
        let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitivehead'
            \ },
        \ }
    ]],
        false
    )
end

return M
