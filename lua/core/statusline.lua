local M = {}

local empty = require("core.utils.empty")
local concat = require("core.utils.concat")

local icons = require("core.options").icons

-- stylua: ignore
local mode_names = {
  ["n"]  = " normal ",
  ["i"]  = " insert ",
  ["v"]  = " visual ",
  ["V"]  = " v-line ",
  [""] = " block ",
  ["R"]  = " replace ",
  ["s"]  = " select ",
  ["c"]  = " command ",
  ["t"]  = " terminal ",
}

local mode_highlights = {
  ["n"] = "normal_mode",
  ["i"] = "insert_mode",
  ["v"] = "visual_mode",
  ["V"] = "line_mode",
  [""] = "block_mode",
  ["R"] = "replace_mode",
  ["s"] = "select_mode",
  ["c"] = "command_mode",
  ["t"] = "terminal_mode",
}

local mode = {
  function()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format("%%#%s#%s%%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]:upper())
  end,
}

local macro = {
  function()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format("%%#%s# recording @%s %%#Statusline#", mode_highlights[current_mode], vim.fn.reg_recording())
  end,
  condition = function()
    return not empty(vim.fn.reg_recording())
  end,
}

local line = { " %l:%c" }

local search = {
  function()
    if vim.v.hlsearch == 0 then
      return ""
    end

    local count = vim.fn.searchcount({ maxcount = 999 })
    return string.format(" /%s [%s/%d] ", vim.fn.getreg("/"), count.current, count.total)
  end,
  condition = function()
    local searchcount = vim.fn.searchcount()
    return next(searchcount) and searchcount.total > 0 or 0
  end,
}

local file = {
  function()
    local modified = vim.bo.modified and "[+] " or ""
    return string.format("%s %s%%L lines", vim.fn.expand("%:P"), modified)
  end,
  padding = true,
}

local right_align = { "%=" }

local diagnostics = {
  function()
    local count = {}
    local levels = { errors = "Error", warnings = "Warn", info = "Info", hints = "Hint" }

    for k, level in pairs(levels) do
      count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local function format_diagnostic(highlight, status)
      return count[status] ~= 0 and string.format("%%#%s#  %s%%#Statusline#", highlight, count[status]) or ""
    end

    return concat(
      format_diagnostic("StatusLineError", "errors"),
      format_diagnostic("StatusLineWarning", "warnings"),
      format_diagnostic("StatusLineInfo", "hints"),
      format_diagnostic("StatusLineHint", "info")
    )
  end,
  padding = true,
}

local root = {
  function()
    local root = vim.fn.getcwd()
    local workspace = root:sub(root:find("[^/]*$"))
    return " " .. workspace
  end,
  padding = true,
}

local git = {
  function()
    local git_info = vim.b.gitsigns_status_dict

    if not git_info or git_info.head == "" then
      return ""
    end

    local function format_git(icon, status)
      return status ~= 0 and status ~= nil and string.format(" %s%s", icon, status) or ""
    end

    return table.concat({
      icons.git_branch .. git_info.head,
      format_git("+", git_info.added),
      format_git("~", git_info.changed),
      format_git("-", git_info.removed),
    })
  end,

  padding = true,
}

local components = {
  [1] = macro,
  [2] = mode,
  [3] = search,
  [4] = line,
  [5] = file,
  [6] = right_align,
  [7] = diagnostics,
  [8] = root,
  [9] = git,
}

local check_type = function(value)
  if type(value) == "function" then
    return value()
  end

  return value
end

local active = components

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
      format = string.format("%s%s%s%s", format, highlights.seperator, component.right_sep, highlights.background)
    end

    statusline = statusline .. format

    ::continue::
  end

  return highlights.background .. statusline .. "% "
end

return M
