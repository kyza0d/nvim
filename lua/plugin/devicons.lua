local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not status_ok then
  return
end

-- local colors = require("palette").colors
local icons = require("options").icons

local current_icons = nvim_web_devicons.get_icons()
local new_icons = {}

require("nvim-web-devicons").set_default_icon(icons.file, "#777777")

for key, icon in pairs(current_icons) do
  icon.icon = string.format("%s ", icon.icon)

  icon.icon = vim.g.icons_enabled and icon.icon or ""
  icon.color = vim.g.icons_enabled and icon.color or "#777777"

  if icon.name == "Txt" then
    icon.icon = icons.file
  end

  if icon.name == "Md" then
    icon.icon = icons.book
  end

  new_icons[key] = icon
end

nvim_web_devicons.set_icon(new_icons)
