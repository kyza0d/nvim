local empty = require("utils.empty")
local colors = require("palette").colors

local mode = {
  value = function()
    local modes = {
      ["n"] = "Normal",
      ["i"] = "insert",
      ["v"] = "Visual",
      ["V"] = "V·Line",
      [""] = "V·Block",
      ["R"] = "replace",
      ["s"] = "select",
      ["c"] = "command",
      ["t"] = "Terminal",
    }

    local current_mode = vim.api.nvim_get_mode().mode

    vim.cmd("hi Mode guibg=" .. colors.purple .. " guifg=" .. colors.background_3)
    return "%#Mode# " .. string.format("%s", modes[current_mode]):upper() .. " %#Statusline#"
  end,
}

local macro = {
  value = function()
    return " "
  end,
  condition = function()
    return not empty(vim.fn.reg_recording())
  end,
}

local file = {
  value = function()
    local modified = vim.bo.modified and "[+] " or ""
    return string.format("%s%s", modified, vim.fn.expand("%:p:t"))
  end,
}

local search = {
  value = function()
    if vim.v.hlsearch == 0 then
      return ""
    end

    local count = vim.fn.searchcount({ maxcount = 999 })

    return string.format("%s [%s/%d]", vim.fn.getreg("/"), count.current, count.total)
  end,
  condition = function()
    local searchcount = vim.fn.searchcount()
    return next(searchcount) and searchcount.total > 0
  end,
}

local line = {
  value = "%l:%L",
}

local status_ok, nvim_navic = pcall(require, "nvim-navic")

if not status_ok then
  return
end

local navic = {
  value = function()
    return nvim_navic.get_location()
  end,
  condition = function()
    return nvim_navic.is_available() and not empty(nvim_navic.get_location())
  end,
}

local right_align = {
  value = "%=",
}

local diagnostics = {
  value = function()
    local count = {}

    local levels = {
      errors = "Error",
      warnings = "Warn",
      info = "Info",
      hints = "Hint",
    }

    for k, level in pairs(levels) do
      count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local function format_diagnostic(icon, status)
      return count[status] ~= 0 and string.format(icon .. " %s", count[status]) or ""
    end

    local diagnostics = {
      format_diagnostic("  ", "errors"),
      format_diagnostic(" 𥉉", "warnings"),
      format_diagnostic(" 𥉉", "hints"),
      format_diagnostic("  ", "info"),
    }

    return unpack(diagnostics)
  end,
}
local git = {
  value = function()
    local git_info = vim.b.gitsigns_status_dict

    if not git_info or git_info.head == "" then
      return ""
    end

    local function format_git(icon, status)
      return status ~= 0 and string.format(" " .. icon .. "%s", status) or ""
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
  [2] = macro,
  [3] = file,
  [4] = search,
  [5] = line,
  [6] = navic,
  [7] = right_align,
  [8] = diagnostics,
  [9] = git,
}
