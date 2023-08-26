return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    cmd = { "TSUpdateSync" },
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "comment",
            "cuda",
            "cpp",
            "css",
            "dockerfile",
            "elm",
            "fish",
            "git_config",
            "git_rebase",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "graphql",
            "hcl",
            "ini",
            "html",
            "java",
            "jq",
            "javascript",
            "json",
            "lua",
            "luadoc",
            "luap",
            "sql",
            "ruby",
            "rust",
            "pug",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "tsx",
            "toml",
            "terraform",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        indent = { enable = true },
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<S-Tab>", -- normal mode
                node_incremental = "<Tab>", -- visual mode
                node_decremental = "<S-Tab>", -- visual mode
            },
        },
        -- extensions
        textobjects = {
            enable = true,
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>s"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>S"] = "@parameter.inner",
                },
            },

            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                },
            },
        },
        autotag = {
            enable = true,
            filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
        },
        rainbow = { enable = true }, -- really need?
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
        },
        context_commentstring = {
            enable = true,
            config = {
                javascriptreact = { style_element = "{/*%s*/}" },
            },
        },
        matchup = {
            enable = true,
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
