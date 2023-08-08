local plugins = {
  require('plugins.completion'),
  require('plugins.editor'),
  require('plugins.git'),
  require('plugins.lsp'),
  require('plugins.motions'),
  require('plugins.pickers'),
  require('plugins.syntax'),
  require('plugins.themes'),
  require('plugins.tools'),

  {
    --------------------------------------------
    -- ⚠️  Plugins in development
    --------------------------------------------

    -- Themes
    { dir = '/home/evan/Plugins/summer-time/', lazy = false },
    { dir = '/home/evan/Plugins/byte-theme/', lazy = false },
    { dir = '/home/evan/Plugins/neowal/', lazy = false },

    -- Colorscheme manager
    {
      dir = '/home/evan/Plugins/harmony.nvim/',
      config = function() require('config.harmony') end,
      -- event = 'VeryLazy',
      lazy = false,
      enabled = true,
    },

    -- Color utilities
    -- {
    --   dir = '/home/evan/Plugins/color-space.nvim/',
    --   config = function() require('config.color-space') end,
    --   enabled = true,
    -- },
  },
}

return plugins
