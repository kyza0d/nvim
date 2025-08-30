local palette = {

  -- Core Colors
  background = '#0d0f12',
  accent = '#e100ff',

  -- Grays & Whites
  whitesmoke = '#9E9E9E',
  light_gray = '#626262',
  gray = '#3E4556',

  -- Reds
  pale_red = '#c795ae',
  light_red = '#c3707a',
  dark_red = '#be5046',
  red = '#FF6347',

  -- Oranges & Yellows
  pale_orange = '#c7ae95',
  dark_orange = '#FF922B',
  light_yellow = '#e5c07b',
  bright_yellow = '#FAB005',
  orange = '#FFA500',

  -- Greens
  green = '#aec795',
  dark_green = '#10B981',

  -- Blues
  blue = '#82AAFE',
  dark_blue = '#4e88ff',
  bright_blue = '#51afef',
  pale_blue = '#95aec7',

  -- Pinks, Magentas & Purples
  pale_pink = '#ae95c7',
  magenta = '#c678dd',
  dark_purple = '#9370DB',

  -- Teals
  teal = '#15AABF',

  -- Highlight group names
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

    trouble = 'StNeoTree',
    trouble_icon = 'StNeoTreeIcon',

    terminal = 'StTerminal',
    terminal_icon = 'StTerminalIcon',

    fzf = 'StFzf',
    fzf_icon = 'StFzfIcon',

    error = 'StError',
  },
}

ky.ui = {
  notify = {
    bg = { bg = { from = 'Background', alter = 0.45 } },
    fg = { fg = { from = 'Background', alter = -0.10 } },
    border = (function()
      local common_border_bg = { bg = { from = 'Background', alter = 0.25 } }
      return {
        error = { bg = common_border_bg, fg = palette.pale_red },
        warn = { bg = common_border_bg, fg = palette.light_yellow },
        info = { bg = common_border_bg, fg = palette.dark_blue },
        debug = { bg = common_border_bg, fg = palette.dark_blue },
        trace = { bg = common_border_bg, fg = palette.dark_blue },
      }
    end)(),
  },
  modes = {
    ['n'] = 'NORMAL',
    ['no'] = 'N·OPERATOR PENDING',
    ['nov'] = 'N·OPERATOR BLOCK',
    ['noV'] = 'N·OPERATOR LINE',
    ['no\22'] = 'N·OPERATOR CHAR',
    ['niI'] = 'N·INSERT',
    ['niR'] = 'N·REPLACE',
    ['niV'] = 'N·VISUAL',
    ['v'] = 'VISUAL',
    ['V'] = 'V·LINE',
    ['\22'] = 'V·BLOCK',
    ['s'] = 'SELECT',
    ['S'] = 'S·LINE',
    ['\19'] = 'S·BLOCK',
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
    solid = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }, -- Note: solid usually implies block chars, this is space
    top = { ' ', ' ', ' ', '', '', '', '', '' }, -- Only top border space?
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

-- Local alias for convenience
local lsp_ui_colors = ky.ui.lsp.colors

-- Enhanced background resolution system for statusline
local function get_statusline_bg(filetype, buftype)
  local xeno = require('xeno').colors

  -- Filetype-specific background overrides
  local ft_backgrounds = {
    ['neo-tree'] = xeno.base_800,
    ['trouble'] = xeno.base_800,
    ['toggleterm'] = xeno.base_800,
    ['fzf'] = xeno.base_700,
    ['qf'] = xeno.base_700,
  }

  -- Return specific background or default
  return ft_backgrounds[filetype] or xeno.base_700
end

-- Dynamic highlight group generator for context-aware highlights
local function create_context_highlights(filetype, buftype, is_active)
  local bg = get_statusline_bg(filetype, buftype)
  local xeno = require('xeno').colors

  -- Base colors adjusted for context
  local fg = is_active and xeno.base_200 or xeno.base_400

  return {
    statusline = { bg = bg, fg = fg },
    title = { bg = bg, fg = xeno.base_100 },
    dimmed = { bg = bg, fg = xeno.base_500 },
    icon = { bg = bg, fg = hl.get('Macro', 'fg') or xeno.accent_500 },
  }
end

-- Store context highlights for dynamic updates
palette.context_highlights = {}

-- Function to get or create context-specific highlights
function palette.get_context_highlights(filetype, buftype, is_active)
  local key = string.format('%s_%s_%s', filetype or 'default', buftype or 'default', is_active and 'active' or 'inactive')

  if not palette.context_highlights[key] then
    palette.context_highlights[key] = create_context_highlights(filetype, buftype, is_active)
  end

  return palette.context_highlights[key]
end

-- Clear context highlight cache when colorscheme changes
function palette.clear_context_cache() palette.context_highlights = {} end

-- In lua/editor/ui/palette.lua, enhance the setup function:

function palette.setup()
  -- Ensure 'hl' and 'vim' are available (typical in Neovim Lua configs)
  if not hl or not vim or not vim.o then
    print("Error: 'hl' or 'vim.o' not available. This setup is likely for Neovim.")
    return
  end

  -- Check if we're in the middle of a colorscheme change
  local is_colorscheme_loading = vim.g.colors_name == nil
  if is_colorscheme_loading then
    -- Defer setup if colorscheme isn't fully loaded yet
    vim.defer_fn(palette.setup, 50)
    return
  end

  -- Determine if we're using a light or dark background
  local is_light_bg = vim.o.background == 'light'

  local xeno = require('xeno').colors

  -- Clear context cache on setup
  palette.clear_context_cache()

  local statusline = {
    bg = xeno.base_700,
    fg = xeno.base_200,
  }

  local warning_fg = lsp_ui_colors.warn
  local error_fg = lsp_ui_colors.error

  local mode_colors = {
    normal = xeno.accent_500,
    insert = palette.dark_blue,
    visual = palette.dark_green,
    replace = palette.dark_red,
    command = palette.light_yellow,
    select = palette.teal,
  }

  -- Store the current highlights for debugging
  vim.g.statusline_palette_applied = true

  -- Apply all highlight groups with error handling
  local success = pcall(function()
    hl.all({
      -- -- Base & General UI
      { [palette.hls.statusline] = { bg = statusline.bg, fg = statusline.fg, reverse = false } },
      { [palette.hls.statusline_nc] = { bg = statusline.bg, fg = statusline.fg, reverse = false } },
      { [palette.hls.statusline_icon] = { bg = statusline.bg, fg = hl.get('Macro', 'fg'), reverse = false } },

      -- Mode indicators in StatusLine
      { [palette.hls.mode_normal] = { bg = statusline.bg, fg = mode_colors.normal, bold = true } },
      { [palette.hls.mode_insert] = { bg = statusline.bg, fg = mode_colors.insert, bold = true } },
      { [palette.hls.mode_visual] = { bg = statusline.bg, fg = mode_colors.visual, bold = true } },
      { [palette.hls.mode_replace] = { bg = statusline.bg, fg = mode_colors.replace, bold = true } },
      { [palette.hls.mode_command] = { bg = statusline.bg, fg = mode_colors.command, bold = true } },
      { [palette.hls.mode_select] = { bg = statusline.bg, fg = mode_colors.select, bold = true } },

      -- Directory and File info in StatusLine/Panels
      {
        [palette.hls.dir_path] = {
          bg = statusline.bg,
          fg = { from = 'Comment', alter = is_light_bg and -0.20 or 0.15 },
          bold = true,
        },
      },
      { [palette.hls.dir_file] = { bg = statusline.bg, fg = xeno.base_300, bold = true } },
      { [palette.hls.dir_parent] = { bg = statusline.bg, fg = xeno.base_300, bold = true } },

      -- LSP indicators in StatusLine
      {
        [palette.hls.lsp_info] = {
          fg = { from = 'Comment', alter = is_light_bg and -0.20 or 0.15 },
          bg = statusline.bg,
          bold = true,
        },
      },
      { [palette.hls.lsp_warn] = { fg = xeno.yellow, bg = statusline.bg } },
      { [palette.hls.lsp_err] = { fg = xeno.red, bg = statusline.bg } },

      -- Git status indicators in StatusLine
      { [palette.hls.git_add] = { fg = is_light_bg and palette.dark_green or palette.green, bg = statusline.bg } },
      { [palette.hls.git_rm] = { fg = is_light_bg and palette.red or palette.pale_red, bg = statusline.bg } },
      { [palette.hls.git_mod] = { fg = is_light_bg and palette.orange or palette.light_yellow, bg = statusline.bg } },

      -- Other StatusLine indicators
      { [palette.hls.modified] = { fg = is_light_bg and palette.orange or palette.light_yellow, bg = statusline.bg } },
      { [palette.hls.recording] = { fg = { from = '@accent.fg.500' }, bg = statusline.bg } },

      -- NeoTree specific (File explorer) - using xeno.base_800
      { [palette.hls.neotree] = { fg = xeno.base_200, bg = xeno.base_800 } },
      { [palette.hls.neotree_icon] = { fg = palette.dark_red, bg = xeno.base_800 } },

      -- Trouble specific - using xeno.base_800
      { [palette.hls.trouble] = { fg = xeno.base_200, bg = xeno.base_800 } },
      { [palette.hls.trouble_icon] = { fg = palette.dark_red, bg = xeno.base_800 } },

      -- Terminal specific - using xeno.base_800
      { [palette.hls.terminal] = { fg = xeno.base_200, bg = xeno.base_900 } },
      { [palette.hls.terminal_icon] = { fg = palette.green, bg = xeno.base_900 } },

      { [palette.hls.fzf] = { fg = xeno.base_200, bg = xeno.base_700 } },
      { [palette.hls.fzf_icon] = { fg = xeno.accent_500, bg = xeno.base_700 } },

      -- General Error
      { [palette.hls.error] = { fg = error_fg, bg = statusline.bg, bold = true } },
    })
  end)

  if not success then
    -- Retry after a short delay if highlights failed to apply
    vim.defer_fn(palette.setup, 100)
  end
end

-- Add a function to manually refresh statusline highlights
function palette.refresh_statusline()
  palette.setup()
  vim.cmd('redrawstatus!')
end

return palette
