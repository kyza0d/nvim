-- local t2c_colors = require('text-to-colorscheme')
-- local t2c_utils = require('text-to-colorscheme.internal.color_util')
-- local t2c_hsv_palette = t2c_colors.get_palette()
-- local t2c_background = t2c_utils.hsv_to_hex(t2c_hsv_palette.background)
-- local t2c_foreground = t2c_utils.hsv_to_hex(t2c_hsv_palette.foreground)

return {
  options = {
    -- custom_areas = {
    --   left = function()
    --     return {
    --       {
    --         text = '%#Normal# ',
    --       },
    --     }
    --   end,
    -- },

    -- separator_style = { '▏ ▕', '▏ ▕' },
    separator_style = { '', '' },

    right_mouse_command = 'Bdelete! %d',

    indicator = {
      icon = ' ', -- this should be omitted if indicator style is not 'icon'
      style = 'icon',
    },

    -- numbers = function(opts) return string.format('%s', opts.ordinal) end,

    show_buffer_close_icons = false,
    show_buffer_icons = false,
    show_close_icon = true,

    enforce_regular_tabs = false,

    modified_icon = '+',
    buffer_close_icon = 'x',

    left_trunc_marker = '',
    right_trunc_marker = '',

    truncate_names = false,
    tab_size = 17,

    offsets = {
      {
        filetype = 'neo-tree',
        text_align = 'left',
        highlight = 'ProjectRoot',
        padding = 0,
      },
    },
  },
}
