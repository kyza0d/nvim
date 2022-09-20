local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
  return
end

local colors = require("palette").colors

local root = function()
  local root = vim.fn.getcwd()
  local workspace = root:sub(root:find("[^/]*$"))
  return workspace
end

vim.cmd(string.format("hi NeoTreeHeading guibg=%s guifg=%s", colors.background_shaded_0, colors.accent))

local icons = require("options").icons

bufferline.setup({
  options = {
    separator_style = { "", "" },
    indicator = {
      icon = "",
      style = "underline",
    },
    right_mouse_command = "Bdelete! %d",
    show_buffer_close_icons = false,
    show_buffer_icons = true,
    show_close_icon = false,

    themeable = true,

    modified_icon = "ﱣ",

    left_trunc_marker = "",
    right_trunc_marker = "",

    tab_size = 23,

    offsets = {
      {
        filetype = "neo-tree",
        text_align = "left",
        padding = 1,
        text = " " .. icons.book_alt .. root(),
      },
    },
  },
  highlights = {
    indicator_selected = {
      sp = "#ffffff",
    },
  },
})

keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>")
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>")
keymap("n", "<S-d>", "<cmd>Bdelete!<cr>")
