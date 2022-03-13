local M = {}

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = false,
    noremap = true,
    nowait = true,
}

local mappings = {
    ["w"] = { "<Cmd>w<Cr>", "Save" },
    ["q"] = { "<Cmd>q<Cr>", "Quit" },

    -- System
    ["z"] = {
        name = "System",
        z = {
            "<Cmd>lua require('config.telescope').search_dotfiles()<CR>",
            "Configuration",
        },
    },

    -- Buffer
    b = {
        name = "Buffer",
        a = { "<Cmd>%bd|e#<Cr>", "Delete all buffers" },
        d = { "<Cmd>bd<Cr>", "Delete current buffer" },
        l = { "<Cmd>ls<Cr>", "List buffers" },
        n = { "<Cmd>bn<Cr>", "Next buffer" },
        p = { "<Cmd>bp<Cr>", "Previous buffer" },
        f = { "<Cmd>bd!<Cr>", "Force delete current buffer" },
    },

    -- Quick fix
    c = {
        name = "Quickfix",
        o = { "<Cmd>copen<Cr>", "Open quickfix" },
        c = { "<Cmd>cclose<Cr>", "Close quickfix" },
        n = { "<Cmd>cnext<Cr>", "Next quickfix" },
        p = { "<Cmd>cprev<Cr>", "Previous quickfix" },
        x = { "<Cmd>cex []<Cr>", "Clear quickfix" },
    },

    -- File
    f = {
        name = "File",
        b = { "<Cmd>lua require('telescope.builtin').buffers()<Cr>", "Search buffers" },
        f = { "<Cmd>lua require('telescope.builtin').git_files()<Cr>", "Git files" }, -- or DashboardFindFile
        g = { "<Cmd>lua require('telescope.builtin').live_grep()<Cr>", "Live grep" },
        s = { "<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<Cr>", "Current buffer grep" },
        h = { "<Cmd>lua require('telescope.builtin').help_tags()<Cr>", "Help" },
        v = { "<Cmd>lua require('telescope').extensions.file_browser.file_browser()<Cr>", "Pop-up file browser" },
        r = { "<Cmd>lua require('telescope').extensions.frecency.frecency()<Cr>", "Recent file" },
        x = { "<Cmd>DashboardFindHistory<Cr>", "History" },
        m = { "<Cmd>DashboardJumpMark<Cr>", "Mark" },
        n = { "<Cmd>DashboardNewFile<Cr>", "New file" },
        a = { "<Cmd>xa<Cr>", "Save all & quit" },
        e = { "<Cmd>NvimTreeToggle<CR>", "Explorer" },
    },

    -- Project
    p = {
        name = "Project",
        s = {
            "<Cmd>lua require('config.telescope').switch_projects()<CR>",
            "Search files",
        },
        p = {
            "<Cmd>lua require('telescope').extensions.project.project({change_dir= true})<Cr>",
            "List projects",
        },
    },

    -- Easymotion
    ["<Space>"] = { name = "Easymotion" },

    -- Testing
    t = {
        name = "Test",
        n = { "<Cmd>w<CR>:TestNearest<CR>", "Test nearest" },
        f = { "<Cmd>w<CR>:TestFile<CR>", "Test file" },
        s = { "<Cmd>w<CR>:TestSuite<CR>", "Test suite" },
        l = { "<Cmd>w<CR>:TestLast<CR>", "Test last" },
        v = { "<Cmd>w<CR>:TestVisit<CR>", "Test visit" },
    },

    -- Run
    r = {
        name = "Run",
        x = "Swap next parameter",
        X = "Swap previous parameter",
        s = { "<Cmd>lua require'sniprun'.run()<CR>", "Run snippets" },
    },

    -- Git signs
    h = {
        name = "Git signs",
        b = "Blame line",
        p = "Preview hunk",
        R = "Reset buffer",
        s = "Stage hunk",
        S = "Stage buffer",
        u = "Undo stage hunk",
        U = "Reset buffer index",
    },

    -- Git
    g = {
        name = "Source code",
        s = { "<Cmd>Git<Cr>", "Git status" },
        p = { "<Cmd>Git push<Cr>", "Git push" },
        b = { "<Cmd>Git branch<Cr>", "Git branch" },
        e = { "<Cmd>Git commit<Cr>", "Git commit" },
        x = { "<Cmd>Gvdiffsplit<Cr>", "Git diff" },
        f = { "<Cmd>Git fetch --all<Cr>", "Git fetch" },
        v = { "<Cmd>DiffviewOpen<Cr>", "Diffview open" },
        c = { "<Cmd>DiffviewClose<Cr>", "Diffview close" },
        ["r"] = {
            name = "Rebase",
            u = {
                "<Cmd>Git rebase upstream/master<Cr>",
                "Git rebase upstream/master",
            },
            o = {
                "<Cmd>Git rebase origin/master<Cr>",
                "Git rebase origin/master",
            },
        },
    },
}

local vmappings = {
    h = { name = "Git signs" },
    r = {
        name = "Run",
        s = { "<Cmd>lua require'sniprun'.run('v')<CR>", "Run snippets" },
    },
    b = {
        name = "Buffer",
        h = { ":fold<CR>", "Hide/fold code" },
    },
}

local lsp_mappings = {
    g = {
        name = "LSP",
        r = { "<Cmd>lua require('telescope.builtin').lsp_references()<CR>", "References" },
        o = { "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Document symbols" },
        h = { "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Implementations" },
        d = { "<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Definitions" },
        D = { "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definitions" },
        a = { "<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", "Code actions" },
        n = { "<Cmd>update<CR>:Neoformat<CR>", "Neoformat" },
        t = { "<Cmd>TroubleToggle<CR>", "Trouble" },
    },
    r = {
        n = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    },
}


local harpoon_mappings = {
    ["<C-a>"] = {
        "<Cmd>lua require('harpoon.mark').add_file()<Cr>",
        "Add file to harpoon",
    },
    ["<C-e>"] = {
        "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>",
        "Harpoon quick menu",
    },
    ["<C-a>"] = {
        "<Cmd>lua require('harpoon.ui').nav_prev()<Cr>",
        "Harpoon previous file",
    },
    ["<C-s>"] = {
        "<Cmd>lua require('harpoon.ui').nav_next()<Cr>",
        "Harpoon next file",
    },
}

local harpoon_opts = {
    mode = "n",
    prefix = "",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local lsp_mappings_opts = {
    {
        "document_formatting",
        { ["lf"] = { "<Cmd>lua vim.lsp.buf.formatting()<CR>", "Format" } },
    },
    {
        "code_lens",
        {
            ["ll"] = {
                "<Cmd>lua vim.lsp.codelens.refresh()<CR>",
                "Codelens refresh",
            },
        },
    },
    {
        "code_lens",
        { ["ls"] = { "<Cmd>lua vim.lsp.codelens.run()<CR>", "Codelens run" } },
    },
}

local dap_nvim_dap_mappings = {
    d = {
        name = "DAP",
        b = { "<Cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint" },
        c = { "<Cmd>lua require('dap').continue()<CR>", "Continue" },
        s = { "<Cmd>lua require('dap').step_over()<CR>", "Step over" },
        i = { "<Cmd>lua require('dap').step_into()<CR>", "Step into" },
        o = { "<Cmd>lua require('dap').step_out()<CR>", "Step out" },
        u = { "<Cmd>lua require('dapui').toggle()<CR>", "Toggle UI" },
        p = { "<Cmd>lua require('dap').repl.open()<CR>", "REPL" },
        e = { '<Cmd>lua require"telescope".extensions.dap.commands{}<CR>', "Commands" },
        f = { '<Cmd>lua require"telescope".extensions.dap.configurations{}<CR>', "Configurations" },
        r = { '<Cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', "List breakpoints" },
        v = { '<Cmd>lua require"telescope".extensions.dap.variables{}<CR>', "Variables" },
        m = { '<Cmd>lua require"telescope".extensions.dap.frames{}<CR>', "Frames" },
    },
}

function M.register_lsp(client)
    local wk = require "which-key"
    wk.register(lsp_mappings, opts)

    for _, m in pairs(lsp_mappings_opts) do
        local capability, key = unpack(m)
        if client.resolved_capabilities[capability] then
            wk.register(key, opts)
        end
    end
end

function M.register_dap()
    local wk = require "which-key"
    wk.register(dap_nvim_dap_mappings, opts)
    vim.g.my_debugger = "d"
end

function M.setup()
    local wk = require "which-key"
    wk.setup {}
    wk.register(mappings, opts)
    wk.register(vmappings, vopts)
    wk.register(harpoon_mappings, harpoon_opts)
end

return M
