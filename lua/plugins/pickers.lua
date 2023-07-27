return {
  -- File Finder
  --- @url https://github.com/nvim-telescope/telescope.nvim
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    config = function() require('config.telescope') end,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-symbols.nvim' },
  },
}
