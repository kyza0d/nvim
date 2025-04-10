if not ky then return end

local hl, vivid_blend_hsl, P = ky.hl, ky.hl.vivid_blend_hsl, ky.ui.palette

local function set_sidebar_highlight()
  hl.all({
    { PanelDarkBackground = { bg = { from = 'Normal', alter = -0.12 } } },
    { PanelDarkHeading = { inherit = 'PanelDarkBackground', bold = true } },
    { PanelBackground = { bg = { from = 'Normal', alter = -0.12 } } },
    { PanelHeading = { inherit = 'PanelBackground', bold = true } },
    { PanelWinSeparator = { inherit = 'PanelBackground', fg = { from = 'WinSeparator' } } },
    { PanelStNC = { link = 'PanelWinSeparator' } },
    { PanelSt = { bg = { from = 'Normal', alter = -0.12 } } },
  })
end

local sidebar_fts = { 'Avante', 'AvanteInput', 'AvanteSelectedFiles', 'Trouble' }

local function on_sidebar_enter()
  vim.opt_local.winhighlight:append({
    Normal = 'PanelBackground',
    EndOfBuffer = 'PanelBackground',
    StatusLine = 'PanelSt',
    StatusLineNC = 'PanelStNC',
    SignColumn = 'PanelBackground',
    VertSplit = 'PanelVertSplit',
    WinSeparator = 'PanelWinSeparator',
  })
end

local function general_overrides()
  local normal_bg = hl.get('Normal', 'bg')
  local bg_color = hl.tint(normal_bg, -0.25)

  local accent = P.accent
  local accent_50 = hl.blend({ accent, hl.get('Normal', 'bg') }, -0.2)
  local accent_80 = hl.blend({ accent, hl.get('Normal', 'bg') }, -0.1)

  hl.all({
    { Cursor = { bg = P.accent, reverse = false } },
    { iCursor = { bg = P.accent, reverse = false } },
    { lCursor = { bg = P.accent, reverse = false } },
    { vCursor = { bg = P.accent, reverse = false } },
    { tCursor = { bg = P.accent, reverse = false } },
    { Directory = { fg = { from = 'Normal', alter = -0.45 } } },
    { Search = { clear = true, bg = accent_50 } },
    { CurSearch = { clear = true, bg = accent_80 } },
    { IncSearch = { clear = true, bg = accent_50 } },
    { Visual = { bg = accent_50 } },
    { IndentLine = { fg = { from = 'Normal', attr = 'fg', alter = -0.80 }, bg = 'none' } },
    { LineNr = { fg = { from = 'Normal', attr = 'fg', alter = -0.50 }, bg = 'none' } },
    { WinSeparator = { fg = { from = 'Normal', attr = 'bg', alter = 0.80 } } },
    { SignColumn = { bg = 'none' } },
    { FoldStatus = { fg = { from = 'LineNr' } } },
    { EndOfBuffer = { bg = 'none' } },
    { Term = { bg = { from = 'Normal', alter = -0.25 } } },
    { TermBorder = { bg = { from = 'Normal', alter = -0.25 } } },
    { Pmenu = { bg = { from = 'Normal', alter = -0.35 }, fg = 'none' } },
    { PmenuSel = { bg = { from = 'Pmenu', alter = 0.85 }, fg = 'none', bold = false } },
    { CursorLine = { bg = { from = 'Normal' } } },
    { CursorLineNr = { bg = { from = 'Normal', alter = 0.30 }, fg = { from = 'Identifier' } } },
    { CursorLineFold = { clear = true } },
    { CursorLineSign = { clear = true } },
    { NormalFloat = { bg = { from = 'Normal', alter = -0.12 } } },
    { FloatBorder = { bg = { from = 'Normal', alter = -0.08 }, fg = { from = 'Normal', attr = 'bg', alter = 1.20 } } },
    { FloatTitle = { bold = true, fg = 'white', bg = { from = 'FloatBorder' } } },
    { Folded = { bg = { from = 'Normal', alter = 0.30 } } },
    { QuickFixLine = { link = 'Visual' } },
    { diffAdded = { fg = 'none', bg = hl.blend({ bg_color, P.green }, -0.25), reverse = false } },
    { diffChanged = { fg = 'none', bg = hl.blend({ bg_color, P.light_yellow }, -0.25), reverse = false } },
    { diffRemoved = { fg = 'none', bg = hl.blend({ bg_color, P.pale_red }, -0.25), reverse = false } },
    { diffBDiffer = { link = 'WarningMsg' } },
    { diffCommon = { link = 'WarningMsg' } },
    { diffDiffer = { link = 'WarningMsg' } },
    { diffFile = { link = 'Directory' } },
    { diffIdentical = { link = 'WarningMsg' } },
    { diffIndexLine = { link = 'Number' } },
    { diffIsA = { link = 'WarningMsg' } },
    { diffNoEOL = { link = 'WarningMsg' } },
    { diffOnly = { link = 'WarningMsg' } },
    { DevIconDefault = { fg = { from = 'LineNr', alter = 0.24 } } },
    { DiagnosticError = { fg = P.pale_red } },
    { DiagnosticWarn = { fg = P.light_yellow } },
    { DiagnosticInfo = { fg = P.pale_blue } },
    { DiagnosticSignInfo = { fg = P.pale_red } },
    { agnosticSignWarn = { fg = P.light_yellow } },
    { DiagnosticVirtualTextWarn = { fg = P.light_yellow } },
    { DiagnosticUnderlineWarn = { sp = P.light_yellow } },
    { DiagnosticUnderlineInfo = { fg = P.light_yellow } },
    { DiagnosticHint = { fg = P.pale_red } },
    { AerialFunctionIcon = { bg = { from = 'Normal', alter = -0.30 }, fg = P.light_gray } },
    { AerialNormal = { bg = { from = 'Normal', alter = -0.30 } } },
    { Comment = { italic = true, fg = { from = 'LineNr', alter = -0.15 } } },
    { ['@comment'] = { link = 'Comment' } },
    { ['@variable'] = { clear = true } },
    { ['@spell'] = { clear = true } },
    { ['@norglist'] = { fg = { from = 'Comment' } } },
    { DevIconYarn = { fg = '#2F2963' } },
    { MiniIconsAzure = { fg = { from = 'Function' } } },
    { MiniIconsBlue = { fg = { from = 'DiagnosticInfo' } } },
    { MiniIconsCyan = { fg = { from = 'DiagnosticHint' } } },
    { MiniIconsGreen = { fg = { from = 'DiagnosticOk' } } },
    { MiniIconsGrey = { fg = { from = 'Whitespace' } } },
    { MiniIconsOrange = { fg = { from = 'DiagnosticWarn' } } },
    { MiniIconsPurple = { fg = { from = 'Constant' } } },
    { MiniIconsRed = { fg = { from = 'DiagnosticError' } } },
    { MiniIconsYellow = { fg = { from = 'DiagnosticWarn' } } },

    { BlinkCmpKind = {
      fg = P.light_gray,
      bg = vivid_blend_hsl(P.light_gray, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindText = {
      fg = P.pale_blue,
      bg = vivid_blend_hsl(P.pale_blue, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindMethod = {
      fg = P.light_yellow,
      bg = vivid_blend_hsl(P.light_yellow, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindFunction = {
      fg = P.light_yellow,
      bg = vivid_blend_hsl(P.light_yellow, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindConstructor = {
      fg = P.light_yellow,
      bg = vivid_blend_hsl(P.light_yellow, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindField = {
      fg = P.pale_red,
      bg = vivid_blend_hsl(P.pale_red, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindVariable = {
      fg = P.pale_red,
      bg = vivid_blend_hsl(P.pale_red, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindClass = {
      fg = P.accent,
      bg = vivid_blend_hsl(P.accent, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindInterface = {
      fg = P.accent,
      bg = vivid_blend_hsl(P.accent, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindModule = {
      fg = P.pale_blue,
      bg = vivid_blend_hsl(P.pale_blue, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindProperty = {
      fg = P.pale_red,
      bg = vivid_blend_hsl(P.pale_red, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindUnit = {
      fg = P.light_gray,
      bg = vivid_blend_hsl(P.light_gray, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindValue = {
      fg = P.green,
      bg = vivid_blend_hsl(P.green, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindEnum = {
      fg = P.accent,
      bg = vivid_blend_hsl(P.accent, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindKeyword = {
      fg = P.pale_red,
      bg = vivid_blend_hsl(P.pale_red, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindSnippet = {
      fg = P.light_gray,
      bg = vivid_blend_hsl(P.light_gray, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindColor = {
      fg = P.green,
      bg = vivid_blend_hsl(P.green, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindFile = {
      fg = P.pale_blue,
      bg = vivid_blend_hsl(P.pale_blue, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindReference = {
      fg = P.pale_red,
      bg = vivid_blend_hsl(P.pale_red, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindFolder = {
      fg = P.pale_blue,
      bg = vivid_blend_hsl(P.pale_blue, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindEnumMember = {
      fg = P.accent,
      bg = vivid_blend_hsl(P.accent, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindConstant = {
      fg = P.green,
      bg = vivid_blend_hsl(P.green, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindStruct = {
      fg = P.accent,
      bg = vivid_blend_hsl(P.accent, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindEvent = {
      fg = P.light_yellow,
      bg = vivid_blend_hsl(P.light_yellow, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindOperator = {
      fg = P.pale_red,
      bg = vivid_blend_hsl(P.pale_red, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindTypeParameter = {
      fg = P.accent,
      bg = vivid_blend_hsl(P.accent, P.normal.bg, 0.25, 1.7),
    } },
    { BlinkCmpKindCopilot = {
      fg = P.light_gray,
      bg = vivid_blend_hsl(P.light_gray, P.normal.bg, 0.25, 1.7),
    } },
  })
end

ky.augroup('kyza/highlights', {
  event = 'ColorScheme',
  command = function()
    general_overrides()
    set_sidebar_highlight()
    local ok, icons = pcall(require, 'nvim-web-devicons')
    if not ok then return false, icons.refresh() end
  end,
}, {
  event = 'FileType',
  pattern = sidebar_fts,
  command = function() on_sidebar_enter() end,
})
