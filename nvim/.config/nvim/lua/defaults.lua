local M = {}

function M.setup()
    vim.g.mapleader = " "
    vim.g.maplocalleader = ","

    vim.cmd [[
	    syntax on
        filetype plugin indent on
        set tabstop=4 softtabstop=4
        set shiftwidth=4
        set expandtab
        set smartindent
        set exrc
        set guicursor=
        set hidden
        set number
        set relativenumber
        set noerrorbells
        set nowrap
        set noswapfile
        set nobackup
        set undodir=~/.config/nvim/undodir
        set undofile
        set incsearch
        set nohlsearch
        set scrolloff=8
        set signcolumn=yes
        set encoding=UTF-8
        set termguicolors
        " set colorcolumn=80

        " Ignore files
        set wildignore+=*.pyc
        set wildignore+=*_build/*
        set wildignore+=**/coverage/*
        set wildignore+=**/node_modules/*
        set wildignore+=**/android/*
        set wildignore+=**/ios/*
        set wildignore+=**/.git/*
    ]]
end

return M
