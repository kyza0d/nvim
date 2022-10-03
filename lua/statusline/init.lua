local M = {}

local empty = require("utils.empty")

local check_type = function(value)
  if type(value) == "function" then
    return value()
  end

  return value
end

local active = require("statusline.active")

M.active = function()
  local statusline = ""

  for i = 1, #active do
    local component = active[i]

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

  return "%#Statusline#" .. statusline .. "% "
end

return M
