local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
	return
end

local colors = require("palette").colors

local background = colors.background_darken

local dimmed = {
	c = { bg = background, fg = colors.foreground_4, gui = "strikethrough" },
	x = { bg = background, fg = colors.foreground_4, gui = "strikethrough" },
}

local theme = {
	normal = dimmed,
	insert = dimmed,
	visual = dimmed,
	replace = dimmed,
	command = dimmed,
	inactive = dimmed,
}

local search_count = function()
	if vim.v.hlsearch ~= 0 then
		return ""
	end

	local last_search = vim.fn.getreg("/")
	local searchcount = vim.fn.searchcount({ maxcount = 9999 })

	return "/" .. last_search .. "[" .. searchcount.current .. "/" .. searchcount.total .. "]"
end

local root = function()
	local root = vim.fn.getcwd()
	local workspace = root:sub(root:find("[^/]*$"))
	if workspace == "evan" then
		workspace = "~"
	end
	return "  " .. workspace
end

local sections = {
	lualine_a = {},
	lualine_b = {},
  lualine_c = { "mode",
  { 
    "diagnostics" ,
    symbols = {error = '  ', warn = '𥉉 ', info = '𥉉 ', hint = '  '},
    diagnostics_color = {
      error = 'Statusline',
      warn  = 'Statusline',
      info  = 'Statusline',
      hint  = 'Statusline',
    }}},
	lualine_x = {},
	lualine_y = { search_count,  root , {
		"diff",
		diff_color = {
			added    = 'Statusline',
			modified = 'Statusline',
			removed  = 'Statusline',
		},
	 }},
	lualine_z = { },
}

local inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = { "filename" },
	lualine_x = { "encoding" },
	lualine_y = {},
	lualine_z = {},
}

lualine.setup({
	sections = sections,
	inactive_sections = inactive_sections,

	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "neo-tree", "Outline" },
	},
})
