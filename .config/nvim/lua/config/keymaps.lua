local set = vim.keymap.set

vim.g.mapleader = ' '

-- Window Navigation
set('n', '<C-j>', '<C-w>j', { desc = 'Move to window below' })
set('n', '<C-k>', '<C-w>k', { desc = 'Move to window above' })
set('n', '<C-l>', '<C-w>l', { desc = 'Move to window right' })
set('n', '<C-h>', '<C-w>h', { desc = 'Move to window left' })
