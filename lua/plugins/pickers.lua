--------------------------------------------
-- Pickers
--------------------------------------------
local icons = require('icons').diagnostics

return {
  {
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    init = function() require('config.telescope') end,
    dependencies = {
      'nvim-telescope/telescope-symbols.nvim',
      'nvim-telescope/telescope-project.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'folke/which-key.nvim',
    opts = require('config.whichkey'),
    config = function(_, opts)
      local keys = require('config.whichkey.keys')
      require('which-key').register(keys.leader, {
        mode = 'n',
        silent = true,
        prefix = '<Space>',
      })
      require('which-key').register(keys.cr, {
        mode = 'n',
        prefix = '<CR>',
      })
      require('which-key').setup(opts)
    end,
    keys = { '<Leader>', '<CR>' },
  },

  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {
      fold_open = ' ',
      fold_closed = ' ',
      multiline = false,
      icons = false,
      group = false,
      indent_lines = false,
      padding = false,
      action_keys = {
        jump_close = { '<cr>' },
      },
      signs = {
        error = icons.ERROR,
        warning = icons.WARN,
        hint = icons.HINT,
        information = icons.INFO,
      },
    },
  },
}
