local icons = require("core.options").icons

return {
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
}
