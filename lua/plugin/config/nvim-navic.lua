local icons = require("core.options").icons
local navic_icons = require("core.options").navic

return {
  icons = navic_icons,
  separator = icons.chevron,
  highlight = true,
  depth_limit = 3,
  depth_limit_indicator = "..",
}
