local plugins = {
  require('plugins.completion'),
  require('plugins.editor'),
  require('plugins.git'),
  require('plugins.lsp'),
  require('plugins.motions'),
  require('plugins.pickers'),
  require('plugins.syntax'),
  require('plugins.theme'),
  require('plugins.tools'),

  {
    --------------------------------------------
    -- ⚠️   Plugins in development
    --------------------------------------------

    -- Themes
    { dir = '/home/evan/Plugins/summer-time/', event = 'ColorScheme' },
    { dir = '/home/evan/Plugins/byte-theme/', event = 'ColorScheme' },
    { dir = '/home/evan/Plugins/neowal/', event = 'ColorScheme' },

    -- Colorscheme manager
    {
      dir = '/home/evan/Plugins/harmony.nvim/',
      config = function() require('config.harmony') end,
      event = 'VeryLazy',
      enabled = true,
    },

    -- Color utilities
    {
      dir = '/home/evan/Plugins/color-space.nvim/',
      config = function() require('config.color-space') end,
      enabled = false,
    },
  },
}

return plugins
