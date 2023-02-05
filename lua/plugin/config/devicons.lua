local icons = require("core.options").icons

local current_icons = require("nvim-web-devicons").get_icons()
local new_icons = {}

require("nvim-web-devicons").set_default_icon(icons.file, "#777777")

for key, icon in pairs(current_icons) do
  icon.icon = string.format("%s", icon.icon)

  icon.icon = icon.icon
  icon.color = icon.color

  if icon.name == "Txt" then
    icon.icon = icons.file
  end

  if icon.name == "Md" then
    icon.icon = icons.book
  end

  new_icons[key] = icon
end

require("nvim-web-devicons").set_icon(new_icons)
