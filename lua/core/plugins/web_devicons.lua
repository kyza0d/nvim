local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if not status_ok then
  return
end

local current_icons = nvim_web_devicons.get_icons()

local new_icons = {}

for key, icon in pairs(current_icons) do
  -- icon.color = "#ff0088"
  -- icon.icon = ""
  -- icon.color = "#aaaaaa"
  new_icons[key] = icon
end

nvim_web_devicons.set_icon(new_icons)
