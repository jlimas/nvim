local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_setup.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/which-key.nvim'
  use 'sheerun/vim-polyglot'
  use 'easymotion/vim-easymotion'
  use 'RRethy/vim-illuminate'
  use 'akinsho/toggleterm.nvim'
  use 'johann2357/nvim-smartbufs'
  use 'pantharshit00/vim-prisma'

  -- Themes
  use 'EdenEast/nightfox.nvim'
  use 'shaunsingh/nord.nvim'

  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'onsails/lspkind.nvim'
  use 'goolord/alpha-nvim'

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

  -- Disabled until it's stable
  -- use 'nvim-orgmode/orgmode'

  use { 'startup-nvim/startup.nvim', requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'jose-elias-alvarez/null-ls.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end }
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', } }
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
