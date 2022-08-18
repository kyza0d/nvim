local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not status_ok then
  return
end

local colors = require("palette").colors

local current_icons = nvim_web_devicons.get_icons()
local new_icons = {}

for key, icon in pairs(current_icons) do
  icon.icon = icon.icon .. " "
  -- icon.icon = " "
  if icon.name == "Md" then
    icon.icon = " "
    icon.color = colors.foreground_3
  end
  -- icon.color = colors.foreground_3
  new_icons[key] = icon
end

nvim_web_devicons.set_icon(new_icons)
