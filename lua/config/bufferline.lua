local root = vim.fn.getcwd()

local workspace = root:sub(root:find('[^/]*$'))
local bufferline_groups = require('bufferline.groups')
local groups = require('bufferline.groups')

local bufferline = require('bufferline')

bufferline.setup({
  options = {
    close_icon = 'x',
    close_command = 'Bdelete! %d',
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_buffer_icons = false,
    style_preset = bufferline.style_preset.default,
    left_trunc_marker = '',
    right_trunc_marker = '',
    tab_size = 0,
    enforce_regular_tabs = false,
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
      style = vim.g.neovide and 'none' or 'underline',
    },
    separator_style = { '', '' },
    modified_icon = '',
    offsets = {
      {
        filetype = 'neo-tree',
        text_align = 'left',
        hl = 'ProjectRoot',
        text = string.format('  %s', workspace),
        padding = 1,
      },
    },
  },

  highlights = function()
    local normal_bg = hl.get('Normal', 'bg')
    local normal_fg = hl.get('Normal', 'fg')

    local tab_bg = hl.tint(normal_bg, 0.45)
    local tab_bg_inactive = hl.tint(normal_bg, -0.1)
    local fill = hl.tint(normal_bg, -0.3)

    local tab_fg = hl.tint(normal_fg, 0.1)
    local tab_fg_inactive = hl.tint(normal_fg, -0.35)

    return {
      -- Buffers
      background = { bg = tab_bg_inactive },
      buffer_visible = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = palette.blue },
      buffer_selected = { fg = tab_fg, bg = tab_bg, sp = palette.blue, italic = false },
      hint = { fg = tab_fg },

      -- Tabs
      tab = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = palette.blue },
      tab_selected = { fg = tab_fg, bg = tab_bg, bold = true, italic = false, sp = palette.blue },
      tab_separator = { fg = tab_fg, bg = tab_bg_inactive, sp = palette.blue },
      tab_separator_selected = { fg = tab_fg, bg = tab_bg, sp = palette.blue },
      tab_close = { fg = tab_fg, bg = tab_bg_inactive, sp = palette.blue },
      indicator_selected = { fg = palette.blue, bg = tab_bg, sp = palette.blue },
      indicator_visible = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = palette.blue },

      -- Buffer pick
      pick_selected = { fg = palette.blue, bg = tab_bg, sp = palette.blue, italic = true, bold = false },
      pick_visible = { fg = palette.blue, bg = tab_bg_inactive, sp = palette.blue, italic = true, bold = false },
      pick = { fg = palette.blue, bg = tab_bg_inactive, sp = palette.blue, italic = true, bold = false },

      -- Modified
      modified = { fg = palette.magenta, bg = tab_bg_inactive },
      modified_selected = { fg = tab_fg, bg = tab_bg, sp = palette.blue },

      -- Duplicate
      duplicate_selected = { fg = tab_fg, bg = tab_bg, sp = palette.blue },
      duplicate_visible = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = palette.blue },
      duplicate = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = palette.blue },

      -- Separators
      separator = { fg = tab_fg, bg = tab_bg_inactive },
      separator_visible = { fg = tab_fg, bg = tab_bg_inactive },
      separator_selected = { fg = tab_fg, bg = tab_bg },
      offset_separator = { fg = tab_fg, bg = tab_bg },

      -- Close buttons
      close_button = { fg = tab_fg_inactive, bg = tab_bg_inactive },
      close_button_visible = { fg = tab_fg_inactive, bg = tab_bg_inactive },
      close_button_selected = { fg = tab_fg, bg = tab_bg },

      numbers = {
        fg = tab_fg_inactive,
        bg = tab_bg_inactive,
      },

      numbers_visible = {
        fg = tab_bg_inactive,
        bg = tab_bg_inactive,
      },

      numbers_selected = {
        fg = tab_fg,
        bg = tab_bg,
        underline = false,
        sp = palette.blue,
      },

      fill = { bg = fill },
    }
  end,
})
