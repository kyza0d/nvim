require('color-space.colorschemes').setup()

local colors = require('color-space').colors

require('color-space.colorschemes').highlights({
  ['*'] = {
    Normal = { bg = colors['background']:l(-0.4):hex() },
  },

  ['desert'] = {
    Normal = { bg = colors['background']:l(-0.3):hex() },
    StatusLine = { bg = colors['background']:l(-0.3):hex() },
  },
})
