local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_setup.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, _ = pcall(require, 'packer')
if not status_ok then
  return
end

require 'packer'.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/which-key.nvim'
  use 'sheerun/vim-polyglot'
  use 'easymotion/vim-easymotion'

  -- LSP Servers / Autocompletion
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'onsails/lspkind.nvim'

  use 'vim-test/vim-test'
  use 'voldikss/vim-floaterm'
  use 'ruanyl/coverage.vim'
  use 'vimwiki/vimwiki'
  use 'mattn/emmet-vim'
  use 'github/copilot.vim'
  use 'tpope/vim-fugitive'
  use 'nvim-treesitter/nvim-treesitter'
  use 'tjdevries/vlog.nvim'
  use 'rcarriga/nvim-notify'
  use 'lewis6991/gitsigns.nvim'
  use 'numToStr/Comment.nvim'
  use 'arkav/lualine-lsp-progress'

  use { 'startup-nvim/startup.nvim', requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'jose-elias-alvarez/null-ls.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end }
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', } }
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }
end)
