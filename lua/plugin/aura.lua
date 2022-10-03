local colors = require("palette").colors

-- stylua: ignore start
local midnight = {
  primary      = { "#5a7199", "#ffffff" },
  secondary    = { "#00ACCE", "#ffffff" },
  background   = { "#0F1215", "#ffffff" },
  foreground   = { "#b2ceff", "#ffffff" },
  comment      = { "#3c4b66", "#ffffff" },
  strings      = { "#83C092", "#ffffff" },
}

local abyss    = {
  -- primary      = { "#32A448", "#555555" },
  primary      = { "#893437", "#555555" },
  secondary    = { "#666666", "#555555" },
  tertiary     = { "#CED4DA", "#555555" },
  accent       = { "#555555", "#555555" },
  background   = { "#000000", "#eeeeee" },
  foreground   = { "#CED4DA", "#000000" },
  comment      = { "#333333", "#333333" },
  red          = { "#555555", "#555555" },
  green        = { "#555555", "#555555" },
  yellow       = { "#555555", "#555555" },
  blue         = { "#555555", "#555555" },
  purple       = { "#555555", "#555555" },
}

local iosevkem = {
  background   = { "#22272E", "#ffffff" },
  foreground   = { "#b7c9e5", "#ffffff" },
  accent       = { "#03AEE9", "#ffffff" },
  primary      = { "#03AEE9", "#ffffff" },
  secondary    = { "#B77FDB", "#ffffff" },
  strings      = { "#E7C664", "#ffffff" },
  boolean      = { "#E79A48", "#ffffff" },
  numbers      = { "#E79A48", "#ffffff" },
  comment      = { "#6e7989", "#ffffff" },
}

local synthetik = {
  background   = { "#12202B", "#ffffff" },
  foreground   = { "#b7c9e5", "#ffffff" },
  accent       = { "#03AEE9", "#ffffff" },
  primary      = { "#36BC98", "#ffffff" },
  secondary    = { "#5C9FD8", "#ffffff" },
  -- strings      = { "#E7C664", "#ffffff" },
  -- boolean      = { "#E79A48", "#ffffff" },
  -- numbers      = { "#E79A48", "#ffffff" },
  comment      = { "#6e7989", "#ffffff" },
}

local humanoid = {
  primary      = { "#0ED1D1", "#555555" },
  secondary    = { "#EC44EB", "#555555" },
  tertiary     = { "#B0B4BB", "#555555" },

  background   = { "#1D1F21", "#eeeeee" },
  foreground   = { "#ffffff", "#000000" },

  red          = { "#ff0000", "#555555" },
  green        = { "#555555", "#555555" },
  yellow       = { "#555555", "#555555" },
  blue         = { "#555555", "#555555" },
  purple       = { "#555555", "#555555" },

  accent       = { "#999999", "#555555" },

  extras       = {
    comments   = { "#555555", "#333333" },
    booleans   = { "#02D849", "#333333" },
    brackets   = { "#02D849", "#333333" },
    strings    = { "#02D849", "#333333" },
    numbers    = { "#02D849", "#333333" },
  },

  highlights = {
    TSField        = { fg = colors.primary },
    TSPunctSpecial = { fg = colors.secondary },
    TSTagDelimiter = { fg = colors.red },
    TSTypeBuiltin  = { fg = colors.yellow },
  }
}

vim.g.aura = synthetik
