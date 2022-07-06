vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<esc>')

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>q!<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>bd<cr>')

-- Splits
vim.keymap.set('n', '<S-Right>', '<cmd>vs<cr>')
vim.keymap.set('n', '<S-Down>', '<cmd>sp<cr>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- Easy Motion
vim.keymap.set('n', 's', '<plug>(easymotion-s2)')
vim.keymap.set('n', 't', '<plug>(easymotion-t2)')
