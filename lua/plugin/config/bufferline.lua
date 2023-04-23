local root = function()
  local root = vim.fn.getcwd()
  local workspace = " " .. root:sub(root:find("[^/]*$"))
  return workspace
end

local icons = require("core.options").icons

return {
  options = {
    -- separator_style = { { "", "▏" }, { "▏", "" } },
    separator_style = { "", "" },

    right_mouse_command = "Bdelete! %d",

    indicator = {
      style = "underline",
    },

    show_buffer_close_icons = false,
    show_buffer_icons = false,
    show_close_icon = false,

    enforce_regular_tabs = false,

    modified_icon = "",
    buffer_close_icon = "",
    -- buffer_close_icon = " ",

    left_trunc_marker = "",
    right_trunc_marker = "",

    truncate_names = false,
    tab_size = 0,

    offsets = {
      {
        filetype = "neo-tree",
        text_align = "left",
        highlight = "ProjectRoot",
        padding = 0,
        text = string.format("%s %s", icons.book_alt, root()),
      },
    },
    -- custom_areas = {
    -- 	right = function()
    -- 		return {
    -- 			{ text = "   ", fg = "#aaaaaa" },
    -- 			{ text = "    ", fg = "#aaaaaa" },
    -- 			{ text = "  󰖭  ", fg = "#aaaaaa" },
    -- 		}
    -- 	end,
    -- },
  },
}
