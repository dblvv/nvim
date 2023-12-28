return {
	'hrsh7th/nvim-cmp',
	event = { "InsertEnter", "CmdlineEnter" },

	dependencies = {
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',

		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		"rafamadriz/friendly-snippets",
	},

	config = function()
		require 'luasnip.loaders.from_vscode'.lazy_load()

		local luasnip = require 'luasnip'
		local cmp = require 'cmp'
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-u>'] = cmp.mapping.scroll_docs(-4),     -- Up
				['<C-d>'] = cmp.mapping.scroll_docs(4),      -- Down
				-- C-b (back) C-f (forward) for snippet placeholder navigation.
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},

				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'buffer' },
				{ name = 'path' }
			}),

			--[[ Cosmetics ]]--
			window = {
				completion = cmp.config.window.bordered {
					border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" }
				},
				documentation = cmp.config.window.bordered {
					border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" }
				},
			},
			formatting = {
				-- fields = { 'abbr', 'kind' },
				format = function(_, vim_item)
					vim_item.kind = ({
						Text = "",
						Method = "󰆧",
						Function = "󰊕",
						Constructor = "",
						Field = "󰇽",
						Variable = "󰂡",
						Class = "󰠱",
						Interface = "",
						Module = "",
						Property = "󰜢",
						Unit = "",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "󰈙",
						Reference = "",
						Folder = "󰉋",
						EnumMember = "",
						Constant = "󰏿",
						Struct = "",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "󰅲",
					})[vim_item.kind]

					-- Source
					-- vim_item.menu = ({
					-- 	buffer = "(buffer)",
					-- 	nvim_lsp = "(lsp)",
					-- 	luasnip = "(snippets)",
					-- 	path = "(path)"
					-- })[entry.source.name]
					vim_item.menu = ""
					return vim_item
				end
			}
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources(
				{ { name = 'path' } },
				{ { name = 'cmdline' } }
			),
			formatting = { fields = { 'abbr' } },
		})
	end
}
