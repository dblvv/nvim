return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	-- nvim-cmp and  HACK: mason integration
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		"williamboman/mason-lspconfig.nvim",
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		require 'mason-lspconfig'.setup {
			ensure_installed = { "pyright", "clangd", "lua_ls", "html", "cssls", "tsserver", "jdtls" },
		}

		--[[ Diagnostics ]]--
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
		-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist) -- via troble instead

		--[[ Cosmetics ]]--

		-- vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
		-- vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
		-- vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
		-- vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

		-- border
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or { "╭", " ", "╮", "│", "╯", " ", "╰", "│" }
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		require('lspconfig.ui.windows').default_options.border = "rounded"


		--[[ Setting up language servers ]]--
		-- ensure_installed = { "pyright", "clangd", "lua_ls", "html", "cssls", "tsserver", "jdtls" }

		local lspconfig = require 'lspconfig'
		local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

		lspconfig.pyright.setup { capabilities = capabilities }

		lspconfig.clangd.setup { capabilities = capabilities }

		lspconfig.lua_ls.setup {
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					-- diagnostics = { disable = { "missing-fields" } }
				}
			}
		}

		lspconfig.jdtls.setup { capabilities = capabilities }

		lspconfig.html.setup { capabilities = capabilities }

		lspconfig.cssls.setup { capabilities = capabilities }

		lspconfig.tsserver.setup { capabilities = capabilities }


		--   Attaching lsp   --
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<space>f', function()
					vim.lsp.buf.format { async = true }
				end, opts)
			end,
		})
	end
}
