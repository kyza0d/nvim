if not ky then return end

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

local sidebar_fts = {
  'Avante',
  'AvanteInput',
  'AvanteSelectedFiles',
  'Trouble',
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
  local normal_bg = hl.get('Normal', 'bg')
  local bg_color = hl.tint(normal_bg, -0.25)

  local accent = palette.accent
  local accent_50 = hl.blend({ accent, hl.get('Normal', 'bg') }, -0.2)
  local accent_80 = hl.blend({ accent, hl.get('Normal', 'bg') }, -0.1)

  hl.all({
    { Cursor = { bg = palette.accent, reverse = false } },
    { iCursor = { bg = palette.accent, reverse = false } },
    { lCursor = { bg = palette.accent, reverse = false } },
    { vCursor = { bg = palette.accent, reverse = false } },
    { tCursor = { bg = palette.accent, reverse = false } },
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
    { WinBar = { bg = { from = 'Normal' }, fg = { from = 'LineNr' }, bold = false } },
    { WinBarNC = { inherit = 'WinBar' } },
    { NormalFloat = { bg = { from = 'Normal', alter = -0.12 } } },
    { NotifyNormal = { bg = 'none' } },
    { FloatBorder = { bg = { from = 'Normal', alter = -0.12 }, fg = { from = 'Normal', attr = 'bg', alter = 1.20 } } },
    { FloatTitle = { bold = true, fg = { from = 'WinBar' }, bg = { from = 'FloatBorder' } } },
    { Folded = { bg = { from = 'Normal', alter = 0.30 } } },
    { QuickFixLine = { link = 'Visual' } },
    { diffAdded = { fg = 'none', bg = hl.blend({ bg_color, palette.green }, -0.25), reverse = false } },
    { diffChanged = { fg = 'none', bg = hl.blend({ bg_color, palette.light_yellow }, -0.25), reverse = false } },
    { diffRemoved = { fg = 'none', bg = hl.blend({ bg_color, palette.pale_red }, -0.25), reverse = false } },
    { diffBDiffer = { link = 'WarningMsg' } },
    { diffCommon = { link = 'WarningMsg' } },
    { diffDiffer = { link = 'WarningMsg' } },
    { diffFile = { link = 'Directory' } },
    { diffIdentical = { link = 'WarningMsg' } },
    { diffIndexLine = { link = 'Number' } },
    { diffIsA = { link = 'WarningMsg' } },
    { diffNoEOL = { link = 'WarningMsg' } },
    { diffOnly = { link = 'WarningMsg' } },
    { DiffAdd = { inherit = 'diffAdded' } },
    { DevIconDefault = { fg = { from = 'LineNr', alter = 0.24 } } },
    { DiagnosticError = { fg = palette.pale_red } },
    { DiagnosticWarn = { fg = palette.light_yellow } },
    { DiagnosticInfo = { fg = palette.pale_blue } },
    { DiagnosticSignInfo = { fg = palette.pale_red } },
    { agnosticSignWarn = { fg = palette.light_yellow } },
    { DiagnosticVirtualTextWarn = { fg = palette.light_yellow } },
    { DiagnosticUnderlineWarn = { sp = palette.light_yellow } },
    { DiagnosticUnderlineInfo = { fg = palette.light_yellow } },
    { DiagnosticHint = { fg = palette.pale_red } },
    { AerialFunctionIcon = { bg = { from = 'Normal', alter = -0.30 }, fg = palette.light_gray } },
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
    { TreeSitterContext = { fg = '#555555', bg = 'none', sp = '#cccccc', underline = true } },

    {
      BlinkCmpKind = {
        fg = palette.light_gray,
        -- bg = vivid_blend_hsl(P.light_gray, P.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindText = {
        fg = palette.pale_blue,
        -- bg = vivid_blend_hsl(P.pale_blue, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindMethod = {
        fg = palette.green,
        -- bg = vivid_blend_hsl(palette.green, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindFunction = {
        fg = palette.magenta,
        -- bg = vivid_blend_hsl(palette.magenta, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindConstructor = {
        fg = palette.light_yellow,
        -- bg = vivid_blend_hsl(palette.light_yellow, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindField = {
        fg = palette.pale_red,
        -- bg = vivid_blend_hsl(palette.pale_red, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindVariable = {
        fg = palette.pale_red,
        -- bg = vivid_blend_hsl(palette.pale_red, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindClass = {
        fg = palette.accent,
        -- bg = vivid_blend_hsl(palette.accent, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindInterface = {
        fg = palette.accent,
        -- bg = vivid_blend_hsl(palette.accent, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindModule = {
        fg = palette.pale_blue,
        -- bg = vivid_blend_hsl(palette.pale_blue, palette.normal.bg, 0.25, 1.7),
      },
    },

    {
      BlinkCmpKindpaletteroperty = {
        fg = palette.pale_red,
        -- bg = vivid_blend_hsl(palette.pale_red, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindUnit = {
        fg = palette.light_gray,
        -- bg = vivid_blend_hsl(palette.light_gray, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindValue = {
        fg = palette.green,
        -- bg = vivid_blend_hsl(palette.green, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindEnum = {
        fg = palette.accent,
        -- bg = vivid_blend_hsl(palette.accent, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindKeyword = {
        fg = palette.blue,
        -- bg = vivid_blend_hsl(palette.blue, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindSnippet = {
        fg = palette.pale_orange,
        -- bg = vivid_blend_hsl(palette.pale_orange, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindColor = {
        fg = palette.green,
        -- bg = vivid_blend_hsl(palette.green, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindFile = {
        fg = palette.pale_blue,
        -- bg = vivid_blend_hsl(palette.pale_blue, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindReference = {
        fg = palette.pale_red,
        -- bg = vivid_blend_hsl(palette.pale_red, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindFolder = {
        fg = palette.pale_blue,
        -- bg = vivid_blend_hsl(palette.pale_blue, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindEnumMember = {
        fg = palette.accent,
        -- bg = vivid_blend_hsl(palette.accent, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindConstant = {
        fg = palette.green,
        -- bg = vivid_blend_hsl(palette.green, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindStruct = {
        fg = palette.accent,
        -- bg = vivid_blend_hsl(palette.accent, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindEvent = {
        fg = palette.light_yellow,
        -- bg = vivid_blend_hsl(palette.light_yellow, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindOperator = {
        fg = palette.pale_red,
        -- bg = vivid_blend_hsl(palette.pale_red, palette.normal.bg, 0.25, 1.7),
      },
    },
    {
      BlinkCmpKindTypepalettearameter = {
        fg = palette.accent,
        -- bg = vivid_blend_hsl(palette.accent, palette.normal.bg, 0.25, 1.7),
      },
    },
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
