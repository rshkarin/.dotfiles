local ok, dap_go = pcall(require, "dap-go")
if not ok then
    return
end

dap_go.setup()
