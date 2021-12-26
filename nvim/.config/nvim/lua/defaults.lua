local M = {}

local cmd = vim.cmd

local bo = vim.bo
local o = vim.o
local wo = vim.wo

local api = vim.api

local indent = 4

function M.setup()
    cmd [[
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
