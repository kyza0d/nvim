return {

  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },
  {
    'tadmccorkle/markdown.nvim',
    enabled = true,
    opts = {
      mappings = {
        link_follow = '<Nop>',
      },
    },
    ft = 'markdown',
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    priority = 49,
  },
  {
    'roodolv/markdown-toggle.nvim',
    opts = {
      use_default_keymaps = false,
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = false,
    ft = { 'markdown', 'codecompanion' },
    opts = {
      render_modes = { 'n', 'c', 't' },
      code = {
        language_icon = true,
        language_name = true,
        language_pad = 1,
        left_pad = 1,
        style = 'langauge',
        inline = 'langauge',
        inline_pad = 1,
        border = 'hide',
      },
      completions = {
        blink = {
          enabled = true,
        },
      },
      heading = {
        width = 'full',
        position = 'inline',
        border_virtual = true,
        border_prefix = true,
        icons = { '', '', '', '', '', '' },
      },
      callout = {
        goals = {
          raw = '[!Goals]',
          rendered = '  Goals',
          highlight = 'MiniIconsAzure',
        },
        tasks = {
          raw = '[!Tasks]',
          rendered = '  Tasks',
          highlight = 'MiniIconsGreen',
        },
      },
      link = {
        hyperlink = '',
      },
      checkbox = {
        unchecked = { icon = ' ' },
        checked = { icon = ' ' },
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
      bullet = { icons = { '•', '•', '•', '•' } },
    },
  },
  {
    'obsidian-nvim/obsidian.nvim',
    config = function()
      require('obsidian').setup({
        legacy_commands = false,
        workspaces = {
          {
            name = 'Notes',
            path = '~/Notes',
            overrides = {
              disable_frontmatter = true,
            },
          },
        },

        ui = {
          enable = false,
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
      })
    end,
  },
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },

  {
    dir = '~/Projects/Plugins/vocal.nvim',
    opts = {
      -- debug = true,
      -- recording_dir = join(os.getenv('HOME'), '/Recordings'),
      keymap = '<leader>ev',
      local_model = {
        model = 'tiny',
        path = os.getenv('HOME') .. '/Models',
      },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && pnpm install',
  },
}
