local colors = require("harmony").colors
local pywal_colors = require("neowal").palette

local wal_colors = {
	Color1 = { fg = pywal_colors.color1 },
	Color2 = { fg = pywal_colors.color2 },
	Color3 = { fg = pywal_colors.color3 },
	Color4 = { fg = pywal_colors.color4 },
	Color5 = { fg = pywal_colors.color5 },
	Color6 = { fg = pywal_colors.color6 },
	Color7 = { fg = pywal_colors.color7 },
	Color8 = { fg = pywal_colors.color8 },
}

local StatusLine = {
	fg = colors.fg_2,
	bg = colors.bg_negative_1,
}

local cursor_line = {
	CursorLine = { bg = colors.bg_2 },
	CursorLineNr = { bg = colors.bg_2 },
	CursorLineSign = { bg = colors.bg_2 },
	CursorLineFold = { bg = colors.bg_2 },
}

local status_line = {
	StatusLineCaps = { fg = colors.bg_negative_1, bg = colors.bg_0 },
	StatusLine = { fg = StatusLine.fg, bg = StatusLine.bg },
	StatusLineNC = { fg = colors.fg_4, bg = StatusLine.bg },
	StatusLineGreen = { fg = colors.green, bg = StatusLine.bg },
	StatusLineBlue = { fg = colors.blue, bg = StatusLine.bg },
	StatusLineYellow = { fg = colors.yellow, bg = StatusLine.bg },
	StatusLineRed = { fg = colors.red, bg = StatusLine.bg },
	StatusLineError = { fg = colors.red, bg = StatusLine.bg },
	StatusLineWarning = { fg = colors.yellow, bg = StatusLine.bg },
	StatusLineInfo = { fg = colors.blue, bg = StatusLine.bg },
	StatusLineHint = { fg = colors.purple, bg = StatusLine.bg },
	StatusLineMode = { fg = StatusLine.fg, bg = StatusLine.bg, bold = true },
	NormalMode = { fg = colors.bg_negative_1, bg = colors.blue },
	InsertMode = { fg = colors.bg_negative_1, bg = colors.purple },
	VisualMode = { fg = colors.bg_negative_1, bg = colors.red },
	LineMode = { fg = colors.bg_negative_1, bg = colors.red },
	BlockMode = { fg = colors.bg_negative_1, bg = colors.orange },
	ReplaceMode = { fg = colors.bg_negative_1, bg = colors.purple },
	SelectMode = { fg = colors.bg_negative_1, bg = colors.yellow },
	CommandMode = { fg = colors.bg_negative_1, bg = colors.yellow },
	TerminalMode = { fg = colors.bg_negative_1, bg = colors.green },
	Reverse = { reverse = true },
}

local whichkey = {
	["WhichKeyFloat"] = { bg = colors.bg_negative_1 },
}

local treesitter = {
	["@comment"] = { italic = true, fg = colors.fg_4 },
	["@neorg.headings.1.title"] = { fg = colors.orange, bold = true },
	["@punctuation.bracket"] = { fg = colors.fg_3 },
	["@constructor"] = { clear = true },
	["@operator"] = { fg = colors.fg_3 },
	["@neorg.tags.ranged_verbatim.code_block"] = { bg = colors.bg_negative_1 },
	["@neorg.markup.strikethrough.delimiter"] = { link = "@neorg.markup.strikethrough" },
}

local bufferline = {
	BufferLineFill = { underline = true, fg = colors.fg_4 },
	BufferLineBackground = { underline = true, fg = colors.fg_3, sp = colors.fg_4 },
	BufferLineBufferVisible = { underline = true, fg = colors.fg_3, sp = colors.fg_4 },
	BufferLineIndicatorVisible = { underline = true, fg = colors.fg_4 },
	TabLineSel = { fg = colors.bg_3, bg = colors.fg_1 },
}

local neotree = {
	ProjectRoot = { bg = colors.bg_0, fg = colors.blue },
	NeoTreeDirectoryNode = { fg = colors.blue },
	NeoTreeDirectoryName = { fg = colors.blue },
	NeoTreeIndentMarker = { fg = colors.bg_4 },
	NeoTreeDirectoryIcon = { fg = colors.fg_4 },
	FloatBorder = { fg = colors.fg_4, bg = "none" },
	NeoTreeFloatBorder = { fg = colors.fg_4, bg = "none" },
	NeoTreeFloatTitle = { fg = colors.fg_4, italic = true },
	NeoTreeNormal = { bg = colors.bg_0 },
	NeoTreeNormalNC = { bg = colors.bg_0 },
	NeoTreeEndOfBuffer = { bg = colors.bg_0 },
	NeoTreeCursorLine = { bg = colors.bg_0 },
	NeoTreeSignColumn = { link = "SignColumn" },
	NeoTreeStatusLine = { link = "StatusLine" },
	NeoTreeStatusLineNC = { link = "StatusLineNC" },
	NeoTreeVertSplit = { link = "VertSplit" },
	NeoTreeFilterTerm = { link = "SpecialChar" },
	NeoTreePreview = { link = "Search" },
	NeoTreeGitAdded = { link = "GitSignsAdd" },
	NeoTreeGitDeleted = { link = "GitSignsDelete" },
	NeoTreeGitModified = { link = "GitSignsChange" },

	NeoTreeTitleBar = { fg = colors.fg_1, bg = colors.bg_3 },
	NeoTreeDimText = { fg = colors.bg_2 },
	NeoTreeDotfile = { fg = colors.fg_4 },
	NeoTreeModified = { fg = colors.yellow },
	NeoTreeTabActive = { fg = colors.fg_1, bg = colors.bg_negative_1, bold = true },
	NeoTreeTabInactive = { fg = colors.fg_3, bg = colors.bg_negative_1 },
	NeoTreeTabSeparatorInactive = { fg = colors.bg_negative_1, bg = colors.bg_negative_1 },
	NeoTreeTabSeparatorActive = { fg = colors.bg_negative_1, bg = colors.bg_negative_1 },
}

local dashboard = {
	DashboardHeader = { link = "Color6" },
	DashboardBackground = { bg = colors.bg_3 },
}

local other = {
	ScrollView = { fg = colors.fg_4 },
	WinSeparator = { fg = colors.fg_4 },
	Hide = { fg = colors.bg_0 },

	Folded = { bg = colors.bg_2, fg = colors.blue },
	EndOfBuffer = { fg = colors.fg_4 },
	FoldIndicator = { fg = colors.blue, bg = colors.bg_2 },

	FoldColumn = { fg = colors.fg_4 },
}

-- stylua: ignore
local highlights = {
	status_line, cursor_line, treesitter,
	neotree, dashboard, whichkey,
	wal_colors, other, bufferline,
}

local result = {}

for _, tbl in ipairs(highlights) do
	for k, v in pairs(tbl) do
		result[k] = v
	end
end

return result
