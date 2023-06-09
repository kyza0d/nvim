local M = {}

local concat = require("utils.concat")

local empty = function(s)
  return s == "" or s == nil
end

local modes = {
  ["n"]   = { "normal", "NormalMode" },
  ["niI"] = { "normal", "NormalMode" },
  ["niR"] = { "normal", "NormalMode" },
  ["niV"] = { "normal", "NormalMode" },
  ["no"]  = { "n-pending", "NormalMode" },
  ["i"]   = { "insert", "InsertMode" },
  ["ic"]  = { "insert", "InsertMode" },
  ["ix"]  = { "insert", "InsertMode" },
  ["t"]   = { "terminal", "TerminalMode" },
  ["nt"]  = { "nterminal", "TerminalMode" },
  ["v"]   = { "visual", "VisualMode" },
  ["V"]   = { "v-line", "VisualMode" },
  ["Vs"]  = { "v-line", "VisualMode" },
  [""]  = { "v-block", "VisualMode" },
  ["R"]   = { "replace", "ReplaceMode" },
  ["Rv"]  = { "v-replace", "ReplaceMode" },
  ["s"]   = { "select", "SelectMode" },
  ["S"]   = { "s-line", "SelectMode" },
  [""]  = { "s-block", "SelectMode" },
  ["c"]   = { "command", "CommandMode" },
  ["cv"]  = { "command", "CommandMode" },
  ["ce"]  = { "command", "CommandMode" },
  ["r"]   = { "prompt", "PromptMode" },
  ["rm"]  = { "more", "MoreMode" },
  ["r?"]  = { "confirm", "ConfirmMode" },
  ["!"]   = { "shell", "ShellMode" },
}

local mode = {
  function()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(
      "%%#%s#🮉%%#StatusLineMode# %s %%#StatusLine#",
      modes[current_mode][2],
      modes[current_mode][1]:upper()
    )
  end,
}

local macro = {
  function()
    return string.format("recording @%s ", vim.fn.reg_recording())
  end,
  condition = function()
    return not empty(vim.fn.reg_recording())
  end,
}

local line = { "%l:%c " }

local search = {
  function()
    if vim.v.hlsearch == 0 then
      return ""
    end

    local count = vim.fn.searchcount({ maxcount = 0 })
    local search_string = string.format("/%s", vim.fn.getreg("/"))

    if #search_string > math.floor(vim.o.columns * 0.2) then
      search_string = string.sub(search_string, 1, math.floor(vim.o.columns * 0.2)) .. " …"
    end

    return search_string .. string.format(" [%s/%d] ", count.current, count.total)
  end,
  condition = function()
    local searchcount = vim.fn.searchcount()
    return next(searchcount) and searchcount.total > 0 or 0
  end,
}

local file = {
  function()
    local modified = vim.bo.modified and "%#StatusLineBlue#  %#StatusLine#" or ""
    local parent = vim.fn.expand("%:p:h:t")
    local file = vim.fn.expand("%:p:t")
    local icon, color = require'nvim-web-devicons'.get_icon_color(vim.fn.expand("%:t"), vim.fn.expand("%:e"))

    icon = icon or ""

    vim.api.nvim_set_hl(0, "StatusLineColor", {fg = color, bg = "#1B1B1E" })

    return string.format("%s%s/%s ", modified, parent, file)
  end,
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
      return count[status] ~= 0 and string.format("%%#%s%%#StatusLine#%s ", highlight, count[status]) or ""
    end

    return concat(
      format_diagnostic("StatusLineError# 󰅚  ", "errors"),
      format_diagnostic("StatusLineWarning# 󱇏  ", "warnings"),
      format_diagnostic("StatusLineInfo# 󱋉  ", "hints"),
      format_diagnostic("StatusLineHint# 󰗖  ", "info")
    )
  end,
}

local root = {
  function()
    local root = vim.fn.getcwd()
    local workspace = root:sub(root:find("[^/]*$"))
    return workspace
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
      "[" .. git_info.head .. "]",
      format_git("%#StatusLineGreen#  %#StatusLine#", git_info.added),
      format_git("%#StatusLineYellow#  %#StatusLine#", git_info.changed),
      format_git("%#StatusLineRed#  %#StatusLine#", git_info.removed),
    })
  end,

  padding = true,
}

local components = {
  [1] = mode,
  [2] = macro,
  [3] = search,
  [4] = file,
  [5] = line,
  [6] = diagnostics,
  [7] = right_align,
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
    seperator = "%#StatusLineSeperator#",
    background = "%#StatusLine#",
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
        format = format .. " "
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
