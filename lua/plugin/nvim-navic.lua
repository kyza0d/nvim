local status_ok, navic = pcall(require, "nvim-navic")

if not status_ok then
  return
end

local icons = require("options").icons

navic.setup({
  icons = {
    File = "",
    Module = "",
    Namespace = "",
    Package = "",
    Class = "",
    Method = "",
    Property = "",
    Field = "",
    Constructor = "",
    Enum = "",
    Interface = "",
    Function = "",
    Variable = "",
    Constant = "",
    String = "",
    Number = "",
    Boolean = "",
    Array = "",
    Object = "",
    Key = "",
    Null = "",
    EnumMember = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },

  separator = icons.chevron,
  depth_limit = 3,
  depth_limit_indicator = "..",
})
