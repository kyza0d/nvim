local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
  return
end

local root = function()
  local root = vim.fn.getcwd()
  local workspace = " " .. root:sub(root:find("[^/]*$"))
  return workspace
end

local icons = require("options").icons

bufferline.setup({
  options = {
    separator_style = { "", "" },

    indicator = {
      -- icon = " ",
      style = "none",
    },

    right_mouse_command = "Bdelete! %d",

    show_buffer_close_icons = true,
    show_buffer_icons = false,
    show_close_icon = false,

    enforce_regular_tabs = false,

    modified_icon = " ",
    buffer_close_icon = " ",

    left_trunc_marker = "",
    right_trunc_marker = "",

    truncate_names = false,
    tab_size = 25,

    offsets = {
      {
        filetype = "neo-tree",
        text_align = "left",
        highlight = "ProjectRoot",
        padding = 0,
        text = " " .. icons.book_alt .. root(),
      },
    },
  },
})
