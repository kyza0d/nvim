return {
  {
    'chrisgrieser/nvim-spider',
    opts = {},
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
    },
  },
  {
    'folke/flash.nvim',
    opts = {
      modes = { char = { highlight = { backdrop = false } } },
      prompt = { enabled = false },
      highlight = {
        backdrop = false,
        matches = false,
        groups = {
          match = 'Search',
          current = 'CurSearch',
          backdrop = 'Search',
          label = 'Search',
        },
      },
    },
  },
  {
    'kevinhwang91/nvim-fundo',
    dependencies = 'kevinhwang91/promise-async',
    enabled = false,
  },
  {
    'echasnovski/mini.bracketed',
    version = false,
  },
  {
    'gbprod/substitute.nvim',
    keys = {
      { '<C-s>', function() require('substitute').operator() end, desc = 'Substitute', mode = 'n' },
      { '<C-s>', function() require('substitute').visual() end, desc = 'Substitute', mode = 'v' },
      { '<C-x>', function() require('substitute.exchange').visual() end, desc = 'Substitute', mode = 'v' },
    },
    event = {
      'CmdlineEnter',
      'TextYankPost',
      'CursorHold',
    },
    opts = {},
  },
  {
    'gbprod/yanky.nvim',
    init = function()
      keymap({ 'n', 'v' }, '<C-v>', '"+p') -- Paste
      keymap('i', '<C-v>', '<C-r>+') -- Paste (insert mode)
      keymap('x', '<C-c>', '"+y') -- Yank
    end,
    keys = {
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' } },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
      { 'gp', '<Plug>(YankyPutAfterFilter)' },
      { 'gP', '<Plug>(YankyPutBeforeFilter)' },
    },
    dependencies = {
      'kkharji/sqlite.lua',
    },
    opts = {
      ring = { storage = 'sqlite' },
      highlight = {
        on_put = false,
        on_yank = true,
        timer = 50,
      },
    },
  },
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
      { 'g[', mode = { 'n', 'x', 'o' } },
      { 'g]', mode = { 'n', 'x', 'o' } },
    },
    opts = function()
      local ai = require('mini.ai')
      return {
        mappings = {
          around_last = 'aN',
          inside_last = 'iN',
        },
        n_lines = 250,
        custom_textobjects = {
          l = { '^()%s*().*()%s*()\n$' },
          e = function()
            return {
              from = { line = 1, col = 1 },
              to = {
                line = vim.fn.line('$'),
                col = math.max(vim.fn.getline('$'):len(), 1),
              },
            }
          end,
          F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
        },
      }
    end,
  },
  {
    'echasnovski/mini.move',
    event = 'BufReadPre',
    init = function()
      keymap('x', '<C-S-h>', function() require('mini.move').move_selection('left') end)
      keymap('x', '<C-S-l>', function() require('mini.move').move_selection('right') end)
      keymap('x', '<C-S-j>', function() require('mini.move').move_selection('down') end)
      keymap('x', '<C-S-k>', function() require('mini.move').move_selection('up') end)
    end,
  },
  {
    'kylechui/nvim-surround',
    event = 'BufReadPre',
    opts = {
      move_cursor = true,
      keymaps = { normal = 's', visual = 's' },
    },
    version = '*',
  },
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
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function() vim.g.netrw_nogx = 1 end,
    config = true,
  },
  {
    'Wansmer/treesj',
    keys = {
      {
        '<S-k>',
        function() require('treesj').toggle({ split = { recursive = true } }) end,
        desc = 'Join/split lines (Treesj)',
        mode = 'n',
      },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}
