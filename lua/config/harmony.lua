local highlights = require('highlights')
local colors = require('harmony').color

local t2c_colors = require('text-to-colorscheme')
local t2c_utils = require('text-to-colorscheme.internal.color_util')
local t2c_hsv_palette = t2c_colors.get_palette()
local t2c_background = t2c_utils.hsv_to_hex(t2c_hsv_palette.background)
local t2c_foreground = t2c_utils.hsv_to_hex(t2c_hsv_palette.foreground)

require('harmony').setup({
  ['*'] = {
    bg = { '#2C3338', '#ffffff' },
    fg = { '#dddddd', '#222222' },

    highlights = highlights,
  },

  ['text-to-colorscheme'] = {
    bg = t2c_background,
    fg = t2c_foreground,
  },

  byte = {
    bg = { '#111111', '#222222' },
    fg = { '#dddddd', '#222222' },
  },

  neowal = {
    bg = { '#101010', '#222222' },
    fg = { '#dddddd', '#222222' },
  },

  tokyonight = {
    bg = '#161820',
    fg = '#c9cee0',
  },

  embark = {
    bg = '#151423',
    fg = '#ccc9e5',
  },

  ['catppuccin-mocha'] = {
    bg = '#232338',
    fg = '#c9cee0',
  },

  palenightfall = {
    bg = '#1d1f2a',
    fg = '#b7bfe2',
    highlights = {
      Conceal = { clear = true },
    },
  },

  onedark = {
    bg = { '#1E232A', '#ffffff' },
    fg = { '#cdd1d8', '#888888' },
  },

  sweetie = {
    bg = '#0D0D16',
    fg = '#d2cdf2',
  },
})

local group = create_augroup('Harmony', {
  clear = true,
})

create_autocmd('ColorScheme', {
  command = 'source ~/.config/nvim/lua/config/harmony.lua',
  group = group,
})
