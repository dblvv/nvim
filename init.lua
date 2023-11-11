

-- bootstrapper

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


-- nvim configuration

vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.termguicolors = true

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
vim.cmd[[hi WinSeparator guibg=None]]

require'keybinds'

-- Lazy - plugins manager

require("lazy").setup({import = 'plugins'})

vim.cmd.colorscheme 'catppuccin-mocha'
