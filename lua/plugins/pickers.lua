--------------------------------------------
-- Pickers
--------------------------------------------

return {
  -- File Finder
  --- @url https://github.com/nvim-telescope/telescope.nvim
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    config = function() require('config.telescope') end,
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-symbols.nvim' },
  },

  -- Goto definitions/references window
  --- @url https://github.com/dnlhc/glance.nvim
  {
    'dnlhc/glance.nvim',
    opts = { preview_win_opts = { relativenumber = false } },
    -- event = 'LspAttach',
  },

  -- Details Window
  --- @url https://github.com/folke/trouble.nvim
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
  },
}
