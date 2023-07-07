local ok, dap, dap_python, debugpy = pcall(function()
    return require "dap", require "dap-python", require "debugpy"
end)
if not ok then
    return
end

debugpy.run = function(config)
    dap.run(vim.tbl_extend('keep', config, { justMyCode = false }))
end

dap_python.setup('~/.virtualenvs/debugpy/bin/python3')
