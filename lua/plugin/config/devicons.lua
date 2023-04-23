local icons = require("core.options").icons

local current_icons = require("nvim-web-devicons").get_icons()
local new_icons = {}

require("nvim-web-devicons").set_default_icon(icons.file, "#777777")

for key, icon in pairs(current_icons) do
	icon.icon = string.format("%s ", icon.icon)

	if icon.name == "Tsx" then
		icon.icon = " "
		icon.color = "#149ECA"
	end

	if icon.name == "Txt" then
		icon.icon = icons.file
	end

	if icon.name == "Md" then
		icon.icon = icons.book
	end

	-- icon.icon = " "
	-- icon.color = "#999999"

	new_icons[key] = icon
end

if vim.g.disable_icons then
	local nvim_web_devicons = require("nvim-web-devicons")

	for key, icon in pairs(current_icons) do
		icon.icon = ""
		icon.color = "none"
		new_icons[key] = icon
	end

	nvim_web_devicons.set_icon(new_icons)
end

require("nvim-web-devicons").set_icon(new_icons)
