local colors = require("harmony").colors
local blend = require("harmony.factory").blend
local lightness = require("harmony.factory").change_hex_lightness

return {
  -- Built-in: Normal
  Normal = { bg = colors.background_0, fg = colors.foreground_1 },
  NormalNC = { bg = colors.background_0 },
  EndOfBuffer = { bg = colors.background_0 },

  ["@punctuation.bracket"] = { fg = colors.foreground_2 },
  ["TSConstructor"] = { fg = colors.foreground_2 },
  ["TSPunctBracket"] = { fg = colors.foreground_2 },

  NonText = { fg = colors.background_3 },

  Headline = { bg = colors.background_negative_1 },
  CodeBlock = { bg = colors.background_negative_1 },

  -- Built-in: Statusline
  WinBar = { bg = colors.background_0, fg = colors.foreground_3 },
  WinBarNC = { bg = colors.background_0, fg = colors.foreground_3 },

  Statusline = { bg = colors.background_negative_2, fg = colors.foreground_3 },
  StatuslineNC = { bg = colors.background_negative_2, fg = colors.foreground_0 },

  MsgArea = { fg = colors.foreground_2 },

  NormalFloat = { bg = colors.background_1, fg = colors.foreground_2 },
  FloatBorder = { bg = colors.background_1, fg = colors.background_3 },
  Pmenu = { bg = colors.background_1, gui = "none", fg = colors.foreground_0 },
  PmenuSel = { bg = colors.background_2, gui = "none" },

  -- Built-in: PopupMenu Pmenu = { links = "NormalFloat" },
  PmenuThumbSel = { bg = colors.accent },

  -- Built-in: Fold
  -- Folded = { bg = blend(colors.accent, colors.background_0, 0.9) },
  FoldColumn = { fg = colors.foreground_3, bg = colors.background_0 },

  -- Built-in: CursorLine
  CursorLine = { bg = colors.background_1 },
  CursorLineNr = { bg = colors.background_0, fg = colors.foreground_2 },
  -- CursorLine = { bg = colors.background_negative_1 },
  -- CursorLineNr = { bg = colors.background_negative_1, fg = colors.foreground_4 },
  LineNr = { bg = colors.none, fg = colors.foreground_4 },
  SignColumn = { bg = colors.none },

  -- Built-in: Error
  DiagnosticError = { fg = colors.red, bg = colors.none },
  DiagnosticSignError = { fg = colors.red, bg = colors.none },
  DiagnosticUnderlineError = { sp = colors.red, gui = "undercurl" },

  -- Built-in: Warning
  DiagnosticWarn = { fg = colors.yellow, bg = colors.none },
  DiagnosticSignWarn = { fg = colors.yellow, bg = colors.none },
  DiagnosticUnderlineWarn = { sp = colors.yellow, gui = "undercurl" },

  -- Built-in: Info
  DiagnosticInfo = { fg = colors.purple, bg = colors.none },
  DiagnosticSignInfo = { fg = colors.purple, bg = colors.none },
  DiagnosticUnderlineInfo = { sp = colors.purple, gui = "undercurl" },

  -- Built-in: Hint
  DiagnosticHint = { fg = colors.blue, bg = colors.none },
  DiagnosticSignHint = { fg = colors.blue, bg = colors.none },
  DiagnosticUnderlineHint = { sp = colors.blue, gui = "undercurl" },
  DiagnosticFloatingHint = { bg = colors.none, fg = colors.foreground_2 },

  NeoTreeNormal = { fg = colors.foreground_2, bg = colors.background_negative_1 },
  NeoTreeDimText = { fg = colors.foreground_4, bg = colors.background_negative_1 },
  NeoTreeDotFile = { fg = colors.foreground_4, bg = colors.background_negative_1 },
  NeoTreeHiddenByName = { fg = colors.foreground_4, bg = colors.background_negative_1 },
  NeoTreeNormalNC = { fg = colors.foreground_2, bg = colors.background_negative_1 },
  NeoTreeEndOfBuffer = { fg = colors.foreground_3, bg = colors.background_negative_1 },
  NeoTreeCursorLine = { bg = colors.background_negative_1 },
  NeoTreeFileIcon = { fg = colors.foreground_3 },
  NeoTreeDirectoryIcon = { fg = colors.foreground_3 },
  NeoTreeDirectoryName = { fg = colors.foreground_3 },
  NeoTreeTitleBar = { fg = colors.foreground_1, bg = colors.foreground_3 },
  NeoTreeFloatBorder = { fg = colors.foreground_3, bg = "none" },
  NeoTreeFloatTitle = { fg = colors.foreground_3, bg = colors.foreground_3 },
  NeoTreeIndentMarker = { fg = colors.foreground_4 },
  NeoTreeGitAdded = { bg = colors.background_negative_1, fg = colors.foreground_3 },
  NeoTreeGitUntracked = { bg = colors.background_negative_1, fg = colors.foreground_3 },
  NeoTreeGitUnstaged = { bg = colors.background_negative_1, fg = colors.foreground_3 },
  NeoTreeGitDeleted = { bg = colors.background_negative_1, fg = colors.foreground_3 },
  NeoTreeGitModified = { bg = colors.background_negative_1, fg = colors.foreground_3 },
  NeoTreeGitRenamed = { bg = colors.background_negative_1, fg = colors.foreground_3 },

  VertSplit = { bg = colors.background_0, fg = colors.background_2 },
  NeoTreeVertSplit = { bg = colors.background_0, fg = colors.background_2 },

  -- indent-blankline
  -- https://githubom/lukas-reineke/indent-blankline

  IndentBlankLineChar = { fg = colors.foreground_4 },
  IndentBlankLineContextChar = { fg = colors.foreground_3 },

  IndentBlanklineContextStart = {
    sp = colors.foreground_3,
    underline = true,
  },

  IndentBlankLineSpaceChar = { fg = "none" },
  IndentBlankLineSpaceCharBlankline = { fg = "none" },

  -- nvim-lspconfig
  -- https://githubom/neovim/nvim-lspconfig

  -- LSP Symbols
  LspReferenceRead = { bg = colors.background_1 },
  LspReferenceText = { bg = colors.background_1 },
  LspReferenceWrite = { bg = colors.background_1 },

  -- LSP Config: Error
  LspDiagnosticsDefaultError = { fg = colors.red },
  LspDiagnosticsSignError = { fg = colors.red },
  LspDiagnosticsError = { fg = colors.red },
  LspDiagnosticsUnderlineError = { sp = colors.red, gui = "undercurl" },

  -- LSP Config: Warning
  LspDiagnosticsDefaultWarn = { fg = colors.yellow },
  LspDiagnosticsSignWarn = { fg = colors.yellow },
  LspDiagnosticsWarn = { fg = colors.yellow },
  LspDiagnosticsUnderlineWarn = { sp = colors.yellow, gui = "undercurl" },

  -- LSP Config: Hint
  LspDiagnosticsDefaultHint = { fg = colors.purple },
  LspDiagnosticsSignHint = { fg = colors.purple },
  LspDiagnosticsHint = { fg = colors.purple },
  LspDiagnosticsUnderlineHint = { sp = colors.purple, gui = "undercurl" },

  -- LSP Config: Info
  LspDiagnosticsDefaultInfo = { fg = colors.blue },
  LspDiagnosticsSignInfo = { fg = colors.blue },
  LspDiagnosticsInfo = { fg = colors.blue },
  LspDiagnosticsUnderlineInfo = { sp = colors.blue, gui = "undercurl" },

  -- which-key
  -- https://githubom/folke/which-key

  WhichKeyFloat = { links = "NormalFloat" },
  WhichKeyDesc = { fg = colors.foreground_1, bg = colors.none },
  WhichKeyGroup = { fg = colors.foreground_2, bg = colors.none },
  WhichKeySeparator = { fg = colors.foreground_3, bg = colors.none },
  WhichKey = { fg = colors.foreground_2, gui = "bold", bg = colors.none },

  -- gitsigns
  -- https://githubom/lewis6991/gitsigns

  -- GitSigns: Added
  GitSignsAdd = { fg = colors.green, bg = colors.none },
  GitSignsAddLn = { fg = colors.green, bg = colors.none },
  GitSignsAddNr = { fg = colors.green, bg = colors.none },
  GitGutterAdd = { fg = colors.green, bg = colors.none },

  GitSignsCurrentLineBlame = { fg = colors.foreground_3 },

  -- GitSigns: Changed
  GitSignsChangeLn = { fg = colors.yellow, bg = colors.none },
  GitSignsChangeNr = { fg = colors.yellow, bg = colors.none },
  GitSignsChange = { fg = colors.yellow, bg = colors.none },

  -- GitSigns: Deleted
  GitSignsDelete = { fg = colors.red, bg = colors.none },
  GitSignsDeleteLn = { fg = colors.red, bg = colors.none },
  GitSignsDeleteNr = { fg = colors.red, bg = colors.none },
  GitGutterDelete = { fg = colors.red, bg = colors.none },

  -- telescope
  -- https://githubom/nvim-telescope/telescope

  -- Telescope: Preview
  TelescopePreviewTitle = { bg = colors.none, fg = colors.foreground_3 },
  TelescopePreviewBorder = { fg = colors.foreground_3 },
  TelescopePreviewNormal = { fg = colors.foreground_2 },

  -- Telescope: Results
  TelescopeResultsTitle = { fg = colors.foreground_3 },
  TelescopeResultsBorder = { fg = colors.foreground_3 },
  TelescopeResultsNormal = { fg = colors.foreground_2 },

  -- Telescope: Prompt
  TelescopePromptBorder = { fg = colors.foreground_3 },
  TelescopePromptNormal = { fg = colors.foreground_2 },
  TelescopePromptPrefix = { fg = colors.accent },
  TelescopePromptTitle = { bg = colors.none, fg = colors.foreground_3 },
  TelescopePromptCounter = { fg = colors.accent },

  -- Telescope: Other
  TelescopeSelection = { links = "PmenuSel" },
  -- TelescopeMatching = { fg = colors.none, gui = "underline", sp = colors.blue },
  TelescopeMatching = { fg = colors.accent, gui = "underline" },

  -- nvim-ufo
  -- https://github.com/kevinhwang91/nvim-ufo

  UfoFoldedBg = { bg = "none" },
  UfoFoldedFg = { bg = "none" },
  UfoFoldedEllipsis = { fg = colors.foreground_3 },

  -- bufferline
  -- https://github.com/akinsho/bufferline.nvim

  -- nvim-cmp
  -- https://githubom/hrsh7th/nvim-cmp

  -- Icons
  CmpItemAbbr = { fg = colors.foreground_2 },
  CmpItemMenu = { fg = colors.foreground_2 },
  CmpItemAbbrMatch = { fg = colors.accent, bg = colors.none, gui = "underline" },
  CmpItemAbbrMatchFuzzy = { fg = colors.foreground_0, gui = "underline" },
  CmpItemKindKind = { fg = colors.accent },
  CmpItemKindClass = { fg = colors.green },
  CmpItemKindConstructor = { fg = colors.green },
  CmpItemKindField = { fg = colors.blue },
  CmpItemKindFile = { fg = colors.yellow },
  CmpItemKindFolder = { fg = colors.yellow },
  CmpItemKindFunction = { fg = colors.purple },
  CmpItemKindInterface = { fg = colors.blue },
  CmpItemKindKeyword = { fg = colors.blue },
  CmpItemKindMethod = { fg = colors.purple },
  CmpItemKindSnippet = { fg = colors.yellow },
  CmpItemKindText = { fg = colors.foreground_2 },
  CmpItemKindValue = { fg = colors.blue },
  CmpItemKindVariable = { fg = colors.purple },
  CmpItemAbbrDepricated = { fg = colors.foreground_2, gui = "strikethrough" },

  NavicIconsFile = { fg = colors.accent },
  NavicIconsModule = { fg = colors.accent },
  NavicIconsNamespace = { fg = colors.accent },
  NavicIconsPackage = { fg = colors.accent },
  NavicIconsClass = { fg = colors.accent },
  NavicIconsMethod = { fg = colors.accent },
  NavicIconsProperty = { fg = colors.accent },
  NavicIconsField = { fg = colors.accent },
  NavicIconsConstructor = { fg = colors.accent },
  NavicIconsEnum = { fg = colors.accent },
  NavicIconsInterface = { fg = colors.accent },
  NavicIconsFunction = { fg = colors.accent },
  NavicIconsVariable = { fg = colors.accent },
  NavicIconsConstant = { fg = colors.accent },
  NavicIconsString = { fg = colors.accent },
  NavicIconsNumber = { fg = colors.accent },
  NavicIconsBoolean = { fg = colors.accent },
  NavicIconsArray = { fg = colors.accent },
  NavicIconsObject = { fg = colors.accent },
  NavicIconsKey = { fg = colors.accent },
  NavicIconsNull = { fg = colors.accent },
  NavicIconsEnumMember = { fg = colors.accent },
  NavicIconsStruct = { fg = colors.accent },
  NavicIconsEvent = { fg = colors.accent },
  NavicIconsOperator = { fg = colors.accent },
  NavicIconsTypeParameter = { fg = colors.accent },
  NavicText = { fg = colors.accent },
  NavicSeparator = { fg = colors.accent },
}
