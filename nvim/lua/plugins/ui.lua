return {
    -- better vim.ui
  {
    "stevearc/dressing.nvim",
    opts = {
        input = {
            enabled = false, -- native vim input is pretty nice for many reasons
            border = "single",
            win_options = {
                winblend = 10,
                winhighlight = "Normal:DressingInputNormalFloat,NormalFloat:DressingInputNormalFloat,FloatBorder:DressingInputFloatBorder",
            },
        },
    },
  },

    -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "SmiteshP/nvim-navic",
            lazy = true,
            dependencies = {
                "neovim/nvim-lspconfig",
            },
            init = function()
                vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(args)
                        local bufnr = args.buf
                        local client = vim.lsp.get_client_by_id(args.data.client_id)
                        if client.supports_method "textDocument/documentSymbol" then
                            require("navic").attach(client, bufnr)
                        end
                    end,
                })
            end
        },
    },
    opts = function()
        local navic = require("nvim-navic")

        local function attached_clients()
            return "(" .. vim.tbl_count(vim.lsp.buf_get_clients(0)) .. ")"
        end

        local function cwd()
            return vim.fn.fnamemodify(vim.loop.cwd(), ":~")
        end

        return {
            options = {
                disabled_filetypes = { "neo-tree" },
                theme = "gruvbox",
            },
            sections = {
                lualine_b = { "branch", "diff", cwd },
                lualine_c = { "filename", navic.get_location },
                lualine_x = {
                    { "diagnostics", sources = { "nvim_diagnostic" } },
                    "filesize",
                    "encoding",
                    { "filetype", separator = { right = "" }, right_padding = 0 },
                    { attached_clients, separator = { left = "" }, left_padding = 0 },
                },
            },
            inactive_sections = {},
            extensions = { "quickfix", "toggleterm", "fugitive" },
        }
    end,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- dashboard
  { "mhinz/vim-startify" },

  -- LSP loading progress
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
  }
}
