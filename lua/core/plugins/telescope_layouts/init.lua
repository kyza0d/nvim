M = {}

M.setup = function()
  require("core.plugins.telescope_layouts.dropdown").custom_dropdown()
  require("core.plugins.telescope_layouts.bottom_borders").bottom_borders()
  require("core.plugins.telescope_layouts.bottom_borderless").bottom_borderless()
end

return M
