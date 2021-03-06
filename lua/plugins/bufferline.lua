local bufferline_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_ok then
  return
end

bufferline.setup({})

vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
