if not ky then return end

local function set_sidebar_highlight()
  hl.all({
    { PanelDarkBackground = { bg = { from = 'Background', alter = -0.12 } } },
    { PanelDarkHeading = { inherit = 'PanelDarkBackground', bold = true } },
    { PanelBackground = { bg = { from = 'Background', alter = -0.12 } } },
    { PanelHeading = { inherit = 'PanelBackground', bold = true } },
    { PanelWinSeparator = { inherit = 'PanelBackground', fg = { from = 'WinSeparator' } } },
    { PanelStNC = { link = 'PanelWinSeparator' } },
    { PanelSt = { bg = { from = 'Background', alter = -0.12 } } },
  })
end

local sidebar_fts = {
  'toggleterm',
  'codecompanion',
}

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
  hl.set('Background', { bg = '#111111', fg = '#cccccc' })

  local normal_bg = hl.get('Background', 'bg')
  local bg_color = hl.tint(normal_bg, -0.25)

  local accent = palette.accent

  local accent_50 = hl.blend({ accent, hl.get('Background', 'bg') }, -0.2)
  local accent_80 = hl.blend({ accent, hl.get('Background', 'bg') }, -0.1)

  hl.all({
    { Normal = { bg = { from = 'Background' } } },
    { Normal = { bg = 'none' } },
    { NormalNC = { bg = 'none' } },

    { NormalFzf = { bg = { from = 'Background', alter = 0.20 }, fg = { from = 'Background', alter = -0.15 } } },
    { PmenuSelFzf = { bg = { from = 'Pmenu', alter = -0.15 }, fg = { from = 'Background', alter = 0.50 }, bold = false } },

    { NormalFloat = { bg = { from = 'Background', alter = 0.20 }, fg = { from = 'Background', alter = -0.15 } } },

    { TroubleNormal = { link = 'Background' } },
    { TroubleFile = { fg = { from = 'Function' }, bg = 'none' } },
    { TroubleSignOther = { fg = { from = 'Special' }, bg = 'none' } },
    { TroubleInformation = { fg = { from = 'Special' }, bg = 'none' } },

    { Cursor = { bg = palette.accent, reverse = false } },

    { Directory = { fg = { from = 'Background', alter = -0.45 } } },
    { Search = { clear = true, bg = accent_50 } },
    { CurSearch = { clear = true, bg = accent_80 } },
    { IncSearch = { clear = true, bg = accent_50 } },
    { Visual = { bg = accent_50 } },

    { LineNr = { fg = { from = 'Background', attr = 'fg', alter = -0.50 }, bg = 'none' } },

    { IndentLine = { fg = { from = 'Background', attr = 'fg', alter = -0.80 }, bg = 'none' } },
    { WinSeparator = { fg = { from = 'Background', attr = 'bg', alter = 1.5 } } },

    { SignColumn = { bg = 'none' } },
    { EndOfBuffer = { bg = 'none' } },

    { Term = { bg = { from = 'Background', alter = -0.25 } } },
    { TermBorder = { bg = { from = 'Background', alter = -0.25 } } },

    { Pmenu = { bg = { from = 'Background', alter = 1.25 }, fg = 'none' } },
    { PmenuSel = { bg = { from = 'Pmenu', alter = 0.50 }, fg = 'none', bold = false } },

    { CursorLine = { bg = { from = 'Background', alter = 0.65 } } },
    { CursorLineNr = { bg = { from = 'Background', alter = 0.65 }, fg = { from = 'LineNr' } } },
    { CursorLineFold = { bg = { from = 'Background', alter = 0.65 } } },
    { CursorLineSign = { bg = { from = 'Background', alter = 0.65 } } },
    { CursorLineSignColumn = { bg = { from = 'Background', alter = 0.65 } } },

    { WinBar = { bg = 'none', fg = { from = 'LineNr' }, bold = false } },
    { WinBarNC = { inherit = 'WinBar' } },

    { NotifyBackground = { bg = 'none' } },

    { Folded = { bg = { from = 'Background', alter = 0.30 } } },
    { FoldStatus = { fg = { from = 'LineNr' } } },

    { diffAdded = { fg = 'none', bg = hl.blend({ bg_color, palette.green }, -0.25), reverse = false } },
    { diffChanged = { fg = 'none', bg = hl.blend({ bg_color, palette.light_yellow }, -0.25), reverse = false } },
    { diffRemoved = { fg = 'none', bg = hl.blend({ bg_color, palette.pale_red }, -0.25), reverse = false } },

    { DiagnosticError = { fg = palette.pale_red } },
    { DiagnosticWarn = { fg = palette.light_yellow } },
    { DiagnosticInfo = { fg = palette.pale_blue } },
    { DiagnosticSignInfo = { fg = palette.pale_red } },
    { DiagnosticSignWarn = { fg = palette.light_yellow } },

    { DiagnosticVirtualTextWarn = { fg = palette.light_yellow } },
    { DiagnosticUnderlineWarn = { sp = palette.light_yellow } },
    { DiagnosticUnderlineInfo = { fg = palette.light_yellow } },
    { DiagnosticHint = { fg = palette.pale_red } },

    { Comment = { italic = true, fg = { from = 'LineNr', alter = -0.15 } } },

    { ['@comment'] = { link = 'Comment' } },
    { ['@variable'] = { clear = true } },
    { ['@spell'] = { clear = true } },

    { MiniIconsAzure = { fg = { from = 'Function' } } },
    { MiniIconsBlue = { fg = { from = 'DiagnosticInfo' } } },
    { MiniIconsCyan = { fg = { from = 'DiagnosticHint' } } },
    { MiniIconsGreen = { fg = { from = 'DiagnosticOk' } } },
    { MiniIconsGrey = { fg = { from = 'Whitespace' } } },
    { MiniIconsOrange = { fg = { from = 'DiagnosticWarn' } } },
    { MiniIconsPurple = { fg = { from = 'Constant' } } },
    { MiniIconsRed = { fg = { from = 'DiagnosticError' } } },
    { MiniIconsYellow = { fg = { from = 'DiagnosticWarn' } } },

    { TreeSitterContext = { fg = '#555555', bg = 'none', sp = '#cccccc', underline = true } },

    { BlinkCmpKind = { fg = palette.light_gray } },
    { BlinkCmpKindText = { fg = palette.pale_blue } },
    { BlinkCmpKindMethod = { fg = palette.green } },
    { BlinkCmpKindFunction = { fg = palette.magenta } },
    { BlinkCmpKindConstructor = { fg = palette.light_yellow } },
    { BlinkCmpKindField = { fg = palette.pale_red } },
    { BlinkCmpKindVariable = { fg = palette.pale_red } },
    { BlinkCmpKindClass = { fg = palette.accent } },
    { BlinkCmpKindInterface = { fg = palette.accent } },
    { BlinkCmpKindModule = { fg = palette.pale_blue } },
    { BlinkCmpKindpaletteroperty = { fg = palette.pale_red } },
    { BlinkCmpKindUnit = { fg = palette.light_gray } },
    { BlinkCmpKindValue = { fg = palette.green } },
    { BlinkCmpKindEnum = { fg = palette.accent } },
    { BlinkCmpKindKeyword = { fg = palette.blue } },
    { BlinkCmpKindSnippet = { fg = palette.pale_orange } },
    { BlinkCmpKindColor = { fg = palette.green } },
    { BlinkCmpKindFile = { fg = palette.pale_blue } },
    { BlinkCmpKindReference = { fg = palette.pale_red } },
    { BlinkCmpKindFolder = { fg = palette.pale_blue } },
    { BlinkCmpKindEnumMember = { fg = palette.accent } },
    { BlinkCmpKindConstant = { fg = palette.green } },
    { BlinkCmpKindStruct = { fg = palette.accent } },
    { BlinkCmpKindEvent = { fg = palette.light_yellow } },
    { BlinkCmpKindOperator = { fg = palette.pale_red } },
    { BlinkCmpKindTypepalettearameter = { fg = palette.accent } },
  })
end

augroup('kyza/highlights', {
  event = 'ColorScheme',
  command = function()
    general_overrides()
    set_sidebar_highlight()
  end,
}, {
  event = 'FileType',
  pattern = sidebar_fts,
  command = function() on_sidebar_enter() end,
})
