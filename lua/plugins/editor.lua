--------------------------------------------
-- Editor appearance
--------------------------------------------

return {
  -- Dashboard
  --- @url https://github.com/goolord/alpha-nvim
  {
    'goolord/alpha-nvim',
    -- -- event = 'VimEnter',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- opts = {},
  },

  -- Project-wide Find & Replace

  -- Folding
  --- @url https://github.com/nvim-pack/nvim-spectre
  {
    'nvim-pack/nvim-spectre',
    -- event = 'BufReadPre',
    config = function() require('config.spectre') end,
  },

  -- File Explorer
  --- @url https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    config = function() require('config.neotree') end,
    dependencies = 'MunifTanjim/nui.nvim',
  },

  -- Bufferline
  --- @url https://github.com/akinsho/bufferline.nvim
  {
    'akinsho/bufferline.nvim',
    enabled = true,
    event = 'VeryLazy',
    dependencies = 'moll/vim-bbye',
    opts = require('config.bufferline'),
  },

  -- {
  --   'tomiis4/BufferTabs.nvim',
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons', -- optional
  --   },
  --   lazy = false,
  --   config = function()
  --     require('buffertabs').setup({
  --       ---@type 'none'|'single'|'double'|'rounded'|'solid'|'shadow'|table
  --       border = 'none',

  --       ---@type boolean
  --       icons = true,

  --       ---@type string
  --       hl_group = 'Keyword',

  --       ---@type string
  --       hl_group_inactive = 'Comment',

  --       ---@type table<string>
  --       exclude = { 'NvimTree', 'help', 'dashboard', 'lir', 'alpha' },

  --       ---@type 'row'|'column'
  --       display = 'row',

  --       ---@type 'left'|'right'|'center'
  --       horizontal = 'center',

  --       ---@type 'top'|'bottom'|'center'
  --       vertical = 'bottom',
  --     })
  --   end,
  -- },

  -- Winbar
  --- @url https://github.com/utilyre/barbecue.nvim
  {
    'utilyre/barbecue.nvim',
    enabled = false,
    -- event = 'BufReadPre',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {
      exclude_filetypes = { 'toggleterm', 'yuck' },
      kinds = false,
      symbols = {
        separator = '|',
        kinds = icons.navic,
      },
    },
  },

  -- Terminal
  --- @url https://github.com/akinsho/toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    keys = { '<C-\\>' },
    opts = require('config.toggleterm'),
  },

  -- Distraction-free writing
  --- @url https://github.com/Pocco81/true-zen.nvim
  {
    'Pocco81/true-zen.nvim',
    opts = {
      modes = {
        minimalist = {
          options = {
            statuscolumn = '  ',
            cmdheight = 0,
          },
        },
      },
    },
    -- event = 'VeryLazy',
  },
}
