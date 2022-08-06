local create_autocmd = vim.api.nvim_create_autocmd

local get_buf_info = require("utils").get_buf_info

local colors = require("palette").colors
local darken_float = require("palette.utils").darken_float

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  -- return string.format(" %s ", modes[current_mode]):upper()
  return string.format("%s", modes[current_mode]):upper()
end

local workspace_root = function()
  local root = vim.fn.getcwd()
  local workspace = root:sub(root:find("[^/]*$"))
  if workspace == "evan" then
    workspace = "~"
  end
  return workspace
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end

  local last_search = vim.fn.getreg("/")

  if not last_search or last_search == "" then
    return ""
  end

  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  return "/" .. last_search .. "[" .. searchcount.current .. "/" .. searchcount.total .. "] "
end

local function modified()
  if vim.bo.modified then
    return "  "
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return "   "
  end
  return ""
end

local function filename()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return ""
  end
  return fname .. " "
end

local navic = function()
  return "%{%v:lua.require'nvim-navic'.get_location()%}"
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat({
    "  ",
    git_info.head .. " ",
    added,
    changed,
    removed,
  })
end

require("nvim-navic").setup({
  icons = {
    File = "  ",
    Module = "  ",
    Namespace = "  ",
    Package = "  ",
    Class = "  ",
    Method = "  ",
    Property = "  ",
    Field = "  ",
    Constructor = "  ",
    Enum = "練 ",
    Interface = "練 ",
    Function = "  ",
    Variable = "  ",
    Constant = "  ",
    String = "  ",
    Number = "  ",
    Boolean = "◩  ",
    Array = "  ",
    Object = "  ",
    Key = "  ",
    Null = "ﳠ  ",
    EnumMember = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
  },
  highlight = false,
  separator = "  ",
  depth_limit = 0,
  depth_limit_indicator = "..",
})

Statusline = {}

local function reg_recording()
  if vim.fn.reg_recording() ~= "" then
    return " "
  else
    return ""
  end
end

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    return reg_recording()
  end,
})

Statusline.active = function()
  return table.concat({
    "%#StatuslineNC#",
    -- mode(),
    reg_recording(),
    modified(),
    filepath(),
    filename(),
    navic(),
    "%=%#StatusLineExtra#",
    search_result(),
    "%l:%c ",
    "  ",
    workspace_root(),
    " ",
    vcs(),
    " ",
  })
end

function Statusline.inactive()
  return " %F "
end

create_autocmd({ "WinEnter", "BufEnter" }, {
  command = "setlocal statusline=%!v:lua.Statusline.active()",
})

create_autocmd({ "WinEnter", "BufLeave" }, {
  command = "setlocal statusline=%!v:lua.Statusline.inactive()",
})
