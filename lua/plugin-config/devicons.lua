local nvim_web_devicons = require("nvim-web-devicons")

local colors = require("palette").colors

local current_icons = nvim_web_devicons.get_icons()
local new_icons = {}

for key, icon in pairs(current_icons) do
  icon.icon = icon.icon .. " "
  if icon.name == "Md" then
    icon.icon = " "
    icon.color = colors.foreground_3
  end
  new_icons[key] = icon
end

nvim_web_devicons.set_icon(new_icons)
