local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_ok then
  return
end

nvim_tree.setup()

vim.keymap.set('n', '<Leader>e', '<Cmd>NvimTreeToggle<CR>')
