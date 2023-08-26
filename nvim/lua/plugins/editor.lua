return {

  -- file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        },
        init = function()
          if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
              require("neo-tree")
            end
          end
        end,
        opts = {
            close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            use_popups_for_input = false,
            enable_git_status = true,
            enable_diagnostics = true,
            use_default_mappings = false,
            default_component_configs = {
                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "ﰊ",
                    default = "*",
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = true,
                    use_git_status_colors = true,
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = "✖", -- this can only be used in the git_status source
                        renamed = "", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "?",
                        ignored = "",
                        unstaged = "M",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                position = "left",
                width = 40,
                mappings = {
                    ["<CR>"] = "open",
                    ["o"] = "open_with_window_picker",
                    ["<C-v>"] = "vsplit_with_window_picker",
                    ["<C-x>"] = "split_with_window_picker",
                    ["t"] = "open_tabnew",
                    ["T"] = "open_tabnew",
                    ["X"] = "close_node",
                    ["K"] = "navigate_up",
                    ["C"] = "set_root",
                    ["H"] = "toggle_hidden",
                    ["R"] = "refresh",
                    ["f"] = "filter_on_submit",
                    ["F"] = "clear_filter",
                    ["a"] = "add",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["m"] = "move",
                    ["c"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["q"] = "close_window",
                    ["]c"] = "next_git_modified",
                    ["[c"] = "prev_git_modified",
                    ["g?"] = "show_help",
                    ["<Tab>"] = { "toggle_preview", config = { use_float = false } },
                    -- reset default mappings
                    ["space"] = "noop",
                    ["<2-LeftMouse>"] = "noop",
                    ["]g"] = "noop",
                    ["[g"] = "noop",
                    ["S"] = "noop",
                    ["s"] = "noop",
                    ["<bs>"] = "noop",
                    ["."] = "noop",
                    ["A"] = "noop",
                    ["/"] = "noop",
                },
                mapping_options = {
                    nowait = true,
                },
            },
            nesting_rules = {},
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_by_name = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                    never_show = { -- remains hidden even if visible is toggled to true
                    },
                },
                follow_current_file = false,
                -- time the current file is changed while the tree is open.
                hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                -- use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                -- instead of relying on nvim autocmd events.
            },
            buffers = {
                show_unloaded = true,
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete",
                    },
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)

            local inputs = require("neo-tree.ui.inputs")

            inputs.confirm = function(message, callback)
                callback(vim.fn.confirm(message, "&Yes\n&No") == 1)
            end

            inputs.input = function(message, default_value, callback, options, completion)
                local input
                if completion then
                    input = vim.fn.input(message .. " ", default_value or "", completion)
                else
                    input = vim.fn.input(message .. " ", default_value or "")
                end
                callback(input)
            end

            vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle show buffers right<cr>")
            vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle left<cr>")
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- project management
            {
                "ahmedkhalf/project.nvim",
                opts = {},
                config = function(_, opts)
                  require("project_nvim").setup(opts)
                  require("telescope").load_extension("projects")
                end,
                keys = {
                  { "<leader>pp", "<Cmd>Telescope projects<CR>" },
                },
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = {"kkharji/sqlite.lua"},
                config = function()
                    require("telescope").load_extension("frecency")
                end,
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
                config = function()
                    require("telescope").load_extension("file_browser")
                end,
            },
            {
                "AckslD/nvim-neoclip.lua",
                dependencies = {"kkharji/sqlite.lua"},
                config = function()
                    require('neoclip').setup()
                    require("telescope").load_extension("neoclip")
                end,
            },
            {
                "debugloop/telescope-undo.nvim",
                config = function()
                    require("telescope").load_extension("undo")
                end,
            }
        },
        cmd = "Telescope",
        version = false,
        opts = {
            defaults = {
                find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
                use_less = true,
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--glob=!.git/",
                },
                sorting_strategy = "descending",
                -- experimental
                layout_strategy = "flex",
                layout_config = {
                    flex = {
                        flip_columns = 161, -- half 27" monitor, scientifically calculated
                    },
                    horizontal = {
                        preview_cutoff = 0,
                        preview_width = 0.6,
                    },
                    vertical = {
                        preview_cutoff = 0,
                        preview_height = 0.65,
                    },
                },
                path_display = { truncate = 3 },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    media_files = { filetypes = { "png", "jpg", "mp4", "webm", "pdf", "gif" } },
                    project = {
                        hidden_files = false,
                    },
                    undo = {
                        side_by_side = true,
                        layout_strategy = "vertical",
                        layout_config = {
                            preview_height = 0.8,
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")

            opts.mappings = {
                    i = {
                        ["<C-j>"] = require("telescope.actions").move_selection_next,
                        ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        ["<C-n>"] = require("telescope.actions").cycle_history_next,
                        ["<C-p>"] = require("telescope.actions").cycle_history_prev,
                        ["<C-l>"] = require("telescope.actions.layout").toggle_preview,
                        ["<Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_next,
                        ["<S-Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_previous,
                    },
                }

            opts.extensions.undo.mappings = {
                i = {
                                ["<CR>"] = require("telescope-undo.actions").yank_additions,
                                ["<S-CR>"] = require("telescope-undo.actions").yank_deletions,
                                ["<C-CR>"] = require("telescope-undo.actions").restore,
                            },
            }

            telescope.setup(opts)

            local search_dotfiles = function()
                telescope.extensions.file_browser.file_browser {
                    prompt_title = "< VimRC >",
                    cwd = "$HOME/.config/nvim/",
                }
            end

            local switch_projects = function()
                telescope.extensions.file_browser.file_browser {
                    prompt_title = "< Switch Project >",
                    cwd = "$HOME/Work/",
                }
            end

            vim.keymap.set("n", "<leader>zz", search_dotfiles)

            vim.keymap.set("n", "<leader>fb", "<Cmd>lua require('telescope.builtin').buffers()<CR>")
            vim.keymap.set("n", "<leader>ff", "<Cmd>lua require('telescope.builtin').git_files()<CR>")
            vim.keymap.set("n", "<leader>fg", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")
            vim.keymap.set("n", "<leader>fs", "<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
            vim.keymap.set("n", "<leader>fh", "<Cmd>lua require('telescope.builtin').help_tags()<CR>")
            vim.keymap.set("n", "<leader>fv", "<Cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>")
            vim.keymap.set("n", "<leader>fr", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>")

            vim.keymap.set("n", "<leader>ps", switch_projects)
            vim.keymap.set("n", "<leader>pp", "<Cmd>lua require('telescope').extensions.project.project({change_dir= true})<CR>")

        end,
    },

    -- git signs highlights text that has changed since the list
    -- git commit, and also lets you interactively stage & unstage
    -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      -- on_attach = function(buffer)
      --   local gs = package.loaded.gitsigns
      --
      --   local function map(mode, l, r, desc)
      --     vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      --   end
      --
      --   -- stylua: ignore start
      --   map("n", "]h", gs.next_hunk, "Next Hunk")
      --   map("n", "[h", gs.prev_hunk, "Prev Hunk")
      --   map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      --   map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      --   map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      --   map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      --   map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      --   map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      --   map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      --   map("n", "<leader>ghd", gs.diffthis, "Diff This")
      --   map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      --   map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      -- end,
    },
  },

    -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
        use_diagnostic_signs = true,
        mode = "workspace_diagnostics",
    },
    config = function(_, opts)
        require("trouble").setup(opts)

        vim.keymap.set("n", "<leader>gt", "<Cmd>TroubleToggle workspace_diagnostics<CR>")
    end,
  },

  -- undotree
 --  {
 --   "mbbill/undotree",
 --   config = function(_, opts)
 --       require("undotree").setup(opts)

   --     vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
  --  end
 -- },

  -- code outline window
  {
    'stevearc/aerial.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
        layout = {
            width = 40,
            default_direction = "right",
            placement = "edge",
        },
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
      end
    },
    config = function(_, opts)
        require("aerial").setup(opts)

        vim.keymap.set("n", "<leader>l", "<cmd>AerialToggle!<CR>")
    end,
  },

  -- git integration
  {
    "tpope/vim-fugitive",
    init = function()
        vim.keymap.set("n", "<leader>gs", "<Cmd>Git<CR>")
        vim.keymap.set("n", "<leader>gp", "<Cmd>Git push<CR>")
        vim.keymap.set("n", "<leader>gb", "<Cmd>Git branch<CR>")
        vim.keymap.set("n", "<leader>ge", "<Cmd>Git commit<CR>")
        vim.keymap.set("n", "<leader>gx", "<Cmd>Gvdiffsplit<CR>")
        vim.keymap.set("n", "<leader>gf", "<Cmd>Git fetch --all<CR>")
        vim.keymap.set("n", "<leader>gx", "<Cmd>Gvdiffsplit<CR>")
    end
  },

  -- git commit browser
  { "junegunn/gv.vim" },

  -- git diffview
  {
    "sindrets/diffview.nvim",
    config = function(_, opts)
        require("diffview").setup(opts)

        vim.keymap.set("n", "<leader>gv", "<Cmd>DiffviewOpen<CR>")
        vim.keymap.set("n", "<leader>gc", "<Cmd>DiffviewClose<CR>")
    end

  },

  -- automatic indentation detection
  { "tpope/vim-sleuth" },

  -- movements across document
  {
    "phaazon/hop.nvim",
    branch = "v2",
    opts = {
        keys = "etovxqpdygfblzhckisuran"
    },
    config = function(_, opts)
        require("hop").setup(opts)

        vim.keymap.set("n", "ff", "<Cmd>HopWordCurrentLine<CR>")
        vim.keymap.set("n", "ft", "<Cmd>HopWord<CR>")
    end
  },

  -- alternative to hop
  {
    "ggandor/leap.nvim",
    opts = {
        case_sensitive = true
    },
    config = function(_, opts)
        require("leap").setup(opts)

        vim.keymap.set({'n', 'x', 'o'}, 'r', '<Plug>(leap-forward-to)')
        vim.keymap.set({'n', 'x', 'o'}, 'R', '<Plug>(leap-backward-to)')
    end
  },

  -- improved f/F/t/T movements
  { "ggandor/flit.nvim" },

  -- dimming the highlights of unused functions, variables, parameters
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    branch = "v2",
    opts = {
      alpha = 0.6,
      hide = {
        virtual_text = false,
        signs = true,
        underline = false,
      },
    },
    config = function (_, opts)
      require("neodim").setup(opts)
    end,
  },

  -- peek to a specific line
  { "nacro90/numb.nvim" },

  -- zen mode
  {
    "folke/zen-mode.nvim",
    opts = {
        window = { width = 0.5 },
        kitty = { font = "+4" },
        tmux = { enabled = false },
        alacritty = {
            enabled = true,
            font = "28", -- font size
        },
    }
  }
}
