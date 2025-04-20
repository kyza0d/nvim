---@diagnostic disable: missing-fields
local reqcall = ky.reqcall

return {
  {
    'obsidian-nvim/obsidian.nvim',
    init = function()
      reqcall('which-key').add({
        { icon = ' ', group = 'Notes', '<cr>n' },
        { icon = ' ', desc = 'Open Focus', '<cr>nf', '<cmd>e ~/Notes/Focus.md<cr>' },
        { icon = ' ', desc = 'Open Daily', '<cr>nd', '<cmd>ObsidianToday<cr>' },
        { icon = '󰺯 ', desc = 'Search', '<cr>ns', '<Cmd>ObsidianSearch<CR>' },
        { icon = '󱞳 ', desc = 'Open Daily (Yesterday)', '<cr>n,', '<cmd>ObsidianYesterday<cr>' },
        { icon = '󱞫 ', desc = 'Open Daily (Tomorrow)', '<cr>n.', '<cmd>ObsidianTomorrow<cr>' },
        { icon = ' ', group = 'Log', '<cr>l' },
        { icon = ' ', desc = 'Idea', '<cr>li', '<cmd>e ~/Notes/2025/Logs/Ideas.md<cr>' },
        { icon = ' ', desc = 'Dream', '<cr>ld', '<cmd>e ~/Notes/2025/Logs/Dreams.md<cr>' },
        { icon = '󰟶 ', desc = 'Thought', '<cr>lt', '<cmd>e ~/Notes/2025/Logs/Thoughts.md<cr>' },
        { icon = '󰯃 ', desc = 'Quote', '<cr>lq', '<cmd>e ~/Notes/2025/Logs/Quotes.md<cr>' },
      })
    end,
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

        picker = {
          name = 'fzf-lua',
        },

        mappings = {
          ['<C-t>'] = {
            action = function() return require('obsidian').util.toggle_checkbox() end,
            opts = { buffer = true },
          },

          ['<S-f>'] = {
            action = function() return require('obsidian').util.gf_passthrough() end,
            opts = { noremap = false, expr = true, buffer = true },
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    },
    opts = {
      callout = {
        thought = {
          raw = '[!BRAIN]',
          rendered = ' Thoughts',
          highlight = 'Macro',
        },
      },
      heading = {
        width = 'block',
        position = 'inline',
        border_virtual = true,
        border_prefix = true,
        icons = { '', '', '', '', '', '' },
      },
      bullet = {
        icons = { '•', '•', '•', '•' },
      },
      checkbox = {
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰡖 ' },
        custom = {
          pending = { raw = '[?]', rendered = ' ', highlight = 'Macro', scope_highlight = nil },
          active = { raw = '[~]', rendered = '⚡', highlight = 'Keyword', scope_highlight = nil },
          canceled = { raw = '[t]', rendered = '', highlight = 'Error', scope_highlight = nil },
        },
      },
    },
  },
}
