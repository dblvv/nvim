return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
--    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        mapping = {
          i = {
 --           ["<C-j>"] = actions.move_selection_previous,
 --           ["<C-k>"] = actions.move_selection_next
          }
        }
      }
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  end
}
