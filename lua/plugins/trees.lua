return {
    "nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	enabled = true,
    build = ":TSUpdate",
    config = function()
        require"nvim-treesitter.configs".setup({
            ensure_installed = { "c", "cpp", "html", "css", "javascript", "lua", "java", "make", "python", "vimdoc", "vim", "query" },
            sync_install = false,

            highlight = { enable = true },
            indent = { enable = true },

			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["am"] = "@function.outer",
						["im"] = "@function.inner",

						["af"] = "@call.outer",
						["if"] = "@call.inner",

						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",

						["al"] = "@loop.outer",
						["il"] = "@loop.inner",

						["at"] = "@comment.outer",
						["it"] = "@comment.outer",

						["ac"] = "@class.outer",
						-- You can optionally set descriptions to the mappings (used in the desc parameter of
						-- nvim_buf_set_keymap) which plugins like which-key display
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },

						-- You can also use captures from other query groups like `locals.scm`
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						['@function.outer'] = 'V', -- linewise
						['@class.outer'] = 'V', -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding or succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
					-- include_surrounding_whitespace = true,
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]c"] = { query = "@class.outer", desc = "Next class start" },
					["]l"] = "@loop.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]C"] = "@class.outer",
					["]L"] = "@loop.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[c"] = "@class.outer",
					["[l"] = "@loop.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[C"] = "@class.outer",
					["[L"] = "@loop.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
					["<leader>m"] = "@function.outer",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
					["<leader>M"] = "@function.outer",
				},
			}
        })
		local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end
}
