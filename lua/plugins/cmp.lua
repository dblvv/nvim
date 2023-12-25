return {

    -- nvim-cmp

    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            "rafamadriz/friendly-snippets"
        },
        config = function()

            require("luasnip.loaders.from_vscode").lazy_load()

            local luasnip = require 'luasnip'
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
				window = {
					completion = cmp.config.window.bordered{ border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" } },
					documentation = cmp.config.window.bordered{ border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" } },
				},
                mapping = cmp.mapping.preset.insert({
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
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
                })
            })
        end
    },

    -- mason

    {
        "williamboman/mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            -- importing mason & mason-lspconfig
            require'mason'.setup{
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    },
					border = "rounded"
                },
				PATH = "prepend"
            }
            require'mason-lspconfig'.setup {
                ensure_installed = { "pyright", "clangd", "lua_ls", "html", "cssls", "tsserver", "jdtls" },
            }
        end
    },

	-- tmp neodev --


    -- lsp

    {
        "neovim/nvim-lspconfig",
        dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			{ "folke/neodev.nvim", opts = {} }
		},
        config = function()
            local lspconfig = require'lspconfig'
            local capabilities = require'cmp_nvim_lsp'.default_capabilities()

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- border
			vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#000000]]
			-- To instead override globally
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or { "╭", " ", "╮", "│", "╯", " ", "╰", "│" }
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end
			require('lspconfig.ui.windows').default_options.border = "rounded"

			-- setting up language servers
            -- ensure_installed = { "clangd", "lua_ls", "jdtls" }, -- "html", "cssls",
            lspconfig.pyright.setup {
				capabilities = capabilities
			}

            lspconfig.clangd.setup {
                capabilities = capabilities
            }

            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } }
                    }
                }
            }

            lspconfig.jdtls.setup{
                capabilities = capabilities,
--				root_dir = function ()
--                    vim.fn.getcwd()
--				end,
			}

			lspconfig.html.setup {
				capabilities = capabilities,
			}

			lspconfig.cssls.setup {
				capabilities = capabilities,
			}

			lspconfig.tsserver.setup {
				capabilities = capabilities,
			}


			-- attaching lsp
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
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end
    }
}
