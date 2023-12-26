-- misc

vim.keymap.set('n', 'E', '$')
vim.keymap.set('n', 'B', '^')

vim.keymap.set('n', '<C-n>', ':e ')
vim.keymap.set('n', '<C-t>', ':vs ')

-- paste / duplicate

vim.keymap.set('n', '<C-s>', 'yyp')
vim.keymap.set('i', '<C-s>', '<Esc>yyp')
-- vim.keymap.set('n', '<C-S>', 'yyP')
-- vim.keymap.set('i', '<C-S>', '<Esc>yyP')
-- vim.keymap.set('n', '<C-s>', 'ddp') -- move line down
-- vim.keymap.set('n', '<C-s>', 'ddkP') -- move line up
vim.keymap.set('n', '<leader><CR>', 'o<Esc>')

vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>yy', '"+yy')
vim.keymap.set('v', '<leader>y', '"+y')

-- vim.keymap.set('i', '<leader><leader>', '<Esc>/<++><CR>"_c4l') -- luke magic


-- centered while scrolling --

-- vim.keymap.set('n', 'j', 'jzz')
-- vim.keymap.set('n', 'k', 'kzz')
-- vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- vim.keymap.set('n', '<C-d>', '<C-d>zz')
-- vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- substitutions

vim.keymap.set('n', 's', ':s//g<left><left>')
vim.keymap.set('v', 's', ':s//g<left><left>')

vim.keymap.set('n', 'S', ':%s//gc<left><left><left>')

-- buffers / splits related --

vim.keymap.set('n', '<leader>j', ':bprevious<CR>')
vim.keymap.set('n', '<leader>k', ':bnext<CR>')
vim.keymap.set('n', '<leader>t', ':b#<CR>')
vim.keymap.set('n', '<leader>d', ':bdelete<CR>')

vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- saving --

vim.keymap.set('n', 'W', ':w<CR>')
vim.keymap.set('n', 'Q', ':q<CR>')

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

-- lsp testing --

vim.keymap.set('n', '<leader>i', '<Cmd>LspInfo<CR>')
vim.keymap.set('n', '<leader>z', '<Cmd>Lazy<CR>')
