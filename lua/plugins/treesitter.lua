{
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  install_dir = vim.fn.stdpath('data') .. '/site'
}
