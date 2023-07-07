local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

local actions = require "telescope.actions"
local layout_actions = require "telescope.actions.layout"

telescope.setup {
    defaults = {
        find_command = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
        use_less = true,
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
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
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-l>"] = layout_actions.toggle_preview,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
            },
        },
    },
}

telescope.load_extension "fzf"
telescope.load_extension "neoclip"
-- telescope.load_extension "dap"
telescope.load_extension "project"
telescope.load_extension "frecency"
telescope.load_extension "file_browser"

local search_dotfiles = function()
    require("telescope").extensions.file_browser.file_browser {
        prompt_title = "< VimRC >",
        cwd = "$HOME/.config/nvim/",
    }
end

local switch_projects = function()
    require("telescope").extensions.file_browser.file_browser {
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
