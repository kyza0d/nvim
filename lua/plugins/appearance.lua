local hl = ky.hl

---@diagnostic disable: missing-fields
return {
  {
    'echasnovski/mini.icons',
    config = function(_)
      require('mini.icons').setup(ky.ui.icons.mini)
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },
  {
    'svermeulen/text-to-colorscheme',
    lazy = false,
    opts = require('config.text-to-colorscheme'),
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = not vim.g.neovide,
    main = 'ibl',
    event = 'UIEnter',
    init = function()
      hl.plugin('IndentBlankLine', {
        theme = {
          ['*'] = {
            { IndentBlanklineChar = { fg = { from = 'Macro' } } },
            { IndentBlanklineSpaceChar = { fg = { from = 'Comment', alter = -0.4 } } },
          },
        },
      })
    end,
    opts = {
      exclude = {
        -- stylua: ignore
        filetypes = {
          'dbout', 'neo-tree-popup', 'log', 'gitcommit',
          'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
          'undotree', 'markdown', 'norg', 'org', 'orgagenda',
        },
      },
      indent = {
        char = '▏',
        highlight = 'IndentLine',
      },
      scope = {
        char = '▏',
      },
    },
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    init = function() vim.notify = require('notify') end,
    config = function()
      local notify = require('notify')
      notify.setup({
        top_down = false,
        render = 'minimal',
      })
    end,
  },
  {
    'kevinhwang91/nvim-bqf',
    opts = {
      preview = {
        border = 'none',
        winblend = 0,
      },
    },
    ft = 'qf',
  },
  {
    'Bekaboo/dropbar.nvim',
    opts = {
      sources = {
        path = {
          relative_to = function(_, win)
            local ok, win_cwd = pcall(vim.fn.getcwd, win)
            local cwd = ok and win_cwd or vim.fn.getcwd()
            local is_subdir_of_home = vim.fn.fnamemodify(cwd, ':~') ~= cwd

            return is_subdir_of_home and vim.env.HOME or '/'
          end,
        },
      },
      bar = {
        sources = function()
          local sources = require('dropbar.sources')
          local utils = require('dropbar.utils')
          return {
            utils.source.fallback({
              sources.lsp,
              sources.path,
            }),
          }
        end,
      },
    },
  },
  {
    '3rd/image.nvim',
    enabled = not vim.g.neovide,
    opts = {
      max_width = 65,
      max_height = 24,
    },
  },
  {
    -- 'NStefan002/screenkey.nvim',
    dir = '~/Clones/screenkey.nvim/',
    enabled = false,
    version = '*',

    config = function()
      require('screenkey').setup({
        win_opts = {
          row = vim.o.lines - vim.o.cmdheight - 1,
          col = vim.o.columns - 1,
          relative = 'editor',
          anchor = 'SE',
          width = 40,
          height = 1,
          border = 'none',
          title = '',
          title_pos = 'center',
          style = 'minimal',
          focusable = false,
          noautocmd = true,
        },
        highlights = {
          Float = { bg = 'NONE', fg = 'NONE' },
          ScreenKey = { bg = 'NONE', fg = { from = 'Comment' } },
        },
      })
    end,
    lazy = false,
  },
  {
    '0xAdk/full_visual_line.nvim',
    enabled = true,
    keys = 'V',
    opts = {},
  },
  {
    'tris203/precognition.nvim',
    enabled = false,
    opts = {
      hints = {
        Caret = { text = '^', prio = 2, highlight = 'Special' },
        Dollar = { text = '$', prio = 1 },
        MatchingPair = { text = '%', prio = 5 },
        Zero = { text = '0', prio = 1 },
        w = { text = 'w', prio = 10 },
        b = { text = 'b', prio = 9 },
        e = { text = 'e', prio = 8 },
        W = { text = 'W', prio = 7 },
        B = { text = 'B', prio = 6 },
        E = { text = 'E', prio = 5 },
      },
    },
  },
}
