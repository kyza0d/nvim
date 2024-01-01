--------------------------------------------
-- Editor's appearence
--------------------------------------------

local icons = require('icons')

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    event = 'BufReadPost',
    main = 'ibl',
    config = function() vim.cmd([[highlight IndentBlanklineChar guifg=#2a2e36 gui=nocombine]]) end,
    opts = {
      scope = { char = '▏', highlight = { 'IndentBlanklineContextSpaceChar' } },
      indent = { char = '▏', highlight = { 'IndentBlanklineChar' } },
    },
  },
  {
    'glepnir/dashboard-nvim',
    enabled = true,
    event = 'VimEnter',
    config = function() require('config.dashboard') end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    init = function() require('config.devicons') end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufRead',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        mode = 'background',
        names = false,
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    enabled = true,
    event = 'BufReadPost',
    opts = {
      keywords = {
        -- TODO: Add more keywords
        TODO = { icon = string.format(' %s', icons.todo_comments.todo), color = 'info', alt = { 'WIP', 'TEMP' } },
        WARN = {
          icon = string.format(' %s', icons.todo_comments.warning),
          color = 'warning',
          alt = { 'WARNING', 'XXX' },
        },
        FIX = { icon = string.format(' %s', icons.todo_comments.fixme), color = 'error', alt = { 'BUG', 'ERROR' } },
      },
    },
  },
  {
    'MunifTanjim/nui.nvim',
    event = 'BufWinEnter',
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    branch = 'v3.x',
    config = function() require('config.neotree') end,
    dependencies = {
      'mrbjarksen/neo-tree-diagnostics.nvim',
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim',
    },
  },
  {
    'akinsho/bufferline.nvim',
    enabled = true,
    event = 'BufWinEnter',
    dependencies = 'moll/vim-bbye',
    config = function()
      local opts = require('config.bufferline')
      require('bufferline').setup(opts)
    end,
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    init = function() vim.notify = require('notify') end,
    opts = require('config.notify'),
  },
  { 'folke/tokyonight.nvim', version = '*' },
  { 'akinsho/horizon.nvim', version = '*' },
  { 'projekt0n/caret.nvim' },
  { dir = '~/Plugins/ashes.nvim', version = '*' },
  { 'NTBBloodbath/sweetie.nvim' },
}
