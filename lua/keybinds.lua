local set = vim.keymap.set

-- centered while scrolling --

-- set('n', 'j', 'jzz')
-- set('n', 'k', 'kzz')
set('n', '<C-u>', '<C-u>zz')
set('n', '<C-d>', '<C-d>zz')
-- set('n', 'G', 'Gzz')

-- buffers related --

set('n', '<leader>j', ':bprevious<CR>')
set('n', '<leader>k', ':bnext<CR>')
set('n', '<leader>t', ':b#<CR>')

-- splits related --

set('n', '<leader>h', '<C-w>h')
set('n', '<leader>l', '<C-w>l')

-- saving --

set('n', 'W', ':w<CR>')
set('n', 'Q', ':q<CR>')
set('i', 'jk', '<Esc>')
set('i', 'kj', '<Esc>')
set('n', 'E', '$')
set('n', 'B', '^')
set('n', '<C-n>', ':e ')
set('n', '<C-t>', ':vs ')
