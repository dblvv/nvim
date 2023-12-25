return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-ui-select.nvim',
			'nvim-telescope/telescope-file-browser.nvim',
			-- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			local actions = require 'telescope.actions'
			require 'telescope'.setup {
				extensions = {
					["ui-select"] = { require "telescope.themes".get_dropdown {} }
				},
				defaults = {
					mappings = { i = {
						["<C-q>"] = actions.smart_send_to_qflist,
						["<M-q>"] = actions.smart_send_to_loclist
					}},
					layout_config ={
						horizontal = {
							width = 0.9,
						}
					}
				},
--				pickers = {
--					find_files = {
--						mappings = {
--							n = {
--								["cd"] = function(prompt_bufnr)
--									local dir = vim.fn.fnamemodify(
--										require("telescope.actions.state").get_selected_entry().path, ":p:h"
--									)
--									actions.close(prompt_bufnr)
--									-- Depending on what you want put `cd`, `lcd`, `tcd`
--									vim.cmd(string.format("silent lcd %s", dir))
--								end
--							}
--						}
--					},
--				}
			}
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

			require "telescope".load_extension "file_browser"
			require "telescope".load_extension "ui-select"

			vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
			vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
			vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
			vim.keymap.set('n', '<leader>fb', require "telescope".extensions.file_browser.file_browser, {})
			vim.keymap.set('n', '<leader>f.', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end)
		end
	}
}
