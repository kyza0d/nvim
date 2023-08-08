--------------------------------------------
-- Motions / Keystrokes
--------------------------------------------

return {
  -- Keystroke-based commands
  --- @url https://github.com/folke/which-key.nvim
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function() require('config.whichkey') end,
  },

  -- Tmux integration
  --- @url https://github.com/aserowy/tmux.nvim
  {
    'aserowy/tmux.nvim',
    config = function() require('tmux').setup({}) end,
    -- event = 'VeryLazy',
  },

  -- Surround motions
  --- @url https://github.com/kylechui/nvim-surround
  {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup({}) end,
    -- event = 'VeryLazy',
  },

  -- Align motions
  --- @url https://github.com/Vonr/align.nvim
  'Vonr/align.nvim',
}
