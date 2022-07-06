require 'telescope'.setup({
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
})

vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
