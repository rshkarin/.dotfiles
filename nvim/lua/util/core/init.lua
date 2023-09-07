local M = {}

function M.has(plugin)
    return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end,
    })
end

function M.opts(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require "lazy.core.plugin"
    return Plugin.values(plugin, "opts", false)
end

local terminals = {}

function M.float_term(cmd, opts)
    opts = vim.tbl_deep_extend("force", {
        ft = "lazyterm",
        size = { width = 0.9, height = 0.9 },
    }, opts or {}, { persistent = true })

    local termkey = vim.inspect { cmd = cmd or "shell", cwd = opts.cwd, env = opts.env, count = vim.v.count1 }

    if terminals[termkey] and terminals[termkey]:buf_valid() then
        terminals[termkey]:toggle()
    else
        terminals[termkey] = require("lazy.util").float_term(cmd, opts)
        local buf = terminals[termkey].buf
        vim.b[buf].lazyterm_cmd = cmd
        if opts.esc_esc == false then
            vim.keymap.set("t", "<esc>", "<esc>", { buffer = buf, nowait = true })
        end
        if opts.ctrl_hjkl == false then
            vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
            vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
            vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true })
            vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true })
        end

        vim.api.nvim_create_autocmd("BufEnter", {
            buffer = buf,
            callback = function()
                vim.cmd.startinsert()
            end,
        })
    end

    return terminals[termkey]
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
function M.get_root()
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil

    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end

    table.sort(roots, function(a, b)
        return #a > #b
    end)

    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()

        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end

    return root
end
return M
