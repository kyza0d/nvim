return {
  {
    'EdenEast/nightfox.nvim',
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    },
    opts = {
      disable_frontmatter = true,
      callout = {
        thought = {
          raw = '[!Thoughts]',
          rendered = ' Thoughts',
          highlight = 'RenderMarkdownH1',
        },
        tasks = {
          raw = '[!Tasks]',
          rendered = ' Tasks',
          highlight = 'RenderMarkdownH2',
        },
        goals = {
          raw = '[!Goals]',
          rendered = ' Goals',
          highlight = 'RenderMarkdownH3',
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
    enabled = false,
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
          -- { text = { '%=', ' ', '%=' }, click = 'v:lua.ScSa' },
          { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
          { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
        },
      })
    end,
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
    '0xAdk/full_visual_line.nvim',
    enabled = true,
    keys = 'V',
    opts = {},
  },
}
