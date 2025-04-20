return {
  {
    'vidocqh/auto-indent.nvim',
    event = 'BufReadPre',
  },
  {
    'windwp/nvim-ts-autotag',
    event = {
      'InsertEnter',
    },
  },
  { 'saecki/live-rename.nvim' },
  {
    'kevinhwang91/nvim-fundo',
    dependencies = 'kevinhwang91/promise-async',
  },
  {
    'monaqa/dial.nvim',
    event = 'BufReadPre',
    keys = {
      { '<C-x>', '<Plug>(dial-decrement)', mode = 'n' },
    },
    config = function()
      local augend = require('dial.augend')
      local config = require('dial.config')
      config.augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          augend.constant.new({ elements = { 'let', 'const' } }),
          augend.constant.new({ elements = { 'yes', 'no' } }),
        },
      })
    end,
  },
  {
    'brenton-leighton/multiple-cursors.nvim',
    version = '*',
    opts = {},
    keys = {
      {
        '<M-C-j>',
        '<Cmd>MultipleCursorsAddDown<CR>',
        mode = { 'n', 'x' },
        desc = 'Add cursor and move down',
      },
      {
        '<M-C-n>',
        '<Cmd>MultipleCursorsAddJumpNextMatch<CR>',
        mode = { 'x' },
        desc = 'Add cursor and move down',
      },
    },
  },
  {
    'Vonr/align.nvim',
    keys = {
      { 'aa', function() require('align').align_to_char({ length = 1 }) end, desc = 'Align to character', mode = 'x' },
      { 'as', function() require('align').align_to_string({ preview = false, regex = true }) end, desc = 'Align to string with regex', mode = 'x' },
    },
  },
  {
    'MagicDuck/grug-far.nvim',
    event = 'BufReadPost',
    opts = {
      icons = {
        enabled = true,
        fileIconsProvider = 'first_available',
        actionEntryBullet = ' ',
        searchInput = '  ',
        replaceInput = '  ',
        filesFilterInput = '  ',
        flagsInput = '󰮚  ',
        pathsInput = '󰉖  ',
      },
    },
    keys = {
      {
        '<M-s>',
        function() require('grug-far').grug_far({ prefills = { search = vim.fn.expand('<cword>') } }) end,
        desc = 'Search and replace current word',
        mode = 'n',
      },
      {
        '<M-s>',
        function() require('grug-far').with_visual_selection() end,
        desc = 'Search and replace visual selection',
        mode = 'v',
      },
    },
  },
  {
    'Wansmer/treesj',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = { use_default_keymaps = false },
    keys = {
      {
        '<S-k>',
        function() require('treesj').toggle({ split = { recursive = true } }) end,
        desc = 'Join/split lines (Treesj)',
        mode = 'n',
      },
    },
  },
  {
    'kylechui/nvim-surround',
    event = 'BufReadPre',
    version = '*',
    opts = {
      move_cursor = true,
      keymaps = {
        visual = 's',
      },
    },
  },
}
