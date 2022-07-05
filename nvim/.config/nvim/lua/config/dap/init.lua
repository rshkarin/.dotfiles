local M = {}

local utils = require "utils"

function M.dap_setup()
    -- DAPInstall
    -- local dap_install = require "dap-install"
    -- dap_install.setup { installation_path = vim.fn.stdpath "data" .. "/dapinstall/" }

    -- telescope-dap
    require("telescope").load_extension "dap"

    -- nvim-dap-virtual-text. Show virtual text for current frame
    -- vim.g.dap_virtual_text = true
    require("nvim-dap-virtual-text").setup {}
    -- nvim-dap-ui
    require("dapui").setup {}

    -- languages
    require "config.dap.python"
    -- require "config.dap.go"
    require("dap-go").setup()

    -- nvim-dap
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })
end

-- function M.dap_keymappings()
--     -- nvim-dap
--     utils.map("n", "<leader>dc", '<cmd>lua require"dap".continue()<CR>')
--     utils.map("n", "<leader>dsv", '<cmd>lua require"dap".step_over()<CR>')
--     utils.map("n", "<leader>dsi", '<cmd>lua require"dap".step_into()<CR>')
--     utils.map("n", "<leader>dso", '<cmd>lua require"dap".step_out()<CR>')
--     utils.map("n", "<leader>dtb", '<cmd>lua require"dap".toggle_breakpoint()<CR>')
--     utils.map("n", "<leader>dsbr", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
--     utils.map(
--         "n",
--         "<leader>dsbm",
--         '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'
--     )
--     utils.map("n", "<leader>dro", '<cmd>lua require"dap".repl.open()<CR>')
--     utils.map("n", "<leader>drl", '<cmd>lua require"dap".repl.run_last()<CR>')

--     -- telescope-dap
--     utils.map("n", "<leader>dcc", '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
--     utils.map("n", "<leader>dco", '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
--     utils.map("n", "<leader>dlb", '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
--     utils.map("n", "<leader>dv", '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
--     utils.map("n", "<leader>df", '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
-- end

-- function M.auto_cmds()
--     -- Auto-completion DAP REPL
--     vim.api.nvim_exec(
--         [[
--         autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()
--     ]],
--         false
--     )
-- end

function M.setup()
    M.dap_setup()
    -- M.dap_keymapping()
    -- M.auto_cmds()

    -- key mappings
    local wk = require "config.which-key"
    wk.register_dap()
end

return M
