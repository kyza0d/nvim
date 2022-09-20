-- Taken from https://github.com/barrett-ruth/dots

local empty = require("utils.empty")

local check_type = function(value)
  if type(value) == "function" then
    return value()
  end

  return value
end

local components = require("statusline.components")

return {
  statusline = function()
    local statusline = ""

    for i = 1, #components do
      local component = components[i]

      if check_type(component.condition) == false then
        goto continue
      end

      local format = check_type(component[1])

      if not empty(format) then
        format = format .. "  "
      end

      statusline = statusline .. format
      ::continue::

    end

    return "%#Statusline# " .. statusline .. "% "
  end,
}
