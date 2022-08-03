M = {}

M.setup = function()
  require("plugin-config.telescope_layouts.dropdown").custom_dropdown()
  require("plugin-config.telescope_layouts.bottom_borders").bottom_borders()
  require("plugin-config.telescope_layouts.bottom_borderless").bottom_borderless()
  require("plugin-config.telescope_layouts.horizontal_split").horizontal_split()
  require("plugin-config.telescope_layouts.cmd_line").cmd_line()
end

return M
