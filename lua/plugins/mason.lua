return {
	"williamboman/mason.nvim",

	cmd = "Mason",

	config = function()
		require 'mason'.setup {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				},
				border = "rounded",
				height = 0.8,
			},
			PATH = "prepend"
		}
	end
}
