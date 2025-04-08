---@diagnostic disable: missing-fields
return {
  {
    'epwalsh/obsidian.nvim',
    tag = '*',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('obsidian').setup({
        ui = {
          enable = false,
          checkboxes = {
            [' '] = {},
            ['x'] = {},
            ['~'] = {},
            ['?'] = {},
            ['t'] = {},
          },
        },
        daily_notes = {
          folder = '/Dailies/',
          date_format = '%Y-%m-%d',
          alias_format = '%B %-d, %Y',
          default_tags = {},
          template = nil,
        },

        mappings = {
          ['<C-t>'] = {
            action = function() return require('obsidian').util.toggle_checkbox() end,
            opts = { buffer = true },
          },

          ['<c-s>'] = {
            action = function() return require('obsidian').util.smart_action() end,
            opts = { buffer = true, expr = true },
          },
        },
        workspaces = {
          {
            name = 'Notes',
            path = '~/Notes',
          },
        },
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    opts = {
      callout = {
        thought = {
          raw = '[!BRAIN]',
          rendered = ' Thoughts',
          highlight = 'Macro',
        },
      },
      checkbox = {
        unchecked = { icon = ' ' },
        checked = { icon = ' ' },
        custom = {
          pending = { raw = '[?]', rendered = ' ', highlight = 'Macro', scope_highlight = nil },
          active = { raw = '[~]', rendered = '⚡', highlight = 'Keyword', scope_highlight = nil },
          canceled = { raw = '[t]', rendered = '', highlight = 'Error', scope_highlight = nil },
        },
      },
    },
  },
  {
    '3rd/image.nvim',
    enabled = not vim.g.neovide,
    opts = {
      max_width = 46,
      max_height = 18,
    },
  },
}
