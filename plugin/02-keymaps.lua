vim.g.mapleader = ' '

local map = vim.keymap.set

-- General keybinds
map('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Focus left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Focus down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Focus up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Focus right' })

-- Easier interaction with the system clipboard
map({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank to OS clipboard' })
map({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste OS clipboard' })
map({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste OS clipboard before' })
