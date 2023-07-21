local root = function()
  local root = vim.fn.getcwd()
  local workspace = ' ' .. root:sub(root:find('[^/]*$'))
  return workspace
end

local icons = require('options').editor

return {
  options = {
    separator_style = { '', '' },

    right_mouse_command = 'Bdelete! %d',

    indicator = {
      style = 'none',
    },

    show_buffer_close_icons = false,
    show_buffer_icons = false,
    show_close_icon = false,

    enforce_regular_tabs = true,

    modified_icon = '*',
    buffer_close_icon = '',

    left_trunc_marker = '',
    right_trunc_marker = '',

    truncate_names = false,
    tab_size = 25,

    offsets = {
      {
        filetype = 'neo-tree',
        text_align = 'left',
        highlight = 'ProjectRoot',
        padding = 0,
        text = root(),
      },
    },
  },
}
