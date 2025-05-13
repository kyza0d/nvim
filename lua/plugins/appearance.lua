return {
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    opts = {
      follow = {
        enabled = true,
      },
      constrain_cursor = false,
      keys = {
        { '>', "<cmd>lua require('quicker').expand()<CR>", desc = 'Expand quickfix content' },
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = false,
    dependencies = {
      { 'echasnovski/mini.icons', opt = true },
    },
    opts = {
      callout = {
        goals = {
          raw = '[!Goals]',
          rendered = '  Goals',
          highlight = 'RenderMarkdownH3',
        },
        tasks = {
          raw = '[!Tasks]',
          rendered = '  Tasks',
          highlight = 'RenderMarkdownH2',
        },
        thought = {
          raw = '[!Thoughts]',
          rendered = '  Thoughts',
          highlight = 'RenderMarkdownH1',
        },
      },
      heading = {
        width = 'block',
        position = 'inline',
        border_virtual = true,
        border_prefix = true,
        icons = { '', '', '', '', '', '' },
      },
      checkbox = {
        unchecked = {
          icon = ' ',
        },
        checked = {
          icon = ' ',
        },
        custom = {
          ongoing = {
            raw = '[~]',
            rendered = '󰄉 ',
            highlight = 'Keyword',
            scope_highlight = nil,
          },
          canceled = {
            raw = '[-]',
            rendered = ' ',
            highlight = 'DiagnosticError',
            scope_highlight = nil,
          },
        },
      },
      bullet = {
        icons = {
          '•',
          '•',
          '•',
          '•',
        },
      },
    },
  },
  { 'folke/zen-mode.nvim', opts = {} },
  {
    'echasnovski/mini.icons',
    config = function(_)
      require('mini.icons').setup(icons.mini)
      require('mini.icons').mock_nvim_web_devicons()
    end,
  },
  { 'saecki/live-rename.nvim' },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
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
    init = function() vim.notify = require('notify') end,
    config = function()
      local stages_util = require('notify.stages.util')
      local direction = stages_util.DIRECTION.BOTTOM_UP

      require('notify').setup({
        top_down = true,
        render = 'minimal',
        on_open = function(win)
          vim.api.nvim_win_set_config(win, {
            border = 'none',
          })
        end,
        stages = {
          function(state)
            local next_height = state.message.height
            local next_row = stages_util.available_slot(state.open_windows, next_height, direction)

            if not next_row then return nil end
            if vim.tbl_isempty(state.open_windows) then next_row = next_row end

            return {
              relative = 'editor',
              anchor = 'NE',
              width = state.message.width,
              height = state.message.height,
              col = vim.opt.columns:get(),
              row = next_row,
              border = 'rounded',
              style = 'minimal',
            }
          end,
          function()
            return {
              col = vim.opt.columns:get(),
              time = true,
            }
          end,
        },
      })
    end,
  },
  {
    'Bekaboo/dropbar.nvim',
    opts = {
      icons = {
        enable = false,
        ui = {
          bar = {
            separator = '  ',
            extends = '…',
          },
        },
      },
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
    'luukvbaal/statuscol.nvim',
    config = function()
      local builtin = require('statuscol.builtin')
      require('statuscol').setup({
        relculright = true,
        ft_ignore = { 'neo-tree' },
        segments = {
          -- padding
          { text = { '%s' }, click = 'v:lua.ScSa' },
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
        },
      })
    end,
  },
  {
    '3rd/image.nvim',
    opts = {
      max_width = 20,
      max_height = 50,
    },
  },
  {
    '0xAdk/full_visual_line.nvim',
    enabled = true,
    keys = 'V',
    opts = {},
  },
  -- themes
  { 'EdenEast/nightfox.nvim' },
  {
    'svermeulen/text-to-colorscheme',
    opts = {
      ai = {
        openai_api_key = os.getenv('OPENAI_API_KEY'),
        gpt_model = 'gpt-4o',
        green_darkening_amount = 0.85,
        auto_darken_greens = true,
        minimum_foreground_contrast = 0.5,
        enable_minimum_foreground_contrast = true,
        temperature = 0.8,
      },

      disable_builtin_schemes = true,

      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },

      hex_palettes = {
        {
          name = '#0E0E0E Onedark',
          background_mode = 'dark',
          background = '#0e0e0e',
          foreground = '#abb2bf',
          accents = {
            '#e06c75',
            '#d19a66',
            '#e5c07b',
            '#81a667',
            '#56b6c2',
            '#61afef',
            '#c678dd',
          },
        },
        {
          name = 'Source Code 1982',
          background_mode = 'dark',
          background = '#0a0f14',
          foreground = '#a7aaa8',
          accents = {
            '#ffcc66',
            '#9aa158',
            '#81a2be',
            '#b294bb',
            '#de935f',
            '#a3685a',
            '#cc6666',
          },
        },
        {
          name = 'Ashes',
          background_mode = 'dark',
          background = '#1B1F22',
          foreground = '#c7ccd1',
          accents = {
            '#aec795',
            '#95c7ae',
            '#c7ae95',
            '#ae95c7',
            '#c795ae',
            '#f7b3b3',
            '#c3707a',
          },
        },
        {
          name = 'lush-green',
          background_mode = 'dark',
          background = '#0f1a0e',
          foreground = '#b8c5b4',
          accents = {
            '#419544',
            '#76a63f',
            '#aebb30',
            '#008074',
            '#00bcd4',
            '#3f51b5',
            '#9c27b0',
          },
        },
        {
          name = 'Baronesse Garden',
          background_mode = 'dark',
          background = '#1c1c1c',
          foreground = '#f7f7f7',
          accents = {
            '#f7a8b8',
            '#f7d8a8',
            '#f7f7a8',
            '#b8d28f',
            '#8fd29c',
            '#8fd2b8',
            '#a8f7f7',
          },
        },
        {
          name = 'Celestial Rose',
          background_mode = 'dark',
          background = '#181a23',
          foreground = '#cac2ed',
          accents = {
            '#fe99ff',
            '#ffd392',
            '#9cf6ff',
            '#ffb3cc',
            '#88eec5',
            '#ff9292',
            '#fffe91',
          },
        },

        {
          name = 'Moon Garden',
          background_mode = 'dark',
          background = '#0f0f1a',
          foreground = '#8686B3',
          accents = {
            '#a6cfd5',
            '#f7d4b5',
            '#b5d4f7',
            '#f7b5d4',
            '#b4d29a',
            '#d4b5f7',
            '#9ad2b4',
          },
        },
        {
          name = 'City Lights',
          background_mode = 'dark',
          background = '#1b1f27',
          foreground = '#abb2bf',
          accents = {
            '#61afef',
            '#81a667',
            '#e5c07b',
            '#c678dd',
            '#56b6c2',
            '#e06c75',
            '#be5046',
          },
        },
        {
          name = 'Lavender',
          background_mode = 'dark',
          background = '#151925',
          foreground = '#b5b5ed',
          accents = {
            '#d680e2',
            '#93c6b6',
            '#9070d1',
            '#4b9fed',
            '#3cbde8',
            '#32d3a6',
            '#a48fbf',
          },
        },
        {
          name = 'Morning Dew dark',
          background_mode = 'dark',
          background = '#1c1f26',
          foreground = '#c7d5e0',
          accents = {
            '#8cc4c4',
            '#9cb89c',
            '#f0e68c',
            '#b0c4de',
            '#d8bfd8',
            '#f5deb3',
            '#ffb6c1',
          },
        },
        {
          name = 'Night Fall',
          background_mode = 'dark',
          background = '#0d0f12',
          foreground = '#a7aaa8',
          accents = {
            '#56b6c2',
            '#c678dd',
            '#81a667',
            '#e5c07b',
            '#d19a66',
            '#61afef',
            '#e06c75',
          },
        },
      },

      -- default_palette = 'lush-green',
      default_palette = 'Night Fall',
    },
  },
}
