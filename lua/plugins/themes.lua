--------------------------------------------
-- Colorschemes
--------------------------------------------

return {
  -- Colorscheme engine
  --- @url https://github.com/svermeulen/text-to-colorscheme
  {
    'svermeulen/text-to-colorscheme',
    lazy = false,
    opts = require('config.text-to-colorscheme'),
  },
}
