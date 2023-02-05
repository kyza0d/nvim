local root = function()
  local root = vim.fn.getcwd()
  local workspace = " " .. root:sub(root:find("[^/]*$"))
  return workspace
end

local icons = require("core.options").icons

return {
  options = {
    separator_style = { "", "" },

    right_mouse_command = "Bdelete! %d",

    indicator = {
      icon = "▎",
      style = "icon",
    },

    show_buffer_close_icons = true,
    show_buffer_icons = true,
    show_close_icon = false,

    enforce_regular_tabs = true,

    modified_icon = " ",
    buffer_close_icon = " ",

    left_trunc_marker = "",
    right_trunc_marker = "",

    truncate_names = false,
    tab_size = 24,

    offsets = {
      {
        filetype = "neo-tree",
        text_align = "left",
        highlight = "ProjectRoot",
        padding = 0,
        text = string.format("%s%s", icons.book_alt, root()),
      },
    },
  },
}