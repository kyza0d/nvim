return {
  {
    'kevinhwang91/nvim-fundo',
    dependencies = 'kevinhwang91/promise-async',
    event = 'BufReadPre',
    run = function() require('fundo').install() end,
    opts = {},
  },
  {
    'echasnovski/mini.ai',
    event = 'BufReadPost',
    opts = {},
  },
  { 'MagicDuck/grug-far.nvim', event = 'UIEnter' },
  opts = {
    icons = {
      -- whether to show icons
      enabled = true,

      -- provider to use for file icons
      -- acceptable values: 'first_available', 'nvim-web-devicons', 'mini.icons', false (to disable)
      fileIconsProvider = 'first_available',

      actionEntryBullet = ' ',

      searchInput = '  ',
      replaceInput = '  ',
      filesFilterInput = '  ',
      flagsInput = '󰮚  ',
      pathsInput = '󰉖  ',
    },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    opts = { move_cursor = true, keymaps = { visual = 's' } },
    event = 'BufReadPre',
  },
  { 'Vonr/align.nvim', branch = 'v2' },
  {
    'monaqa/dial.nvim',
    event = 'BufReadPre',
    keys = {
      { '<C-a>', '<Plug>(dial-increment)', mode = 'n' },
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
}
