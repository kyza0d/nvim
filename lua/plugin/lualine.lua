-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")


-- Color table for highlights
-- stylua: ignore
local colors = require("palette").colors

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local darken = require("palette.utils").darken

local background_0 = darken(colors.background_0, 9)

local theme = {
  normal = {
    c = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
    x = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
  },
  insert = {
    c = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
    x = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
  },
  visual = {
    c = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
    x = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
  },
  replace = {
    c = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
    x = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
  },
  command = {
    c = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
    x = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
  },
  inactive = {
    c = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
    x = { bg = background_0, fg = colors.foreground_3, gui = "italic" },
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
    return "▌"
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 0 }, -- We don't need space before this
})

ins_left({
  -- filesize component
  "filesize",
  cond = conditions.buffer_not_empty,
})

ins_left({ "location" })

ins_left({ "progress" })

ins_left({
  "filename",
  show_filename_only = false,
  cond = conditions.buffer_not_empty,
})

require("nvim-navic").setup({
  highlight = true,
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

ins_left({
  require("nvim-navic").get_location,
  cond = require("nvim-navic").is_available,
})

-- Add components to right sections
ins_right({
  "o:encoding", -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    local root = vim.fn.getcwd()
    local workspace = root:sub(root:find("[^/]*$"))
    if workspace == "evan" then
      workspace = "~"
    end
    return workspace
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

-- Now don't forget to initialize lualine
lualine.setup(config)
