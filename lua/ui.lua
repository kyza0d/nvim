ky.ui.palette = {
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
}

local P = ky.ui.palette

ky.ui.notify = {
  bg = { bg = { from = 'Normal', alter = 0.25 } },
  fg = { fg = { from = 'Normal', alter = -0.10 } },
}

ky.ui.modes = {
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
}

ky.ui.border = {
  padded = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
  single = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  solid = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
  top = { ' ', ' ', ' ', '', '', '', '', '' },
}

ky.ui.notify.border = {
  error = { bg = ky.ui.notify.bg, fg = P.pale_red },
  warn = { bg = ky.ui.notify.bg, fg = P.light_yellow },
  info = { bg = ky.ui.notify.bg, fg = P.dark_blue },
  debug = { bg = ky.ui.notify.bg, fg = P.dark_blue },
  trace = { bg = ky.ui.notify.bg, fg = P.dark_blue },
}

ky.ui.lsp = {
  colors = {
    error = ky.ui.palette.pale_red,
    warn = ky.ui.palette.light_yellow,
    hint = ky.ui.palette.bright_blue,
    info = ky.ui.palette.teal,
  },
}

ky.ui.groups = {
  ['default'] = {
    opts = {
      shiftwidth = 2,
      laststatus = 2,
      tabstop = 2,
      expandtab = true,
      number = true,
      signcolumn = 'yes',
    },
  },
  ['notes'] = {
    on_enter = function() vim.opt_local.commentstring = '# %s' end,
    on_exit = function() vim.opt_local.commentstring = nil end,
    highlights = {
      { Normal = { bg = { from = 'Normal', alter = -0.12 } } },
    },
    opts = {
      number = false,
      laststatus = 0,
      statuscolumn = '',
      signcolumn = 'no',
    },
  },
  ['config'] = {
    on_enter = function() vim.opt_local.commentstring = '# %s' end,
    on_exit = function() vim.opt_local.commentstring = nil end,
    highlights = {
      { Cursor = { bg = P.accent, reverse = false } },
      { iCursor = { bg = P.accent, reverse = false } },
    },
    opts = {
      shiftwidth = 4,
      tabstop = 4,
    },
  },
  ['coding'] = {
    on_enter = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
    end,
    on_exit = function()
      vim.opt_local.shiftwidth = nil
      vim.opt_local.tabstop = nil
    end,
  },
  ['panel'] = {
    highlights = {
      { Normal = { bg = { from = 'Normal', alter = -0.08 } } },
    },
    opts = {
      number = false,
    },
  },
  ['term'] = {
    on_enter = function() vim.opt_local.laststatus = 3 end,
    on_exit = function() vim.opt_local.laststatus = 2 end,
    highlights = {
      { Normal = { bg = { from = 'Normal', alter = -0.15 } } },
    },
  },
}
