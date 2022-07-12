local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
  return
end

local icons = require("core.utils").getvar("icons")
local workspace_root = require("core.utils").workspace_root
local wordcount = require("core.utils").wordcount
-- local darken = require("palette.utils").darken
local gps = require("nvim-gps")

local colors = require("palette.colors")

local theme = {
  normal = {
    a = { fg = colors.background_3, bg = colors.background_0 },
    b = { fg = colors.foreground_1, bg = colors.background_3 },
    c = { fg = colors.foreground_1, bg = colors.background_3 },
    x = { fg = colors.foreground_1, bg = colors.background_3 },
    y = { fg = colors.foreground_1, bg = colors.background_3 },
    z = { fg = colors.background_3, bg = colors.background_0 },
  },

  inactive = {
    a = { fg = colors.background_1, bg = colors.background_0 },
    b = { fg = colors.foreground_1, bg = colors.background_1 },
    c = { fg = colors.foreground_1, bg = colors.background_1 },
    y = { fg = colors.foreground_1, bg = colors.background_1 },
    z = { fg = colors.background_1, bg = colors.background_0 },
  },
}

local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  return last_search .. " " .. searchcount.current .. "/" .. searchcount.total
end

local function modified()
  if vim.bo.modified then
    return icons.modified
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return icons.readonly
  end
  return ""
end

lualine.setup({
  options = {
    theme = theme,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "scratch", "Alpha", "NvimTree" },
    disabled_buftypes = { "quickfix", "prompt", "scratch" },
    globalstatus = false,
  },
  sections = {
    lualine_a = {
      {
        function()
          -- return "▍"
          -- return " "
          return ""
        end,
        padding = { left = 0 },
      },
    },
    lualine_b = {
      { "mode", color = { gui = "bold" } },
    },
    lualine_c = {
      { modified, padding = { right = 1, left = 1 } },
      { "filename", file_status = false },
      { gps.get_location, cond = gps.is_available },
    },
    lualine_x = {
      "%l:%L",
      wordcount,
      search_result,
      { "branch", icon = "", colors = { gui = "bold" } },
      { "diff", colored = false },
    },
    lualine_y = { { icon = " ", workspace_root } },
    lualine_z = {
      {
        function()
          -- return "▍"
          -- return " "
          return ""
        end,
        padding = { right = 0 },
      },
    },
  },

  inactive_sections = {
    lualine_a = {
      {
        function()
          -- return "▍"
          -- return " "
          return ""
        end,
        padding = { left = 0 },
      },
    },
    lualine_b = {
      { "mode", colors = { gui = "bold" } },
      {
        "%w",
        cond = function()
          return vim.wo.previewwindow
        end,
      },
    },
    lualine_c = {
      { modified, padding = { right = 1, left = 1 } },
      { "filename", file_status = false },
      { gps.get_location, cond = gps.is_available },
    },
    lualine_x = {
      "%p%% %L",
      wordcount,
      search_result,
      { "branch", icon = "", colors = { gui = "bold" } },
      { "diff", colored = false },
    },
    lualine_y = {
      { icon = " ", workspace_root },
    },
    lualine_z = {
      {
        function()
          -- return "▍"
          -- return "  "
          return ""
        end,
        padding = { right = 0 },
      },
    },
  },
})

gps.setup({
  disable_icons = true,
  separator = "  ",
})
