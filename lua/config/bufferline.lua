---@diagnostic disable: missing-fields
local root = vim.fn.getcwd()

local workspace = root:sub(root:find('[^/]*$'))
local bufferline_groups = require('bufferline.groups')
local groups = require('bufferline.groups')

local P, highlight = ky.ui.palette, ky.hl

local bufferline = require('bufferline')

bufferline.setup({
  options = {
    close_icon = 'x',
    close_command = 'Bdelete! %d',
    show_buffer_close_icons = false,
    show_close_icon = false,
    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
    show_buffer_icons = false,
    left_trunc_marker = '',
    right_trunc_marker = '',
    tab_size = 0,
    get_element_icon = function(element)
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
    groups = {
      options = {
        toggle_hidden_on_enter = false,
      },
      items = {
        bufferline_groups.builtin.pinned:with({ icon = ' ' }),
        groups.builtin.ungrouped,
        {
          name = 'docs',
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
    indicator = { style = 'underline' },
    modified_icon = '',
    separator_style = { ' ', ' ' },
    offsets = {
      {
        filetype = 'trouble',
        text = 'Trouble',
        text_align = 'left',
        highlight = 'ProjectRoot',
        padding = 1,
      },
      {
        filetype = 'neo-tree',
        text_align = 'left',
        highlight = 'ProjectRoot',
        text = string.format('  %s', workspace),
        padding = 1,
      },
    },
  },

  highlights = function()
    local normal_bg = highlight.get('Normal', 'bg')
    local normal_fg = highlight.get('Normal', 'fg')

    local tab_bg = highlight.tint(normal_bg, 0.45)
    local tab_bg_inactive = highlight.tint(normal_bg, -0.1)
    local fill = highlight.tint(normal_bg, is_light and -0.25 or -0.1)

    local tab_fg = highlight.tint(normal_fg, 0.1)
    local tab_fg_inactive = highlight.tint(normal_fg, -0.35)

    return {
      -- BUFFERS
      background = { bg = tab_bg_inactive },
      buffer_visible = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = P.blue },
      buffer_selected = { fg = tab_fg, bg = tab_bg, sp = P.blue, italic = false },
      hint = { fg = tab_fg },

      -- TABS
      tab = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = P.blue },
      tab_selected = { fg = tab_fg, bg = tab_bg, bold = true, italic = false, sp = P.blue },
      tab_separator = { fg = tab_fg, bg = tab_bg_inactive, sp = P.blue },
      tab_separator_selected = { fg = tab_fg, bg = tab_bg, sp = P.blue },
      tab_close = { fg = tab_fg, bg = tab_bg_inactive, sp = P.blue },
      indicator_selected = { fg = P.blue, bg = tab_bg, sp = P.blue },
      indicator_visible = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = P.blue },

      -- BUFFER PICK
      pick_selected = { fg = P.blue, bg = tab_bg, sp = P.blue, italic = true, bold = false },
      pick_visible = { fg = P.blue, bg = tab_bg_inactive, sp = P.blue, italic = true, bold = false },
      pick = { fg = P.blue, bg = tab_bg_inactive, sp = P.blue, italic = true, bold = false },

      -- MODIFIED
      modified = { fg = P.magenta, bg = tab_bg_inactive },
      modified_selected = { fg = tab_fg, bg = tab_bg, sp = P.blue },

      -- DUPLICATE
      duplicate_selected = { fg = tab_fg, bg = tab_bg, sp = P.blue },
      duplicate_visible = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = P.blue },
      duplicate = { fg = tab_fg_inactive, bg = tab_bg_inactive, sp = P.blue },

      -- SEPARATORS
      separator = { fg = tab_fg, bg = tab_bg_inactive },
      separator_visible = { fg = tab_fg, bg = tab_bg_inactive },
      separator_selected = { fg = tab_fg, bg = tab_bg },
      offset_separator = { fg = tab_fg, bg = tab_bg },

      -- CLOSE BUTTONS
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
        sp = P.blue,
      },

      -- EMPTY FILL
      fill = { bg = fill },
    }
  end,
})
