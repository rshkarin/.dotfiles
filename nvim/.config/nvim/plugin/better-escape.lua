local ok, bescape = pcall(require, "better_escape")
if not ok then
    return
end

bescape.setup()
