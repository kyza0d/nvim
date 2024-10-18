if not ky then return end

local hl, P = ky.hl, ky.ui.palette

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

local sidebar_fts = { 'Avante', 'AvanteInput' }

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
    -- [ Editor Overrides ] ------------------------------
    { Cursor = { bg = P.accent, reverse = false } },
    { iCursor = { bg = P.accent, reverse = false } },
    { lCursor = { bg = P.accent, reverse = false } },
    { vCursor = { bg = P.accent, reverse = false } },
    { tCursor = { bg = P.accent, reverse = false } },

    -- Editor Foreground Element
    { Directory = { fg = { from = 'Normal', alter = -0.45 } } },

    -- [ Searching ] ------------------------------------
    { Search = { clear = true, bg = accent_50 } },
    { CurSearch = { clear = true, bg = accent_80 } },
    { IncSearch = { clear = true, bg = accent_50 } },
    { Visual = { bg = accent_50 } },

    { LineNr = { fg = { from = 'Normal', attr = 'fg', alter = -0.50 }, bg = 'none' } },
    { WinSeparator = { fg = { from = 'Normal', attr = 'bg', alter = 0.80 } } },

    { SignColumn = { bg = 'none' } },
    { FoldStatus = { fg = { from = 'LineNr' } } },
    { EndOfBuffer = { bg = 'none' } },

    -- [ Terminal ] -------------------------------
    { Term = { bg = { from = 'Normal', alter = -0.25 } } },
    { TermBorder = { bg = { from = 'Normal', alter = -0.25 }, fg = { from = 'Whitespace' } } },

    -- [ Completion Menu ] -------------------------------
    { Pmenu = { bg = { from = 'Normal', alter = -0.35 }, fg = 'none' } },
    { PmenuSel = { bg = { from = 'Pmenu', alter = 0.85 }, fg = 'none', bold = false } },

    { CursorLine = { bg = { from = 'Normal' } } },
    { CursorLineNr = { bg = { from = 'Normal', alter = 0.30 }, fg = { from = 'Identifier' } } },
    { CursorLineFold = { clear = true } },
    { CursorLineSign = { clear = true } },

    { NormalFloat = { bg = { from = 'Normal', alter = -0.12 } } },
    { TelescopeNormal = { bg = { from = 'Normal', alter = 0.15 }, fg = { from = 'Normal', alter = -0.20 } } },
    { TelescopePromptNormal = { bg = { from = 'Normal', alter = 0.15 } } },
    { TelescopeResultsNormal = { bg = { from = 'Normal', alter = 0.15 }, blend = 0 } },
    { TelescopePreviewNormal = { bg = { from = 'Normal', alter = 0.20 }, blend = 0 } },
    { TelescopeResultsBorder = { bg = { from = 'Normal', alter = 0.15 }, blend = 0 } },
    { TelescopePromptBorder = { bg = { from = 'Normal', alter = 0.15 }, blend = 0 } },
    { TelescopePreviewBorder = { bg = { from = 'Normal', alter = 0.20 }, blend = 0 } },
    { TelescopePreviewTitle = { bg = { from = 'Normal', alter = 0.20 } } },
    { TelescopeSelection = { bg = { from = 'Normal', alter = 0.20 }, blend = 0 } },
    { FloatBorder = { bg = { from = 'Normal', alter = -0.08 }, fg = { from = 'Normal', attr = 'bg', alter = 1.20 } } },
    { FloatTitle = { bold = true, fg = 'white', bg = { from = 'FloatBorder' } } },

    -- [ Folding ] ---------------------------------------
    { Folded = { bg = { from = 'Normal', alter = 0.30 } } },

    -- [ Indent Blankline ] ------------------------------
    { IblIndent = { bg = 'none', fg = { from = 'Normal', attr = 'bg', alter = 0.10 } } },
    { IblScope = { bg = 'none', fg = { from = 'Normal', attr = 'bg', alter = 1.60 } } },

    { QuickFixLine = { link = 'Visual' } },

    -- [ Diff ] ------------------------------------------
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

    -- [ Diagnostics ] ------------------------------
    { DiagnosticError = { fg = P.pale_red } },
    { DiagnosticWarn = { fg = P.light_yellow } },
    { DiagnosticInfo = { fg = P.pale_blue } },
    { DiagnosticSignInfo = { fg = P.pale_red } },
    { agnosticSignWarn = { fg = P.light_yellow } },
    { DiagnosticVirtualTextWarn = { fg = P.light_yellow } },
    { DiagnosticUnderlineWarn = { sp = P.light_yellow } },
    { DiagnosticUnderlineInfo = { fg = P.light_yellow } },
    { DiagnosticHint = { fg = P.pale_red } },

    -- [ Aerial ] ------------------------------------
    { AerialFunctionIcon = { bg = { from = 'Normal', alter = -0.30 }, fg = P.light_gray } },
    { AerialNormal = { bg = { from = 'Normal', alter = -0.30 } } },

    -- [ Treesitter ] ------------------------------------
    { Comment = { italic = true, fg = { from = 'LineNr', alter = -0.15 } } },
    { ['@comment'] = { link = 'Comment' } },
    { ['@variable'] = { clear = true } },
    { ['@spell'] = { clear = true } },

    -- [ Norg ] ------------------------------------
    { ['@norglist'] = { fg = { from = 'Comment' } } },

    -- [ Bqf ] ------------------------------------
    { BqfPreviewFloat = { bg = { from = 'Normal' } } },
    { BqfPreviewBorder = { bg = { from = 'Normal' } } },
    { BqfPreviewCursorLine = { bg = { from = 'Normal' } } },
    { BqfPreviewRange = { bg = { from = 'Normal' } } },

    -- [ DevIcon ] ------------------------------------
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
  })
end

local fn, api = vim.fn, vim.api
local original_color

local function exec_kitty(cmd, on_error, on_stdout)
  fn.jobstart(cmd, {
    on_stderr = function(_, d)
      if #d > 1 then on_error() end
    end,
    on_stdout = on_stdout,
  })
end

local function get_kitty_background()
  if not original_color then
    exec_kitty(
      { 'kitty', '@', 'get-colors' },
      function() api.nvim_err_writeln('Error getting background. Ensure kitty remote control is on.') end,
      function(_, d)
        for _, result in ipairs(d) do
          if result:match('^background') then
            original_color = vim.split(result, '%s+')[2]
            break
          end
        end
      end
    )
  end
end

local function update_background(color, sync)
  local command = fmt('kitty @ set-colors background="%s"', color)
  if sync then
    fn.system(command)
  else
    exec_kitty(command, function() api.nvim_err_writeln('Error changing background. Ensure kitty remote control is on.') end)
  end
end

ky.augroup('kyza/highlights', {
  event = 'ColorScheme',
  command = function()
    general_overrides()
    set_sidebar_highlight()
    if vim.g.background == 'light' then update_background(original_color, true) end
    if not vim.g.neovide then get_kitty_background() end
    local ok, icons = pcall(require, 'nvim-web-devicons')
    if not ok then return false, icons.refresh() end
  end,
}, {
  event = 'FileType',
  pattern = sidebar_fts,
  command = function() on_sidebar_enter() end,
})
