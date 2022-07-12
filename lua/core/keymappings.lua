-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap options
local opts = { silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- Insert exit fast
keymap('i', 'jk', '<esc>', opts)

-- Clear highlights
keymap('n', '<leader>h', '<cmd>nohlsearch<CR>', opts)

-- Better paste
keymap('v', 'p', '"_dP', opts)

-- Window navigation
keymap('n', '<leader>w', '<cmd>w<cr>', opts)
keymap('n', '<leader>q', '<cmd>q<cr>', opts)
keymap('n', '<leader>x', '<cmd>q!<cr>', opts)
keymap('n', '<leader>c', '<cmd>bd<cr>', opts)

-- Splits
keymap('n', '<S-Right>', '<cmd>vs<cr>', opts)
keymap('n', '<S-Down>', '<cmd>sp<cr>', opts)

-- Resize with arrows
keymap('n', '<C-h>', '<C-w><C-h>', opts)
keymap('n', '<C-l>', '<C-w><C-l>', opts)
keymap('n', '<C-j>', '<C-w><C-j>', opts)
keymap('n', '<C-k>', '<C-w><C-k>', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Easy Motion
keymap('n', 's', '<plug>(easymotion-s2)', opts)
keymap('n', 't', '<plug>(easymotion-t2)', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Git
keymap('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts)
