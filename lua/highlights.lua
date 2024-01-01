--------------------------------------------
-- Editor Highlights -----------------------------------------
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

local cursor_line = {
  CursorLine = { bg = colors.bg_1 },
  CursorLineNr = { fg = colors.fg_3, bg = colors.bg_1 },
  CursorLineSign = { bg = colors.bg_1 },
  CursorLineFold = { bg = colors.bg_1 },
}

local statusline_palette = {
  fg = colors.fg_2,
  fg_dim = colors.fg_2,
  bg = colors.bg_2,
}

local status_line = {
  StatusLine = { fg = statusline_palette.fg, bg = statusline_palette.bg },
  StatusLineCustom = { fg = statusline_palette.fg, bg = statusline_palette.bg },
  StatusLineNC = { fg = statusline_palette.fg, bg = statusline_palette.bg },
  StatusLineSpinner = { fg = colors.blue, bg = statusline_palette.bg },
  StatusLineModeNormal = { bg = statusline_palette.bg, fg = colors.blue, bold = true },
  StatusLineModeVisual = { bg = statusline_palette.bg, fg = colors.purple, bold = true },
  StatusLineModeCommand = { bg = statusline_palette.bg, fg = colors.green, bold = true },
  StatusLineModeInsert = { bg = statusline_palette.bg, fg = colors.green, bold = true },
  StatusLineModePending = { bg = statusline_palette.bg, fg = colors.fg_3, bold = true },
}

local whichkey = {
  ['WhichKeyFloat'] = { bg = colors.bg_3, fg = colors.fg_3 },
  ['WhichKeyGroup'] = { fg = colors.green },
  ['WhichKeySeparator'] = { fg = colors.fg_3 },
  ['WhichKey'] = { fg = colors.blue },
}

local treesitter = {
  ['Comment'] = { fg = colors.fg_4, italic = true },
  ['@comment'] = { fg = colors.fg_4, italic = true },
  ['@neorg.headings.1.title'] = { fg = colors.orange, bold = true },
  ['@punctuation.bracket'] = { fg = colors.fg_3 },
  ['@constructor'] = { clear = true },
  ['@operator'] = { fg = colors.fg_3 },
  ['@neorg.tags.ranged_verbatim.code_block'] = { bg = colors.bg_negative_1 },
  ['@neorg.markup.strikethrough.delimiter'] = { link = '@neorg.markup.strikethrough' },
}

local telescope = {
  TelescopeMatching = { fg = colors.accent },

  TelescopeNormal = { fg = colors.fg_1, bg = colors.bg_1 },
  TelescopeBorder = { fg = colors.bg_2, bg = colors.blue },

  TelescopeSelection = { link = 'PmenuSel' },
  TelescopeSelectionCaret = { fg = colors.accent, bg = colors.bg_2 },

  TelescopeResultsNormal = { fg = colors.fg_3, bg = colors.bg_0 },
  TelescopePreviewNormal = { fg = colors.fg_1, bg = colors.bg_0 },
}

local neotree_palette = {
  fg = colors.fg_3,
  bg = colors.bg_negative_1,
  cursorline = colors.bg_1,
}

local neotree = {
  ProjectRoot = { bold = true, bg = neotree_palette.bg },
  NeoTreeNormal = { bg = neotree_palette.bg },
  NeoTreeNormalNC = { bg = neotree_palette.bg },
  NeoTreeEndOfBuffer = { bg = neotree_palette.bg },
  NeoTreeCursorLine = { bg = neotree_palette.cursorline },
  NeoTreeSignColumn = { link = 'SignColumn' },
  NeoTreeStatusLine = { link = 'StatusLine' },
  NeoTreeStatusLineNC = { link = 'StatusLineNC' },
  NeoTreeVertSplit = { link = 'VertSplit' },
  NeoTreeWinSeparator = { link = 'WinSeparator' },
  NeoTreeBufferNumber = { link = 'SpecialChar' },
  NeoTreeFilterTerm = { link = 'SpecialChar' },
  NeoTreePreview = { link = 'Search' },

  NeoTreeDirectoryName = { fg = neotree_palette.fg },
  -- NeoTreeDirectoryIcon = { fg = '#E9C383' },
  NeoTreeDirectoryIcon = { fg = colors.fg_3 },

  NeoTreeFloatBorder = { fg = colors.bg_3 },
  NeoTreeFloatTitle = { fg = colors.fg_1 },
  NeoTreeTitleBar = { fg = colors.fg_1, bg = colors.bg_3 },
  NeoTreeDimText = { fg = colors.bg_2 },
  NeoTreeDotfile = { fg = colors.fg_4 },
  NeoTreeModified = { fg = colors.yellow },
  NeoTreeTabActive = { fg = colors.fg_1, bg = neotree_palette.bg, bold = true },
  NeoTreeTabSeparatorActive = { fg = neotree_palette.bg, bg = neotree_palette.bg },
  NeoTreeTabInactive = { fg = neotree_palette.fg, bg = neotree_palette.bg },
  NeoTreeTabSeparatorInactive = { fg = neotree_palette.bg, bg = neotree_palette.bg },
  NeoTreeIndentMarker = { fg = colors.bg_2 },

  NeoTreeFileName = { fg = neotree_palette.fg },
  NeoTreeFileNameOpened = { bold = true },
  NeoTreeMessage = { fg = colors.fg_4 },
  NeoTreeGitConflict = { fg = colors.orange },
  NeoTreeRootName = { fg = colors.fg_1, italic = false, bold = false },
  NeoTreeGitUntracked = { fg = colors.fg_1 },
}

local dashboard = {
  DashboardHeader = { link = 'Color6' },
  DashboardBackground = { bg = colors.bg_3 },
}

local headlines = {
  Headline = { bg = colors.bg_negative_1 },
  Headline1 = { bg = colors.bg_negative_1 },
}

local gitsigns = {
  GitSignsAdd = { fg = colors.green, bg = colors.bg_0 },
  GitSignsChange = { fg = colors.yellow, bg = colors.bg_0 },
  GitSignsDelete = { fg = colors.red, bg = colors.bg_0 },
}

local other = {
  Normal = { bg = colors.bg_0 },
  NormalNC = { bg = colors.bg_0 },

  -- Normal = { bg = colors.bg_0 },
  -- NormalNC = { bg = colors.bg_0 },
  -- WinSeparator = { fg = colors.bg_4, bg = colors.bg_negative_1 },
  -- EndOfBuffer = { fg = colors.fg_4, bg = colors.bg_negative_1 },
  LineNr = { fg = colors.fg_4 },

  -- Search = { bg = '#4c3e20' },
  -- Conceal = { fg = colors.fg_3 },
  -- CurSearch = { bg = '#66532b' },

  ScrollView = { fg = colors.fg_4 },
  Hide = { fg = colors.bg_0 },

  Folded = { bg = colors.bg_1, fg = colors.blue },
  FoldedIndicator = { bg = colors.bg_1, fg = colors.blue },
  FoldColumn = { fg = colors.fg_4 },
  Mark = { fg = colors.blue, italic = true },

  -- SignColumn = { bg = 'NONE', fg = colors.fg_4 },

  -- Search = { bg = '#EF0FFF', fg = '#ffffff' },
  -- PmenuSel = { fg = '#B4B8C0', bg = '#005F87' },
  -- Visual = { fg = '#B4B8C0', bg = '#005F87' },
  -- NavBuddyName = { links = 'Visual' },
  NavBuddyNormalFloat = { bg = colors.bg, fg = colors.fg_2 },

  LspInlayHint = { fg = colors.fg_4 },
}

local buffer_line = {
  TabLineSel = { fg = colors.blue, bold = true, underline = true, bg = colors.blue },

  BufferLineTab = { bg = colors.bg_2 },
  BufferLineBuffer = { bg = colors.bg_3 },
  BufferLineDuplicate = { bg = colors.bg_3 },
  BufferLineDuplicateSelected = { bg = colors.bg_3, underline = true, sp = colors.blue },
  BufferLineIndicatorSelected = { bg = colors.bg_3, fg = colors.blue, underline = true, sp = colors.blue },
  BufferLineBufferSelected = { bg = colors.bg_3, fg = colors.fg_0, bold = true, underline = true, sp = colors.blue },
  BufferLineNumbersSelected = { bg = colors.bg_3, fg = colors.fg_3, underline = true, sp = colors.blue },
  BufferLineModifiedSelected = { bg = colors.bg_3, fg = colors.green, underline = true, sp = colors.blue },
  BufferLineModifiedVisible = { bg = colors.bg_3 },
  BufferLineModified = { bg = colors.bg_3 },
  BufferLineBackground = { bg = colors.bg_3, fg = colors.fg_3 },
  BufferLineNumbers = { bg = colors.bg_3, fg = colors.fg_4 },
  BufferLineBufferVisible = { bg = colors.bg_3 },
  BufferLineNumbersVisible = { bg = colors.bg_3, fg = colors.fg_4 },
  BufferLineIndicatorVisible = { bg = colors.bg_3 },

  BufferLineFill = { bg = colors.bg_negative_1 },
  BufferLineOffsetSeparator = { bg = colors.bg_negative_1 },
  BufferLineSeparator = { bg = colors.bg_negative_1 },
  BufferLineTabSeparator = { bg = colors.bg_negative_1 },

  BufferLineCloseButtonVisible = { bg = colors.bg_3, fg = colors.fg_2 },
  BufferLineCloseButton = { bg = colors.bg_3, fg = colors.fg_2 },
  BufferLineCloseButtonSelected = { bg = colors.bg_3, fg = colors.fg_2, sp = colors.blue, underline = true },
}

local illuminate = {
  IlluminatedWordWrite = { bg = colors.bg_2 },
  IlluminatedWordRead = { bg = colors.bg_2 },
  IlluminatedWordTemporary = { bg = colors.bg_2 },
  illuminatedCurWord = { bg = colors.bg_2 },
  illuminatedWord = { bg = colors.bg_2 },
}

local trouble = {
  TroubleNormal = { bg = colors.bg_negative_1 },
}

local highlights = {
  status_line,
  buffer_line,
  cursor_line,
  treesitter,
  telescope,
  neotree,
  dashboard,
  whichkey,
  wal_colors,
  headlines,
  illuminate,
  gitsigns,
  trouble,
  other,
}

local result = {}

for _, tbl in ipairs(highlights) do
  for k, v in pairs(tbl) do
    result[k] = v
  end
end

return result
