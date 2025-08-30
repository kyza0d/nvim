local root = vim.fn.getcwd()

local workspace = root:sub(root:find('[^/]*$'))
local bufferline_groups = require('bufferline.groups')
local groups = require('bufferline.groups')
local bufferline = require('bufferline')

bufferline.setup({
  options = {
    close_command = 'Bdelete! %d',
    tab_size = 0,
    enforce_regular_tabs = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_buffer_icons = false,
    themable = true,
    style_preset = bufferline.style_preset.default,
    left_trunc_marker = '',
    right_trunc_marker = '',
    groups = {
      options = {
        toggle_hidden_on_enter = false,
      },
      items = {
        bufferline_groups.builtin.pinned:with({ icon = ' ' }),
        groups.builtin.ungrouped,
        {
          name = 'notes',
          separator = {
            style = require('bufferline.groups').separator.tab,
          },
          matcher = function(buf)
            for _, ext in ipairs({ 'md', 'txt', 'org', 'norg', 'wiki' }) do
              if ext == vim.fn.fnamemodify(buf.path, ':e') then return true end
            end
          end,
        },
      },
    },

    right_mouse_command = 'Bdelete! %d',
    left_mouse_command = 'buffer %d',
    indicator = {
      style = 'none',
    },
    separator_style = { '', '' },
    modified_icon = '',
    offsets = {
      {
        filetype = 'codecompanion',
        text = fmt('  Chat: %s', ai.models.chat),
        text_align = 'left',
        hl = 'TabLine',
      },
      {
        filetype = 'neo-tree',
        text_align = 'left',
        text = string.format('  %s', workspace),
        padding = 1,
      },
    },
  },
  highlights = {
    fill = {
      bg = { highlight = '@base.bg.950', attribute = 'bg' },
    },
    background = {
      fg = { highlight = '@base.fg.500', attribute = 'fg' },
      sp = { highlight = '@base.fg.700', attribute = 'sp' },
      underline = true,
    },
    duplicate_visible = {
      sp = { highlight = '@base.fg.700', attribute = 'sp' },
      underline = true,
    },
    modified = {
      fg = { highlight = '@base.fg.500', attribute = 'fg' },
      sp = { highlight = '@base.fg.700', attribute = 'sp' },
      underline = true,
    },
    duplicate = {
      sp = { highlight = 'BufferlineFill', attribute = 'sp' },
      underline = true,
    },
  },
})
