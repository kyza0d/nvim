local empty = require("utils.empty")
-- local colors = require("palette").colors
local icons = require("options").icons

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

    return string.format(" %s", modes[current_mode]):upper()
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
    return next(searchcount) and searchcount.total > 0 or 0
  end,
}

local file = {
  function()
    local modified = vim.bo.modified and "+ " or ""

    local icon, color = require("nvim-web-devicons").get_icon_color(vim.fn.expand("%:e"), vim.bo.filetype)

    color = color or ""
    icon = icon or ""

    -- vim.api.nvim_command(string.format("hi Icon guifg=%s guibg=%s", color, colors.background_shaded_1))

    icon = "%#Icon#" .. icon .. "%#Statusline#"

    -- return string.format("%s %s", vim.fn.expand("%:p:t"), modified)
    return string.format("%s %s", vim.fn.expand("%"), modified)
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
      return count[status] ~= 0 and string.format(icon .. "%s ", count[status]) or ""
    end

    return table.concat({
      format_diagnostic(icons.error, "errors"),
      format_diagnostic(icons.warning, "warnings"),
      format_diagnostic(icons.hint, "hints"),
      format_diagnostic(icons.info, "info"),
    })
  end,
}

local root = {
  function()
    local root = vim.fn.getcwd()
    local workspace = root:sub(root:find("[^/]*$"))
    return icons.folder .. workspace
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
      icons.git_branch .. git_info.head,
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
  [7] = right_align,
  [8] = root,
  [9] = git,
}
