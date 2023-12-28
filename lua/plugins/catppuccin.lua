return {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    priority = 1000,
    opts = {
        term_colors = true,
        color_overrides = {
            mocha = {
                base = "#000000",
--              mantle = "#000000",
--				crust = "#000000",
            },
        },
        integrations = {
            cmp = true,
            mason = true,
            treesitter = true,
            telescope = { enabled = true } ,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
        }
    },
--	config = function ()
--		vim.cmd.colorscheme 'catppuccin-mocha'
--	end
}
