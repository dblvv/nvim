return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require("lualine").setup {
            options = {
                theme = 'catppuccin-mocha',
                component_separators = { left = '|', right = '|' },
                section_separators = ''
            },
            sections = {
                lualine_a = { 'buffers' },
              --lualine_b = { 'mode' },
                lualine_b = { 'branch', 'diffs', 'diagnostics', },
                lualine_c = {},
            },
            inactive_sections = {
              --lualine_b = { 'branch' }
            },
            globalstatus = true
        }
    end
}
