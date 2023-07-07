local ok, numb = pcall(require, "numb")
if not ok then
    return
end

numb.setup()
