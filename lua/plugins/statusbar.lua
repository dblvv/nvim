return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup {
            options = {
                theme = 'catppuccin-mocha',
                component_separators = { left = '|', right = '|' },
                section_separators = ''
            },
            sections = {
                lualine_a = { { 'buffers', use_mode_colors = true } },
              --lualine_b = { 'mode' },
                lualine_c = {},
				lualine_x = {},
				lualine_y = { 'encoding', 'fileformat', 'progress' }
            },
            inactive_sections = {
              --lualine_b = { 'branch' }
            },
            globalstatus = true,
        }
    end
}
