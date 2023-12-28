-- ============ --
-- bootstrapper --
-- ============ --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.netrw_winsize = 30

-- nvim configuration

vim.g.mapleader = " "
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.title = true
vim.opt.titlestring = " "

-- substitute preview window
vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.expandtab = true
vim.opt.virtualedit = "block"
vim.opt.showtabline = 0

vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.guifont = "FiraCode Nerd Font Mono:h14"

vim.opt.scrolloff = 5

-- vim.cmd "colorscheme slate"
-- vim.keymap.set('n', '<C-.>', ':Lazy<CR>')
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.laststatus = 3
vim.opt.whichwrap = "<,>,[,]"
-- vim.opt.fillchars = {
--    vert = '❘'
-- }

-- vim.opt.list = true
-- vim.opt.listchars = { leadmultispace = "┃   ", tab = "┃ ",}
-- vim.cmd[[hi WinSeparator guibg=None]]
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None" })
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#000000]]

-- lsp handlers

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, {
--     border = "rounded"
--   }
-- )
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--   vim.lsp.handlers.signature_help, {
--     border = "rounded"
--   }
-- )

require'keybinds'

-- Lazy - plugins manager

require("lazy").setup({import = 'plugins'}, {
	ui = { border = "rounded" }
})

vim.cmd.colorscheme 'catppuccin-mocha'
