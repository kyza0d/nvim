local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
  return
end

-- local colors = require("palette").colors

local root = function()
  local root = vim.fn.getcwd()
  local workspace = " " .. root:sub(root:find("[^/]*$"))
  return workspace
end

-- vim.cmd(string.format("hi NeoTreeHeading guibg=%s guifg=%s", colors.background_shaded_0, colors.accent))

local icons = require("options").icons

bufferline.setup({
  options = {
    separator_style = { "", "" },
    -- separator_style = "slant",
    indicator = {
      style = "underline",
    },
    right_mouse_command = "Bdelete! %d",

    show_buffer_close_icons = false,
    show_buffer_icons = false,
    show_close_icon = false,

    modified_icon = "",

    left_trunc_marker = "",
    right_trunc_marker = "",

    tab_size = 15,

    offsets = {
      {
        filetype = "neo-tree",
        text_align = "left",
        padding = 0,
        text = " " .. icons.book_alt .. root(),
      },
    },
  },
  -- highlights = {
  -- background = {
  --   bg = colors.background_shaded_0,
  -- },
  -- buffer_visible = {
  --   bg = colors.background_shaded_0,
  -- },
  -- buffer_selected = {
  --   bg = colors.background_0,
  -- },
  -- },
})
