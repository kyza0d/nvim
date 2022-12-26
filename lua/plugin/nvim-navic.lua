local status_ok, navic = pcall(require, "nvim-navic")

if not status_ok then
  return
end

local icons = require("options").icons

navic.setup({
  -- stylua: ignore
  icons = {
    File          = "  ",
    Module        = "  ",
    Namespace     = "  ",
    Package       = "  ",
    Class         = "  ",
    Method        = "  ",
    Property      = "  ",
    Field         = "  ",
    Constructor   = "  ",
    Enum          = "練 ",
    Interface     = "練 ",
    Function      = "  ",
    Variable      = "  ",
    Constant      = "  ",
    String        = "  ",
    Number        = "  ",
    Boolean       = "◩  ",
    Array         = "  ",
    Object        = "  ",
    Key           = "  ",
    Null          = "ﳠ  ",
    EnumMember    = "  ",
    Struct        = "  ",
    Event         = "  ",
    Operator      = "  ",
    TypeParameter = "  ",
  },

  separator = icons.chevron,
  highlight = true,
  depth_limit = 3,
  depth_limit_indicator = "..",
})
