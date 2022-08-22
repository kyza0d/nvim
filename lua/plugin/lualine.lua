-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")


-- Color table for highlights
-- stylua: ignore
local colors = require("palette").colors

local conditions = {
  buffer_not_empt = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,

  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h:t")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")

    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- local background_0 = darken(colors.background_0, 9)
-- local background_0 = colors.contrast

local background = colors.background_darken

local theme = {
  normal = {
    c = { bg = background, fg = colors.foreground_3 },
    x = { bg = background, fg = colors.foreground_3 },
  },
  insert = {
    m = { bg = background, fg = colors.foreground_3 },
    x = { bg = background, fg = colors.foreground_3 },
  },
  visual = {
    c = { bg = background, fg = colors.foreground_3 },
    x = { bg = background, fg = colors.foreground_3 },
  },
  replace = {
    c = { bg = background, fg = colors.foreground_3 },
    x = { bg = background, fg = colors.foreground_3 },
  },
  command = {
    c = { bg = background, fg = colors.foreground_3 },
    x = { bg = background, fg = colors.foreground_3 },
  },
  inactive = {
    c = { bg = background, fg = colors.foreground_3 },
    x = { bg = background, fg = colors.foreground_3 },
  },
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    theme = theme,
    component_separators = "",
    section_separators = "",
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return "▎"
  end,
  color = { fg = colors.accent }, -- Sets highlighting of component
  padding = { left = 0, right = 0 }, -- We don't need space before this
})

ins_left({
  "mode",
  color = { fg = colors.accent }, -- Sets highlighting of component
  padding = { left = 1, right = 1 }, -- We don't need space before this
})

ins_left({
  function()
    return '%{expand("%:p:h:t")}  %{expand("%:p:t")}'
  end,
  cond = conditions.buffer_not_empty,
})

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

vim.opt.winbar = " "
vim.opt.winbar:append("  %{expand('%:p:h:t')}")
vim.opt.winbar:append(" ")
vim.opt.winbar:append("%{%v:lua.require'nvim-navic'.get_location()%}")
vim.opt.winbar:append("%=")
vim.opt.winbar:append(" %y")
vim.opt.winbar:append(" %3*")

vim.cmd("hi WinBar gui=strikethrough guifg=" .. colors.foreground_3)

-- ins_left({
--   require("nvim-navic").get_location,
--   cond = require("nvim-navic").is_available,
-- })

ins_right({
  function()
    if vim.v.hlsearch == 0 then
      return ""
    end

    local last_search = vim.fn.getreg("/")

    if not last_search or last_search == "" then
      return ""
    end

    local searchcount = vim.fn.searchcount({ maxcount = 9999 })
    return "/" .. last_search .. "[" .. searchcount.current .. "/" .. searchcount.total .. "]"
  end,
})

ins_right({
  "branch",
  icon = " ",
})

ins_right({
  "diff",
  -- Is it me or the symbol for modified us really weird
  diff_color = {
    added = { fg = colors.foreground_3 },
    modified = { fg = colors.foreground_3 },
    removed = { fg = colors.foreground_3 },
  },
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    local root = vim.fn.getcwd()
    local workspace = root:sub(root:find("[^/]*$"))
    if workspace == "evan" then
      workspace = "~"
    end
    return "  " .. workspace
  end,
})

-- Now don't forget to initialize lualine
lualine.setup(config)
