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

      local prettified = check_type(component.value)

      if not empty(prettified) then
        prettified = prettified .. "  "
      end

      statusline = statusline .. prettified
      ::continue::

    end

    return "%#Statusline#" .. statusline .. "% "
  end,
}
