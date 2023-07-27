--------------------------------------------
-- Editor Highlights
--------------------------------------------

local colors = require('harmony').colors
local neowal = require('neowal').palette

local wal_colors = {
  Color1 = { fg = neowal.color1 },
  Color2 = { fg = neowal.color2 },
  Color3 = { fg = neowal.color3 },
  Color4 = { fg = neowal.color4 },
  Color5 = { fg = neowal.color5 },
  Color6 = { fg = neowal.color6 },
  Color7 = { fg = neowal.color7 },
  Color8 = { fg = neowal.color8 },
}

local StatusLine = {
  fg = colors.fg_1,
  fg_dim = colors.fg_2,
  bg = colors.bg_negative_1,
}

local Neotree = {
  fg = colors.fg_2,
  bg = colors.bg_negative_1,
  cursorline = colors.bg_1,
}

local cursor_line = {
  CursorLine = { bg = colors.bg_1 },
  CursorLineNr = { fg = colors.fg_3, bg = colors.bg_1 },
  CursorLineSign = { bg = colors.bg_1 },
  CursorLineFold = { bg = colors.bg_1 },
}

local status_line = {
  StatusLineCaps = { fg = colors.bg_negative_1, bg = colors.bg_0 },
  CustomStatusLine = { fg = StatusLine.fg, bg = StatusLine.bg },
  CustomStatusLineNC = { fg = colors.fg_4, bg = StatusLine.bg },
  StatusLineGreen = { fg = colors.green, bg = StatusLine.bg },
  StatusLineBlue = { fg = colors.blue, bg = StatusLine.bg },
  StatusLineYellow = { fg = colors.yellow, bg = StatusLine.bg },
  StatusLineRed = { fg = colors.red, bg = StatusLine.bg },
  StatusLineError = { fg = colors.red, bg = StatusLine.bg },
  StatusLineWarning = { fg = colors.yellow, bg = StatusLine.bg },
  StatusLineInfo = { fg = colors.blue, bg = StatusLine.bg },
  StatusLineHint = { fg = colors.purple, bg = StatusLine.bg },
  StatusLineDim = { fg = StatusLine.fg_dim, bg = StatusLine.bg },
  StatusLineMode = { fg = StatusLine.fg, bg = StatusLine.bg },
  NormalMode = { fg = colors.blue, bg = StatusLine.bg },
  InsertMode = { fg = colors.purple, bg = StatusLine.bg },
  VisualMode = { fg = colors.red, bg = StatusLine.bg },
  LineMode = { fg = colors.red, bg = StatusLine.bg },
  BlockMode = { fg = colors.orange, bg = StatusLine.bg },
  ReplaceMode = { fg = colors.purple, bg = StatusLine.bg },
  SelectMode = { fg = colors.yellow, bg = StatusLine.bg },
  CommandMode = { fg = colors.yellow, bg = StatusLine.bg },
  TerminalMode = { fg = colors.green, bg = StatusLine.bg },
  Reverse = { reverse = true },
}

local whichkey = {
  ['WhichKeyFloat'] = { link = 'BufferLineFill' },
}

local treesitter = {
  ['@comment'] = { fg = colors.fg_3 },
  ['@neorg.headings.1.title'] = { fg = colors.orange, bold = true },
  ['@punctuation.bracket'] = { fg = colors.fg_3 },
  ['@constructor'] = { clear = true },
  ['@operator'] = { fg = colors.fg_3 },
  ['@neorg.tags.ranged_verbatim.code_block'] = { bg = colors.bg_negative_1 },
  ['@neorg.markup.strikethrough.delimiter'] = { link = '@neorg.markup.strikethrough' },
}

local neotree = {
  ProjectRoot = { bg = Neotree.bg, fg = colors.blue },
  NeoTreeDirectoryName = { fg = colors.blue },
  NeoTreeDirectoryIcon = { fg = colors.blue },
  NeoTreeIndentMarker = { fg = colors.bg_4 },
  FloatBorder = { fg = colors.fg_4, bg = 'none' },
  NeoTreeFloatBorder = { fg = colors.fg_4, bg = 'none' },
  NeoTreeFloatTitle = { fg = colors.fg_4, italic = true },
  NeoTreeNormal = { bg = Neotree.bg },
  NeoTreeNormalNC = { bg = Neotree.bg },
  NeoTreeEndOfBuffer = { bg = Neotree.bg },
  NeoTreeCursorLine = { bg = Neotree.cursorline },
  NeoTreeSignColumn = { link = 'SignColumn' },
  NeoTreeStatusLine = { link = 'StatusLine' },
  NeoTreeStatusLineNC = { link = 'StatusLineNC' },
  NeoTreeVertSplit = { link = 'VertSplit' },
  NeoTreeFilterTerm = { link = 'SpecialChar' },
  NeoTreePreview = { link = 'Search' },
  NeoTreeGitAdded = { bg = colors.bg_0, fg = colors.green },
  NeoTreeGitDeleted = { bg = colors.bg_0, fg = colors.red },
  NeoTreeGitModified = { bg = colors.bg_0, fg = colors.yellow },

  NeoTreeTitleBar = { fg = colors.fg_1, bg = colors.bg_0 },
  NeoTreeDimText = { fg = colors.bg_0 },
  NeoTreeDotfile = { fg = colors.fg_4 },
  NeoTreeModified = { fg = colors.yellow },
  NeoTreeTabActive = { fg = colors.fg_1, bg = colors.bg_0, bold = true },
  NeoTreeTabInactive = { fg = colors.fg_3, bg = colors.bg_0 },
  NeoTreeTabSeparatorInactive = { fg = colors.bg_0, bg = colors.bg_0 },
  NeoTreeTabSeparatorActive = { fg = colors.bg_0, bg = colors.bg_0 },
}

local dashboard = {
  DashboardHeader = { link = 'Color6' },
  DashboardBackground = { bg = colors.bg_3 },
}

local other = {
  ScrollView = { fg = colors.fg_4 },
  WinSeparator = { fg = colors.bg_0, bg = colors.bg_0 },
  Hide = { fg = colors.bg_0 },

  EndOfBuffer = { fg = colors.fg_4 },

  Folded = { bg = colors.bg_1, fg = colors.blue },
  FoldIndicator = { fg = colors.blue, bg = colors.bg_1 },
  FoldColumn = { fg = colors.fg_4 },

  SignColumn = { bg = 'NONE', fg = colors.fg_4 },

  NavBuddyName = { links = 'Visual' },
  NavBuddyNormalFloat = { bg = colors.bg, fg = colors.fg_2 },

  LspInlayHint = { fg = colors.fg_4 },
}

local highlights = {
  status_line,
  cursor_line,
  treesitter,
  neotree,
  dashboard,
  whichkey,
  wal_colors,
  other,
}

local result = {}

for _, tbl in ipairs(highlights) do
  for k, v in pairs(tbl) do
    result[k] = v
  end
end

return result
