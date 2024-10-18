return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },
  -- { "OXY2DEV/markview.nvim", opts =  }
  {
    'vhyrro/neorg',
    ft = 'norg',
    version = '*',
    dependencies = { 'luarocks.nvim' },
    run = ':Neorg sync-parsers',
    opts = {
      load = {
        ['core.integrations.treesitter'] = {
          config = {
            configure_parsers = true,
            install_parsers = true,
          },
        },
        ['core.keybinds'] = {
          default_keybinds = false,
        },
        ['core.ui.calendar'] = {},
        ['core.qol.toc'] = {},
        ['core.qol.todo_items'] = {},
        ['core.concealer'] = {
          config = {
            markup_preset = 'conceal',
            icons = {
              heading = {
                -- icons = { '󰎥 ', '󰎨 ', '󰎫 ', '󰎲 ', '󰎯 ', '󰎴 ' },
                icons = { '', '', '', '', '', '' },
              },
              todo = {
                done = { icon = '✓' },
                pending = { icon = '🞊' },
                undone = { icon = '🞨' },
              },
            },
            dim_code_blocks = {
              width = 'content',
              padding = {
                left = 10,
                right = 10,
              },
            },
          },
        },
        ['core.highlights'] = {
          config = {
            highlights = {
              todo_items = {
                urgent = '+@repeat',
                recurring = '+@attribute',
              },
            },
          },
        },
      },
    },
  },
}
