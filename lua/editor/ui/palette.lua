local palette = {
  background = '#0d0f12',
  accent = '#4b92d8',
  green = '#aec795',
  dark_green = '#10B981',
  blue = '#82AAFE',
  dark_blue = '#4e88ff',
  bright_blue = '#51afef',
  pale_blue = '#95aec7',
  pale_orange = '#c7ae95',
  teal = '#15AABF',
  pale_pink = '#ae95c7',
  magenta = '#c678dd',
  pale_red = '#c795ae',
  light_red = '#c3707a',
  dark_red = '#be5046',
  dark_orange = '#FF922B',
  bright_yellow = '#FAB005',
  light_yellow = '#e5c07b',
  whitesmoke = '#9E9E9E',
  light_gray = '#626262',
  comment_grey = '#5c6370',
  grey = '#3E4556',

  hls = {
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
  },
}

ky.ui = {
  notify = {
    bg = { bg = { from = 'Background', alter = 0.25 } },
    fg = { fg = { from = 'Background', alter = -0.10 } },
    border = {
      error = { bg = { bg = { from = 'Background', alter = 0.25 } }, fg = palette.pale_red },
      warn = { bg = { bg = { from = 'Background', alter = 0.25 } }, fg = palette.light_yellow },
      info = { bg = { bg = { from = 'Background', alter = 0.25 } }, fg = palette.dark_blue },
      debug = { bg = { bg = { from = 'Background', alter = 0.25 } }, fg = palette.dark_blue },
      trace = { bg = { bg = { from = 'Background', alter = 0.25 } }, fg = palette.dark_blue },
    },
  },
  modes = {
    ['n'] = 'NORMAL',
    ['no'] = 'N·OPERATOR PENDING',
    ['nov'] = 'N·OPERATOR BLOCK',
    ['noV'] = 'N·OPERATOR LINE',
    ['niI'] = 'N·INSERT',
    ['niR'] = 'N·REPLACE',
    ['niV'] = 'N·VISUAL',
    ['v'] = 'VISUAL',
    ['V'] = 'V·LINE',
    [''] = 'V·BLOCK',
    ['s'] = 'SELECT',
    ['S'] = 'S·LINE',
    [''] = 'S·BLOCK',
    ['i'] = 'INSERT',
    ['R'] = 'REPLACE',
    ['Rv'] = 'V·REPLACE',
    ['Rx'] = 'C·REPLACE',
    ['Rc'] = 'C·REPLACE',
    ['c'] = 'COMMAND',
    ['cv'] = 'VIM EX',
    ['ce'] = 'EX',
    ['r'] = 'PROMPT',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!'] = 'SHELL',
    ['t'] = 'TERMINAL',
    ['nt'] = 'TERMINAL',
    ['null'] = 'NONE',
  },
  border = {
    padded = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    single = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    solid = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    top = { ' ', ' ', ' ', '', '', '', '', '' },
    none = { '', '', '', '', '', '', '', '' },
  },
  lsp = {
    colors = {
      error = palette.pale_red,
      warn = palette.light_yellow,
      hint = palette.bright_blue,
      info = palette.teal,
    },
  },
}

local lsp = ky.ui.lsp

function palette.setup()
  local warning_fg = lsp.colors.warn
  local error_color = lsp.colors.error

  local normal_fg = hl.get('Background', 'fg')
  local normal_bg = hl.get('Background', 'bg')

  local is_light = vim.o.background == 'light'

  local bg_tint = is_light and -0.10 or 0.60
  local bg_tint_strong = is_light and -0.20 or 0.40

  local bg_color = hl.tint(normal_bg, bg_tint)
  local bg_color_strong = hl.tint(normal_bg, bg_tint_strong)

  local dimmed_alter = is_light and -0.40 or 0.20
  local dir_path_alter = is_light and 0.20 or -0.15

  local mode_colors = {
    normal = is_light and palette.dark_purple or palette.accent,
    insert = is_light and palette.blue or palette.dark_blue,
    visual = is_light and palette.green or palette.dark_green,
    replace = is_light and palette.red or palette.dark_red,
    command = is_light and palette.orange or palette.light_yellow,
    select = is_light and palette.dark_teal or palette.teal,
  }

  hl.all({
    { [palette.hls.normal] = { fg = normal_fg, bg = { from = 'Background' } } },
    { [palette.hls.title] = { bg = bg_color, fg = normal_fg, reverse = false } },

    { [palette.hls.statusline] = { bg = bg_color, fg = normal_fg, reverse = false } },
    { [palette.hls.statusline_nc] = { bg = bg_color, fg = normal_fg, reverse = false } },
    { [palette.hls.statusline_icon] = { bg = bg_color, fg = hl.get('Macro', 'fg'), reverse = false } },

    { [palette.hls.dimmed] = { bg = bg_color, fg = { from = 'LineNr', alter = dimmed_alter } } },

    { [palette.hls.indicator] = { bg = bg_color_strong, fg = palette.dark_blue, reverse = false } },

    { [palette.hls.mode_normal] = { bg = bg_color, fg = mode_colors.normal, bold = true } },
    { [palette.hls.mode_insert] = { bg = bg_color, fg = mode_colors.insert, bold = true } },
    { [palette.hls.mode_visual] = { bg = bg_color, fg = mode_colors.visual, bold = true } },
    { [palette.hls.mode_replace] = { bg = bg_color, fg = mode_colors.replace, bold = true } },
    { [palette.hls.mode_command] = { bg = bg_color, fg = mode_colors.command, bold = true } },
    { [palette.hls.mode_select] = { bg = bg_color, fg = mode_colors.select, bold = true } },

    { [palette.hls.dir_path] = { bg = bg_color, fg = { from = 'Comment', alter = dir_path_alter } } },
    { [palette.hls.dir_file] = { bg = bg_color, fg = palette.dimmed, bold = true } },
    { [palette.hls.dir_parent] = { bg = bg_color, fg = is_light and palette.dark_purple or palette.pale_pink, bold = true } },

    { [palette.hls.lsp_info] = { fg = { from = 'Comment', alter = is_light and -0.20 or 0.15 }, bg = bg_color, bold = true } },
    { [palette.hls.lsp_warn] = { fg = warning_fg, bg = bg_color } },
    { [palette.hls.lsp_err] = { fg = error_color, bg = bg_color } },

    { [palette.hls.git_add] = { fg = is_light and palette.dark_green or palette.green, bg = bg_color } },
    { [palette.hls.git_rm] = { fg = is_light and palette.red or palette.pale_red, bg = bg_color } },
    { [palette.hls.git_mod] = { fg = is_light and palette.orange or palette.light_yellow, bg = bg_color } },

    { [palette.hls.modified] = { fg = is_light and palette.orange or palette.light_yellow, bg = bg_color } },
    { [palette.hls.recording] = { fg = is_light and palette.dark_green or palette.green, bg = bg_color } },

    { [palette.hls.neotree] = { fg = normal_fg, bg = { from = 'Background', alter = 0.85 } } },
    { [palette.hls.neotree_icon] = { bg = { from = 'Background', alter = 0.85 }, fg = palette.dark_red } },

    { [palette.hls.terminal] = { fg = normal_fg, bg = { from = 'PanelBackground' } } },
    { [palette.hls.terminal_icon] = { fg = is_light and palette.green or palette.dark_green, bg = { from = 'PanelBackground' } } },

    { [palette.hls.error] = { fg = error_color, bg = bg_color, bold = true } },
  })
end

return palette
