return {
    -- file explorer
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v3.x",
    --     cmd = "Neotree",
    --     keys = {
    --         {
    --             "<leader>fe",
    --             function()
    --                 require("neo-tree.command").execute { toggle = true, dir = require("util.core").get_root() }
    --             end,
    --             desc = "Explorer NeoTree (root dir)",
    --         },
    --         {
    --             "<leader>fE",
    --             function()
    --                 require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() }
    --             end,
    --             desc = "Explorer NeoTree (cwd)",
    --         },
    --     },
    --     deactivate = function()
    --         vim.cmd [[Neotree close]]
    --     end,
    --     init = function()
    --         if vim.fn.argc() == 1 then
    --             local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --             if stat and stat.type == "directory" then
    --                 require "neo-tree"
    --             end
    --         end
    --     end,
    --     opts = {
    --         sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    --         open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    --         filesystem = {
    --             bind_to_cwd = false,
    --             follow_current_file = { enabled = true },
    --             use_libuv_file_watcher = true,
    --         },
    --         window = {
    --             mappings = {
    --                 ["<space>"] = "none",
    --             },
    --         },
    --         default_component_configs = {
    --             indent = {
    --                 with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
    --                 expander_collapsed = "",
    --                 expander_expanded = "",
    --                 expander_highlight = "NeoTreeExpander",
    --             },
    --         },
    --     },
    --     config = function(_, opts)
    --         require("neo-tree").setup(opts)
    --         vim.api.nvim_create_autocmd("TermClose", {
    --             pattern = "*lazygit",
    --             callback = function()
    --                 if package.loaded["neo-tree.sources.git_status"] then
    --                     require("neo-tree.sources.git_status").refresh()
    --                 end
    --             end,
    --         })
    --     end,
    -- },

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
                    require "neo-tree"
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
                    folder_empty = "",
                    default = "",
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

            local inputs = require "neo-tree.ui.inputs"

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
        end,
        keys = {
            { "<leader>b", mode = { "n" }, "<cmd>Neotree toggle show buffers right<cr>", desc = "Show neotree" },
            { "<leader>fe", mode = { "n" }, "<cmd>Neotree toggle left<cr>", desc = "Toggle neotree" },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- project management
            {
                "ahmedkhalf/project.nvim",
                opts = {},
                config = function(_, opts)
                    require("project_nvim").setup(opts)
                    require("telescope").load_extension "projects"
                end,
                keys = {
                    { "<leader>pp", "<Cmd>Telescope projects<CR>" },
                },
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = { "kkharji/sqlite.lua" },
                config = function()
                    require("telescope").load_extension "frecency"
                end,
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension "fzf"
                end,
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
                config = function()
                    require("telescope").load_extension "file_browser"
                end,
            },
            {
                "AckslD/nvim-neoclip.lua",
                dependencies = { "kkharji/sqlite.lua" },
                config = function()
                    require("neoclip").setup()
                    require("telescope").load_extension "neoclip"
                end,
            },
            {
                "debugloop/telescope-undo.nvim",
                config = function()
                    require("telescope").load_extension "undo"
                end,
            },
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
                mappings = {
                    i = {
                        ["<C-Down>"] = function(...)
                            return require("telescope.actions").cycle_history_next(...)
                        end,
                        ["<C-Up>"] = function(...)
                            return require("telescope.actions").cycle_history_prev(...)
                        end,
                        ["<C-f>"] = function(...)
                            return require("telescope.actions").preview_scrolling_down(...)
                        end,
                        ["<C-b>"] = function(...)
                            return require("telescope.actions").preview_scrolling_up(...)
                        end,
                    },
                    n = {
                        ["q"] = function(...)
                            return require("telescope.actions").close(...)
                        end,
                    },
                },
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
                        mappings = {
                            i = {
                                ["<CR>"] = function(...)
                                    return require("telescope-undo.actions").yank_additions(...)
                                end,
                                ["<S-CR>"] = function(...)
                                    return require("telescope-undo.actions").yank_deletions(...)
                                end,
                                ["<C-CR>"] = function(...)
                                    return require("telescope-undo.actions").restore(...)
                                end,
                            },
                        },
                    },
                },
            },
        },
        keys = {
            {
                "<leader>zz",
                function()
                    require("telescope").extensions.file_browser.file_browser {
                        prompt_title = "< VimRC >",
                        cwd = "$HOME/.config/nvim/",
                    }
                end,
                desc = "Search dotfiles",
            },
            {
                "<leader>ps",
                function()
                    require("telescope").extensions.file_browser.file_browser {
                        prompt_title = "< Switch Project >",
                        cwd = "$HOME/Work/",
                    }
                end,
                desc = "Switch projects",
            },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").git_files()
                end,
                desc = "Find git files",
            },
            {
                "<leader>fg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Search in project",
            },
            {
                "<leader>fs",
                function()
                    require("telescope.builtin").current_buffer_fuzzy_find()
                end,
                desc = "Search in current buffer",
            },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            {
                "<leader>fv",
                function()
                    require("telescope").extensions.file_browser.file_browser()
                end,
                desc = "File browser",
            },
            {
                "<leader>fr",
                function()
                    require("telescope").extensions.frecency.frecency()
                end,
            },
        },
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
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

              -- stylua: ignore start
              -- map("n", "]h", gs.next_hunk, "Next Hunk")
              -- map("n", "[h", gs.prev_hunk, "Prev Hunk")
              -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
              -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
              -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
              -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
              -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
              -- map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
              map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                -- map("n", "<leader>ghd", gs.diffthis, "Diff This")
                -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
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
        keys = {
            { "<leader>gt", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble" },
        },
    },

    -- classic undotree
    {
        "mbbill/undotree",
        init = function()
            vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
        end,
    },

    -- code outline window
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            layout = {
                width = 40,
                default_direction = "right",
                placement = "edge",
            },
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
            end,
        },
        keys = {
            { "<leader>l", "<cmd>AerialToggle!<CR>", desc = "Aerial" },
        },
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
        end,
    },

    -- git commit browser
    { "junegunn/gv.vim" },

    -- git diffview
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
            { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
        },
    },

    -- automatic indentation detection
    { "tpope/vim-sleuth" },

    -- movements across document
    {
        "phaazon/hop.nvim",
        branch = "v2",
        opts = {
            keys = "etovxqpdygfblzhckisuran",
        },
        keys = {
            { "ff", "<Cmd>HopWordCurrentLine<CR>", desc = "Hop current line" },
            { "ft", "<Cmd>HopWord<CR>", desc = "Hop whole buffer" },
        },
    },

    -- alternative to hop
    {
        "ggandor/leap.nvim",
        opts = {
            case_sensitive = true,
        },
        keys = {
            { "r", mode = { "n", "x", "o" }, "<Plug>(leap-forward-to)", desc = "Leap forward" },
            { "R", mode = { "n", "x", "o" }, "<Plug>(leap-backward-to)", desc = "Leap backward" },
        },
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
        },
    },

    {
        "nvim-pack/nvim-spectre",
        config = function(_, opts)
            require("spectre").setup(opts)
        end,
        keys = {
            { "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", desc = "Toggle Spectre" },
            {
                "<leader>sw",
                "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
                desc = "Search current word",
            },
            {
                "<leader>sw",
                mode = { "v" },
                "<esc><cmd>lua require('spectre').open_visual()<CR>",
                desc = "Search current word",
            },
            {
                "<leader>sp",
                "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>",
                desc = "Spectre file",
            },
        },
    },
}
