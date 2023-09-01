--------------------------------------------
-- Editor appearance
--------------------------------------------

return {
  {
    'm4xshen/autoclose.nvim',
    event = 'InsertEnter',
    opts = {},
  },

  -- Align motions
  --- @url https://github.com/Vonr/align.nvim
  'Vonr/align.nvim',

  -- Surround motions
  --- @url https://github.com/kylechui/nvim-surround
  {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup({}) end,
    event = 'VeryLazy',
  },
}
