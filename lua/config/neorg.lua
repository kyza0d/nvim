return {
  configure_parsers = true,
  load = {
    ['core.highlights'] = {},
    ['core.defaults'] = {},
    ['core.completion'] = { config = { engine = 'nvim-cmp' } },
    ['core.ui.calendar'] = {},
    ['core.itero'] = {},
    ['core.concealer'] = {
      config = {
        icon_preset = 'varied',
        icons = {
          delimiter = {
            horizontal_line = {
              highlight = '@neorg.delimiters.horizontal_line',
            },
          },
          code_block = {
            content_only = true,
            padding = {
              left = 2,
              right = 2,
            },
            conceal = true,
            nodes = { 'ranged_verbatim_tag' },
            highlight = 'CursorLine',
            insert_enabled = true,
          },
        },
      },
    },
  },
}
