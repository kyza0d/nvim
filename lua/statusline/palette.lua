local M = {}

local hl, P, lsp = ky.hl, ky.ui.palette, ky.ui.lsp

M.hls = {
  normal = 'StNormal',
  indicator = 'StIndicator',
  title = 'StTitle',
  statusline = 'StatusLine',
  statusline_nc = 'StatusLineNC',
  statusline_icon = 'StatusLineIcon',
  panel_st = 'PanelSt',
  panel_st_icon = 'StPanelIcon',
  dimmed = 'StDimmed',
  dir_path = 'StDirectory',
  dir_file = 'StDirectoryFile',
  dir_parent = 'StParentDirectory',
  lsp_info = 'StInfo',
  lsp_warn = 'StWarn',
  lsp_err = 'StError',
  mode_normal = 'StModeNormal',
  mode_insert = 'StModeInsert',
  mode_visual = 'StModeVisual',
  mode_replace = 'StModeReplace',
  mode_command = 'StModeCommand',
  mode_select = 'StModeSelect',
  git_add = 'StGitAdd',
  git_rm = 'StGitRemove',
  git_mod = 'StGitMod',
  modified = 'StModified',
  recording = 'StRecording',
  neotree = 'StNeoTree',
  neotree_icon = 'StNeoTreeIcon',
  terminal = 'StTerminal',
  terminal_icon = 'StTerminalIcon',
  error = 'StError',
}

function M.setup()
  local warning_fg = lsp.colors.warn
  local error_color = lsp.colors.error

  local normal_fg = hl.get('Normal', 'fg')
  local normal_bg = hl.get('Normal', 'bg')

  local bg_color = hl.tint(normal_bg, 0.60)
  local bg_color_200 = hl.tint(normal_bg, 0.40)

  hl.all({
    { [M.hls.normal] = { fg = normal_fg, bg = { from = 'Normal' } } },
    { [M.hls.title] = { bg = bg_color, fg = normal_fg, reverse = false } },
    { [M.hls.statusline] = { bg = bg_color, fg = normal_fg, reverse = false } },
    { [M.hls.statusline_nc] = { bg = bg_color, fg = normal_fg, reverse = false } },
    { [M.hls.statusline_icon] = { bg = bg_color, fg = hl.get('Macro', 'fg'), reverse = false } },
    { [M.hls.dimmed] = { bg = bg_color, fg = { from = 'LineNr', alter = 0.20 } } },
    { [M.hls.indicator] = { bg = bg_color_200, fg = P.dark_blue, reverse = false } },
    { [M.hls.mode_normal] = { bg = bg_color, fg = P.pale_pink, bold = true } },
    { [M.hls.mode_insert] = { bg = bg_color, fg = P.dark_blue, bold = true } },
    { [M.hls.mode_visual] = { bg = bg_color, fg = P.dark_green, bold = true } },
    { [M.hls.mode_replace] = { bg = bg_color, fg = P.dark_red, bold = true } },
    { [M.hls.mode_command] = { bg = bg_color, fg = P.light_yellow, bold = true } },
    { [M.hls.mode_select] = { bg = bg_color, fg = P.teal, bold = true } },

    { [M.hls.dir_path] = { bg = bg_color, fg = { from = 'Comment', alter = -0.15 } } },
    { [M.hls.dir_file] = { bg = bg_color, fg = P.dimmed, bold = true } },
    { [M.hls.dir_parent] = { bg = bg_color, fg = P.pale_pink, bold = true } },

    { [M.hls.lsp_info] = { fg = { from = 'Comment', alter = 0.15 }, bg = bg_color, bold = true } },
    { [M.hls.lsp_warn] = { fg = warning_fg, bg = bg_color } },
    { [M.hls.lsp_err] = { fg = error_color, bg = bg_color } },
    { [M.hls.git_add] = { fg = P.green, bg = bg_color } },
    { [M.hls.git_rm] = { fg = P.pale_red, bg = bg_color } },
    { [M.hls.git_mod] = { fg = P.light_yellow, bg = bg_color } },
    { [M.hls.modified] = { fg = P.light_yellow, bg = bg_color } },
    { [M.hls.recording] = { fg = P.green, bg = bg_color } },
    { [M.hls.neotree] = { fg = normal_fg, bg = { from = 'Normal', alter = -0.15 } } },
    { [M.hls.neotree_icon] = { fg = P.dark_green, bg = { from = 'Normal', alter = -0.15 } } },
    { [M.hls.terminal] = { fg = normal_fg, bg = { from = 'Normal', alter = -0.30 } } },
    { [M.hls.terminal_icon] = { fg = P.dark_green, bg = { from = 'Normal', alter = -0.30 } } },
    { [M.hls.error] = { fg = error_color, bg = bg_color, bold = true } },
  })
end

return M
