local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
  return
end

local darken = require("palette.utils").darken_float
local colors = require("palette").colors

local workspace_root = require("utils").workspace_root
local icons = require("utils").getvar("icons")

bufferline.setup({
  options = {
    indicator_icon = " ",
    separator_style = { "", "" },
    right_mouse_command = "Bdelete! %d",
    show_buffer_close_icons = false,
    enforce_regular_tabs = false,
    show_buffer_icons = false,
    show_close_icon = false,
    themeable = true,
    tab_size = 18,
    modified_icon = "●",
    left_trunc_marker = "",
    right_trunc_marker = "",
    offsets = {
      {
        filetype = "neo-tree",
        text_align = "left",
        padding = 0,
        text = "  " .. workspace_root(),
      },
    },
  },
})
