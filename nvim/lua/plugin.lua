local conf = require('config')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.api.nvim_command("!git clone https://github.com/folke/lazy.nvim.git " .. lazypath)
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  { 'glepnir/flipped.nvim', config = conf.flipped },
  { 'nvim-lua/plenary.nvim' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'akinsho/bufferline.nvim', config = conf.nvim_bufferline },
  { 'glepnir/whiskyline.nvim', config = conf.whisky },
  { 'lukas-reineke/indent-blankline.nvim', config = conf.indent_blankline },
  { 'kyazdani42/nvim-tree.lua', config = conf.nvim_tree },
  { 'windwp/nvim-autopairs', config = conf.autopairs },
  { 'lewis6991/gitsigns.nvim', config = conf.gitsigns },
  { 'nvim-telescope/telescope.nvim', config = conf.telescope },
  { 'nvim-telescope/telescope-fzy-native.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-treesitter/nvim-treesitter', config = conf.nvim_treesitter },
  { 'windwp/nvim-ts-autotag', ft = {'html', 'typescript', 'jsx', 'tsx'}, config = conf.autotag },
  { 'glepnir/coman.nvim' },
  { 'neovim/nvim-lspconfig', config = conf.nvim_lsp },
  { 'glepnir/lspsaga.nvim', config = conf.lspsaga },
  { 'hrsh7th/nvim-cmp', config = conf.nvim_cmp },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'L3MON4D3/LuaSnip', config = conf.lua_snip },
  { 'saadparwaiz1/cmp_luasnip' },
})
