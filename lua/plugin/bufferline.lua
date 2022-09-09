local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
  return
end

local workspace_root = function()
  local workspace_root = vim.fn.getcwd()
  local workspace = workspace_root:sub(workspace_root:find("[^/]*$"))
  if workspace == "evan" then
    workspace = "~"
  end
  return workspace
end

bufferline.setup({
  options = {
    indicator = {
      icon = " ",
      style = "icon",
    },
    separator_style = { "", "" },
    right_mouse_command = "Bdelete! %d",
    show_buffer_close_icons = false,
    enforce_regular_tabs = false,
    show_buffer_icons = false,
    buffer_close_icon = " ",
    show_close_icon = false,
    themeable = true,
    tab_size = 21,
    modified_icon = "ﱣ",
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
