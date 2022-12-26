local M = {}

local empty = require("utils.empty")

local colors = require("harmony").colors

local check_type = function(value)
  if type(value) == "function" then
    return value()
  end

  return value
end

local active = require("statusline.active")

M.active = function()
  local statusline = ""

  local highlights = {
    seperator = "%#StatuslineSeperator#",
    background = "%#Statusline#",
  }

  for i = 1, #active do
    local component = active[i]

    if check_type(component.condition) == false then
      goto continue
    end

    local format = check_type(component[1])

    if not empty(format) then
      format = format
      if component.padding then
        format = " " .. format .. " "
      end
    end

    if component.left_sep then
      format = string.format("%s%s%s", highlights.seperator, component.left_sep, format)
    end

    if component.right_sep then
      -- format = string.format("%s%s%s%s", highlights.seperator, component.right_sep, highlights.background, format)
      format = string.format("%s%s%s%s", format, highlights.seperator, component.right_sep, highlights.background)
    end

    statusline = statusline .. format

    ::continue::
  end

  return highlights.background .. statusline .. "% "
end

return M
