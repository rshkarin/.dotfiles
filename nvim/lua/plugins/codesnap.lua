return {
    {
        "mistricky/codesnap.nvim",
        build = "make",
        config = function ()
            require("codesnap").setup({
                has_line_number = true,
                title = "",
                watermark = "",
                bg_color = "#ffffff"
            })
        end
    }
}
