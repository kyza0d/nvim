local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
  return
end

local workspace_root = require("core.utils").workspace_root
local icons = require("core.utils").getvar("icons")

bufferline.setup({
  options = {
    indicator_icon = icons.tab_indicator,
    separator_style = { "", "" },
    right_mouse_command = "Bdelete! %d",
    show_buffer_close_icons = false,
    show_buffer_icons = false,
    show_close_icon = false,
    enforce_regular_tabs = false,
    themeable = true,
    tab_size = 17,
    left_trunc_marker = "",
    right_trunc_marker = "",
    offsets = {
      {
        filetype = "NvimTree",
        text_align = "left",
        padding = 1,
        text = workspace_root(),
      },
    },
  },
  highlights = {
    buffer_selected = {
      gui = "none"
    }
  }
})
