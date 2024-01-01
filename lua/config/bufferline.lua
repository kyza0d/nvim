local root = vim.fn.getcwd()
local workspace = root:sub(root:find('[^/]*$'))

return {
  options = {
    close_icon = 'x',
    close_command = 'Bdelete! %d',
    show_buffer_close_icons = false,
    groups = {
      items = {
        require('bufferline.groups').builtin.pinned:with({ icon = ' ' }),
      },
    },

    get_element_icon = function(element)
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,

    show_buffer_icons = false,
    show_close_icon = false,
    right_mouse_command = 'Bdelete! %d',
    left_mouse_command = 'buffer %d',
    indicator = { style = 'underline' },
    modified_icon = '●',
    separator_style = { ' ', ' ' },
    tab_size = 0,
    offsets = {
      {
        filetype = 'neo-tree',
        text_align = 'left',
        highlight = 'ProjectRoot',
        text = string.format('  %s', workspace),
        padding = 0,
      },
    },
  },
}
