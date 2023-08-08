-- local t2c_colors = require('text-to-colorscheme')
-- local t2c_utils = require('text-to-colorscheme.internal.color_util')
-- local t2c_hsv_palette = t2c_colors.get_palette()
-- local t2c_background = t2c_utils.hsv_to_hex(t2c_hsv_palette.background)
-- local t2c_foreground = t2c_utils.hsv_to_hex(t2c_hsv_palette.foreground)

return {
  options = {
    separator_style = { '', '' },

    right_mouse_command = 'Bdelete! %d',

    indicator = {
      style = 'icon',
      icon = '▎',
    },

    -- numbers = function(opts) return string.format('%s.', opts.ordinal) end,

    show_buffer_close_icons = false,
    show_buffer_icons = true,
    show_close_icon = true,

    enforce_regular_tabs = true,

    modified_icon = '*',
    buffer_close_icon = '',

    left_trunc_marker = '',
    right_trunc_marker = '',

    -- truncate_names = false,
    -- tab_size = 0,

    offsets = {
      {
        filetype = 'neo-tree',
        text_align = 'left',
        highlight = 'ProjectRoot',
        padding = 0,
        -- text = root(),
      },
    },
  },
  highlights = {
    buffer_selected = {
      fg = vim.g.color1,
      bg = vim.g.background,
      italic = false,
    },

    -- numbers = {
    --   fg = colors.fg_1,
    --   bg = colors.bg_0,
    -- },
    -- numbers_visible = {
    --   fg = colors.fg_1,
    --   bg = colors.bg_0,
    -- },
    numbers_selected = {
      fg = '#ffffff',
      -- bg = colors.bg_0,
      bold = true,
      italic = false,
    },
  },
}
