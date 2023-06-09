local highlights = require('highlights')
local colors = require('harmony').colors

-- vim.opt.background = "light"

require('harmony').setup({
  ['*'] = {
    bg = { '#111111', '#ffffff' },
    fg = { '#dddddd', '#222222' },

    highlights = highlights,
  },

  byte = {
    -- bg = { "#000000", "#ffffff" },
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

    highlights = {
      Normal = { bg = colors.bg_negative_1 },
    },
  },

  sweetie = {
    bg = '#0D0D16',
    fg = '#d2cdf2',
  },
})
