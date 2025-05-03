return {
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown',
  },
  {
    'obsidian-nvim/obsidian.nvim',
    init = function()
      reqcall('which-key').add({
        { icon = ' ', group = 'Notes', '<cr>n' },
        { icon = ' ', desc = 'Focus.md', '<cr><cr>', '<cmd>e ~/Notes/Focus.md<cr>' },
        { icon = ' ', desc = 'Open Daily', '<cr>nd', '<cmd>ObsidianToday<cr>' },
        { icon = ' ', desc = 'Search', '<cr>ng', '<Cmd>ObsidianSearch<CR>' },
        { icon = ' ', desc = 'Find', '<cr>nf', '<Cmd>ObsidianQuickSwitch<CR>' },
        { icon = '󱞳 ', desc = 'Open Daily (Yesterday)', '<cr>n,', '<cmd>ObsidianYesterday<cr>' },
        { icon = '󱞫 ', desc = 'Open Daily (Tomorrow)', '<cr>n.', '<cmd>ObsidianTomorrow<cr>' },
        { icon = ' ', group = 'Log', '<cr>l' },
        { icon = ' ', desc = 'Idea', '<cr>li', '<cmd>e ~/Notes/2025/Logs/Ideas.md<cr>' },
        { icon = ' ', desc = 'Dream', '<cr>ld', '<cmd>e ~/Notes/2025/Logs/Dreams.md<cr>' },
        { icon = '󰟶 ', desc = 'Thought', '<cr>lt', '<cmd>e ~/Notes/2025/Logs/Thoughts.md<cr>' },
        { icon = '󰯃 ', desc = 'Quote', '<cr>lq', '<cmd>e ~/Notes/2025/Logs/Quotes.md<cr>' },
        { icon = ' ', desc = 'Entry', '<cr>le', function() helpers.create_journal_entry('Entries/') end },
        { icon = ' ', desc = 'Reflection', '<cr>lr', function() helpers.create_journal_entry('Reflections/') end },
      })
    end,
    tag = '*',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('obsidian').setup({
        workspaces = {
          {
            name = 'Notes',
            path = '~/Notes',
            overrides = {
              disable_frontmatter = true,
            },
          },
        },

        templates = {
          folder = '~/Notes/Templates/',
          date_format = '%d-%m-%Y',
          time_format = '%HH:%M',
        },

        ui = {
          enable = false,
          checkboxes = {
            [' '] = {},
            ['x'] = {},
            ['~'] = {},
            ['-'] = {},
          },
        },

        daily_notes = {
          folder = '/Dailies/',
          date_format = '%Y-%m-%d',
          alias_format = '%B %-d, %Y',
          default_tags = {},
          template = 'daily.md',
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
      })
    end,
  },
  {
    dir = '~/Projects/Plugins/vocal.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      recording_dir = os.getenv('HOME') .. '/recordings',
      local_model = {
        model = 'tiny',
        path = os.getenv('HOME') .. '/Models',
      },
    },
  },
}
