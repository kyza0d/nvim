local highlights = require('highlights')

local colors = require('harmony').colors

-- vim.cmd([[set background=light]])

require('harmony').setup({
  ['*'] = {
    bg = { '#2C3338', '#ffffff' },
    fg = { '#dddddd', '#222222' },

    highlights = highlights,
  },

  default = {
    bg = '#14161B',
    fg = '#d2dbef',
  },

  ['summer-time'] = {
    bg = '#232326',
    fg = '#e5e5e5',
  },

  horizon = {
    bg = '#1C1E26',
    fg = '#cccccc',
  },
  tokyonight = {
    bg = '#12131E',
    fg = '#c2c6ed',
  },
})

-- local group = create_augroup('Harmony', {
--   clear = true,
-- })
--
-- create_autocmd('ColorScheme', {
--   command = 'source ~/.config/nvim/lua/config/harmony.lua',
--   group = group,
-- })
