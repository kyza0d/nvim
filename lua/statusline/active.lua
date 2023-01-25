local empty = require("utils.empty")
local icons = require("options").icons

local mode_names = {
  ["n"] = "normal",
  ["i"] = "insert",
  ["v"] = "visual",
  ["V"] = "line",
  [""] = "block",
  ["R"] = "replace",
  ["s"] = "select",
  ["c"] = "command",
  ["t"] = "terminal",
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
    return string.format("%%#%s#%%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]):upper()
    -- return string.format("%%#%s#   %%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]):upper()
    -- return string.format("%%#%s#   %%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]):upper()
    -- return string.format("%%#%s#   %%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]):upper()
    -- return string.format("%%#%s#🮉%%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]):upper()
    -- return string.format("%%#%s#  🭨%%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]):upper()
    -- return string.format("%%#%s# 🭨%%#Statusline#", mode_highlights[current_mode], mode_names[current_mode]):upper()
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

-- local line = { " %l:%c" }
local line = { " Ln %l, Col %c" }

local search = {
  function()
    if vim.v.hlsearch == 0 then
      return ""
    end

    local count = vim.fn.searchcount({ maxcount = 999 })

    -- local current_mode = vim.api.nvim_get_mode().mode
    -- return string.format("%%#%s# /%s [%s/%d] %%#Statusline#", mode_highlights[current_mode], vim.fn.getreg("/"), count.current, count.total)

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

    -- return string.format("   %s %s%%L lines", vim.fn.expand("%:P"), modified)
    return string.format(" %s %s%%L lines", vim.fn.expand("%:P"), modified)
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

    local function format_diagnostic(icon, status)
      return count[status] ~= 0 and string.format(icon .. " %s ", count[status]) or ""
    end

    return table.concat({
      format_diagnostic(icons.error, "errors"),
      format_diagnostic(icons.warning, "warnings"),
      format_diagnostic(icons.hint, "hints"),
      format_diagnostic(icons.info, "info"),
    })
  end,
  padding = true,
}

local root = {
  function()
    local root = vim.fn.getcwd()
    local workspace = root:sub(root:find("[^/]*$"))
    -- return "  " .. workspace
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
      return status ~= 0 and status ~= nil and string.format(" " .. icon .. "%s", status) or ""
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

return components
