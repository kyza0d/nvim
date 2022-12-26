local colors = require("harmony").colors

-- @string
-- @string.escape
-- @string.regex
-- @punctuation
-- @keyword
-- @property
-- @boolean
-- @repeat
-- @number
-- @label
-- @storageclass
-- @float
-- @parameter
-- @field
-- @method
-- @exception
-- @method.call
-- @conditional
-- @operator
-- @tag
-- @tag.delimiter
-- @tag.attribute
-- @type
-- @constructor
-- @constructor.lua
-- @include
-- @function
-- @function.builtin
-- @function.macro
-- @constant
-- @constant.builtin
-- @constant.macro
-- @preproc
-- @comment

local midnight = {
  primary = { "#5a7199", "#ffffff" },
  secondary = { "#00ACCE", "#ffffff" },
  tertiary = { "#90A1C3", "#ffffff" },
  background = { "#0F1215", "#ffffff" },
  foreground = { "#ccddff", "#ffffff" },
  comment = { "#3c4b66", "#ffffff" },
}

local lcd = {
  primary = { "#8bfee7", "#ffffff" },
  secondary = { "#8bfee7", "#ffffff" },
  tertiary = { "#8bfee7", "#ffffff" },
  accent = "#8bfee7",
  background = "#000000",
  foreground = "#a5c0cc",
  comment = "#E8D0A5",
}

local scenery = {
  primary = { "#BFB7AC", "#ffffff" },
  secondary = { "#BFB7AC", "#ffffff" },
  tertiary = { "#BFB7AC", "#ffffff" },
  accent = "#D2715E",
  background = "#191816",
  foreground = "#BFB7AC",
  comment = "#E8D0A5",
}

local ocean = {
  primary = { "#9ab4bf", "#ffffff" },
  secondary = { "#9ab4bf", "#ffffff" },
  tertiary = { "#9ab4bf", "#ffffff" },
  accent = "#93DDFA",
  background = "#102a34",
  foreground = "#9ab4bf",
  comment = "#E8D0A5",
}

local solarized = {
  primary = { "#b1c9cc", "#ffffff" },
  secondary = { "#709F00", "#ffffff" },
  tertiary = { "#1C9C94", "#ffffff" },
  accent = "#93DDFA",
  background = "#002B37",
  foreground = "#b1c9cc",
  comment = "#E8D0A5",
}

local aura = {}

-- aura.themes({
--   {
--     name = "humanoid",
--
--     background = "#1D1F21",
--     foreground = "#ffffff",
--
--     red = { "#0ED1D1", { "@function", "@keyword", "@operator", "@variable" } },
--     yellow = { "#EC44EB", { "@number" } },
--     purple = { "#F2F2F2", { "@string", "@comment" } },
--     magenta = { "#555555", { "@boolean" } },
--
--     highlights = {
--       ..., -- see `:h harmony-highlights`
--     },
--   },
-- })

vim.g.aura = solarized

-- vim.api.nvim_cmd({ cmd = "colorscheme", args = { "aura" } }, {})
