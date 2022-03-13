local M = {}

function M.setup()
    local actions = require "telescope.actions"

    require("telescope").setup {
        find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        use_less = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = false,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            media_files = { filetypes = { "png", "jpg", "mp4", "webm", "pdf", "gif" } },
        },
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,
                },
            },
        },
    }

    require("telescope").load_extension "fzf"
    require("telescope").load_extension "neoclip"
    -- require("telescope").load_extension "dap"
    -- require("telescope").load_extension "project"
    -- require("telescope").load_extension "media_files"
    require("telescope").load_extension "frecency"
    require("telescope").load_extension "file_browser"
    -- require("telescope").load_extension("gkeep")

    M.search_dotfiles = function()
        require("telescope").extensions.file_browser.file_browser {
            prompt_title = "< VimRC >",
            cwd = "$HOME/.config/nvim/",
        }
    end

    M.switch_projects = function()
        require("telescope").extensions.file_browser.file_browser {
            prompt_title = "< Switch Project >",
            cwd = "$HOME/Work/",
        }
    end
end

return M
