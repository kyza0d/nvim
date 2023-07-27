return {
  --------------------------------------------
  -- Editor Tools
  --------------------------------------------

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
    event = 'BufReadPre',
    dependencies = 'moll/vim-bbye',
    opts = require('config.bufferline'),
  },

  -- Winbar
  --- @url https://github.com/utilyre/barbecue.nvim
  {
    'utilyre/barbecue.nvim',
    enabled = false,
    event = 'BufReadPre',
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

  -- Details Window
  --- @url https://github.com/folke/trouble.nvim
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
  },

  -- Highlighted TODO comments
  --- @url https://github.com/folke/todo-comments.nvim
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    opts = {
      keywords = {
        ROADMAP = { icon = ' ', color = 'warning' },
      },
    },
  },

  --------------------------------------------
  -- Utilites
  --------------------------------------------

  -- Discord Rich Presence
  --- @url https://github.com/andweeb/presence.nvim
  {
    'andweeb/presence.nvim',
    event = 'BufReadPre',
    enabled = true,
    opts = {
      auto_update = true,
    },
  },

  -- Extra tree-sitter information
  --- @url https://github.com/nvim-treesitter/playground
  {
    'nvim-treesitter/playground',
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
  },

  -- Measure startup time
  --- @url https://github.com/dstein64/vim-startuptime
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },

  -- Preview markdown files
  --- @url https://github.com/iamcco/markdown-preview.nvim
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
    cmd = 'MarkdownPreview',
  },
}
