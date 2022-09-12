local empty = require("utils.empty")
local colors = require("palette").colors

local mode = {
  function()
    local modes = {
      ["n"] = "normal",
      ["i"] = "insert",
      ["v"] = "visual",
      ["V"] = "v·line",
      [""] = "v·block",
      ["R"] = "replace",
      ["s"] = "select",
      ["c"] = "command",
      ["t"] = "terminal",
    }

    local current_mode = vim.api.nvim_get_mode().mode

    -- vim.api.nvim_command("hi Mode guibg=" .. colors.accent .. " guifg=" .. colors.background_1)
    -- return "%#Mode# " .. string.format("%s", modes[current_mode]):upper() .. " %#Statusline#"

    return " " .. string.format("%s", modes[current_mode]):upper()
  end,
}

local macro = {
  " ",
  condition = function()
    return not empty(vim.fn.reg_recording())
  end,
}

local line = { "%l:%L" }

local search = {
  function()
    if vim.v.hlsearch == 0 then
      return ""
    end

    local count = vim.fn.searchcount({ maxcount = 999 })
    return string.format("/%s [%s/%d]", vim.fn.getreg("/"), count.current, count.total)
  end,
  condition = function()
    local searchcount = vim.fn.searchcount()
    return next(searchcount) and searchcount.total > 0
  end,
}

local file = {
  function()
    local modified = vim.bo.modified and "[+] " or ""

    local icon, color = require("nvim-web-devicons").get_icon_color(vim.fn.expand("%:e"), vim.bo.filetype)

    color = color or ""
    icon = icon or ""

    vim.api.nvim_command(string.format("hi Icon guifg=%s guibg=%s", color, colors.background_shaded_1))

    icon = "%#Icon#" .. icon .. "%#Statusline#"
    -- icon = "%#Statusline#" .. icon .. "%#Statusline#"

    -- return string.format("%s%s %s", modified, icon, vim.fn.expand("%:p:t"))
    return string.format("%s %s", modified, vim.fn.expand("%:p:t"))
  end,
}

local nvim_navic = require("nvim-navic")

local navic = {
  function()
    return nvim_navic.get_location()
  end,
  condition = function()
    return nvim_navic.is_available() and not empty(nvim_navic.get_location())
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
    local function format_diagnostic(icon, status)
      return count[status] ~= 0 and string.format(icon .. "%s", count[status]) or ""
    end
    return table.concat({
      string.format("  %s ", count["errors"]),
      string.format("  %s", count["warnings"]),

      format_diagnostic("   ", "hints"),
      format_diagnostic("   ", "info"),
    })
  end,
}

local root = {
  function()
    local root = vim.fn.getcwd()
    local workspace = root:sub(root:find("[^/]*$"))
    return workspace
  end,
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
      git_info.head,
      format_git("+", git_info.added),
      format_git("~", git_info.changed),
      format_git("-", git_info.removed),
    })
  end,
}

return {
  [1] = mode,
  [2] = diagnostics,
  [3] = macro,
  [4] = line,
  [5] = search,
  [6] = file,
  [7] = navic,
  [8] = right_align,
  [9] = root,
  [10] = git,
}
