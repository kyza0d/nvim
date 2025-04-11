---@diagnostic disable: missing-fields
local reqcall = ky.reqcall

return {
  {
    'epwalsh/obsidian.nvim',
    init = function()
      local wk = reqcall('which-key')

      wk.add({
        { icon = ' ', group = 'Notes', '<cr>n' },
        { icon = ' ', desc = 'Open Daily', '<cr>nd', '<cmd>ObsidianToday<cr>' },
        { icon = '󱞳 ', desc = 'Open Daily (Yesterday)', '<cr>ny', '<cmd>ObsidianYesterday<cr>' },
        { icon = '󱞫 ', desc = 'Open Daily (Tomorrow)', '<cr>nt', '<cmd>ObsidianTomorrow<cr>' },
        { icon = ' ', group = 'Log', '<cr>l' },
        { icon = ' ', desc = 'Idea', '<cr>li', '<cmd>e ~/Notes/2025/Journal/Logs/Ideas.md<cr>' },
        { icon = ' ', desc = 'Dream', '<cr>ld', '<cmd>e ~/Notes/2025/Journal/Logs/Dreams.md<cr>' },
        { icon = '󰟶 ', desc = 'Thought', '<cr>lt', '<cmd>e ~/Notes/2025/Journal/Logs/Thoughts.md<cr>' },
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
}
