return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				-- override = {
				-- 	["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				-- 	["vim.lsp.util.stylize_markdown"] = true,
				-- 	["cmp.entry.get_documentation"] = true,
				-- },
				progress = { enabled = false },
				hover = { enabled = false },
				signature = { enabled = false },
			},
		},
	},
	{
		"folke/trouble.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end,
				{ desc = "toggle trouble" })
			vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostic") end,
				{ desc = "toggle trouble - workspace" })
			vim.keymap.set("n", "<leader>q", function() require("trouble").toggle("document_diagnostics") end,
				{ desc = "toggle trouble - document" })
			vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end,
				{ desc = "toggle trouble - quickfix" })
			vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end,
				{ desc = "toggle trouble - loclist" })
			vim.keymap.set("n", "R", function() require("trouble").toggle("lsp_references") end,
				{ desc = "toggle trouble - references" })

			-- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("lsp_definitions") end,
			-- 	{ desc = "toggle trouble - definitions" })
			-- vim.keymap.set("n", "<leader>xD", function() require("trouble").toggle("lsp_type_definitions") end,
			-- 	{ desc = "toggle trouble - type definitions" })
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {}
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require 'alpha'.setup(require 'alpha.themes.startify'.config)
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require 'ibl'.setup {
				indent = { char = "▏" },
				scope = {
					show_start = false,
					show_end = false,
				}
			}
		end,
	}
}
