M = {}

M.setup = function()
  require("plugin.telescope_layouts.dropdown").custom_dropdown()
  require("plugin.telescope_layouts.bottom_borders").bottom_borders()
  require("plugin.telescope_layouts.bottom_borderless").bottom_borderless()
  require("plugin.telescope_layouts.horizontal_split").horizontal_split()
  require("plugin.telescope_layouts.cmd_line").cmd_line()
end

return M
