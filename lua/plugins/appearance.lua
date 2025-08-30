return {
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    dir = '~/Projects/Plugins/xeno.nvim',
    branch = 'master',
    -- lazy = false,
    -- 'kyza0d/xeno.nvim',

    opts = {
      contrast = 0.1,
      variation = -0.9,

      decorations = {
        borders = false,
      },

      highlights = {
        editor = {
          Normal = { bg = '@base.900' },
        },
        syntax = {
          Comment = { fg = '@base.600' },
        },
      },
    },

    config = function(_, opts)
      local xeno = require('xeno')

      xeno.config(opts)

      xeno.theme('xeno-glow', {
        base = '#111111',
        accent = '#00F3CA',
      })

      xeno.theme('xeno-latte', {
        base = '#0f0d0c',
        accent = '#bf8f7f',
      })

      xeno.theme('xeno-ghost', {
        base = '#151c19',
        accent = '#30c993',
      })

      xeno.theme('xeno-clover', {
        base = '#0c0f0c',
        accent = '#a3e2ad',
      })

      xeno.theme('xeno-lily-pad', {
        base = '#1E1E1E',
        accent = '#8CBE8C',
      })

      xeno.theme('xeno-golden-hour', {
        base = '#11100f',
        accent = '#FFCC33',
      })

      xeno.theme('xeno-pink-haze', {
        base = '#0f0c0e',
        accent = '#D19EBC',
      })

      xeno.theme('xeno-ocean', {
        base = '#262635',
        accent = '#5859a0',
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    main = 'ibl',
    event = 'UIEnter',
    opts = {
      exclude = {
        -- stylua: ignore
        filetypes = {
          'dbout', 'neo-tree-popup', 'log', 'gitcommit',
          'txt', 'help', 'NvimTree', 'git', 'flutterToolsOutline',
          'undotree', 'markdown', 'norg', 'org', 'orgagenda',
        },
      },
      indent = { char = '▏' },
      scope = { char = '▏' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'rcarriga/nvim-notify',
    enabled = false,
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
    '0xAdk/full_visual_line.nvim',
    keys = 'V',
    opts = {},
  },
  {
    '3rd/image.nvim',
    build = true,
    enabled = false,
    opts = {
      processor = 'magick_rock',
      max_width = 50,
      max_height = 50,
    },
  },
}
