return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            provider = "copilot",
            -- add any opts here
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",      -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
        init = function()
            local avante_grammar_correction =
            'Correct the text to standard English, but keep any code blocks inside intact.'
            local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
            local avante_optimize_code = 'Optimize the following code'
            local avante_summarize = 'Summarize the following text'
            local avante_explain_code = 'Explain the following code'
            local avante_complete_code = 'Complete the following codes written in ' .. vim.bo.filetype
            local avante_add_docstring = 'Add docstring to the following codes'
            local avante_fix_bugs = 'Fix the bugs inside the following codes if any'
            local avante_add_tests = 'Implement tests for the following code'

            vim.keymap.set({"n", "v"}, "<leader>ag",
                function() require('avante.api').ask { question = avante_grammar_correction } end)
            vim.keymap.set("n", "<leader>aal",
                function() require('avante.api').ask { question = avante_code_readability_analysis } end)
            vim.keymap.set("n", "<leader>aao",
                function() require('avante.api').ask { question = avante_optimize_code } end)
            vim.keymap.set("n", "<leader>aam", function() require('avante.api').ask { question = avante_summarize } end)
            vim.keymap.set("n", "<leader>aax",
                function() require('avante.api').ask { question = avante_explain_code } end)
            vim.keymap.set("n", "<leader>aac",
                function() require('avante.api').ask { question = avante_complete_code } end)
            vim.keymap.set("n", "<leader>aad",
                function() require('avante.api').ask { question = avante_add_docstring } end)
            vim.keymap.set("n", "<leader>aab", function() require('avante.api').ask { question = avante_fix_bugs } end)
            vim.keymap.set("n", "<leader>aau", function() require('avante.api').ask { question = avante_add_tests } end)
        end
    }
}
