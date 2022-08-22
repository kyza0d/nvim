-- vim.opt.background = "light"

local status_ok, palette = pcall(require, "palette")

if not status_ok then
  return
end

local colors = palette.colors
local blend = require("palette.utils").blend

-- vim.cmd([[colorscheme morning]])


-- stylua: ignore
palette.setup({
  on_change = function()
    vim.cmd([[source ~/.config/nvim/lua/plugin/lualine.lua]])
    -- vim.cmd([[source ~/.config/nvim/lua/plugin/bufferline.lua]])
  end,

  prefer = "dark",

  colors = {
    ["*"] = {
      -- background = { "#212121", "#efefef" },
      background = { "#1a1c1e", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      red        = { "#E86671", "#E45649" },
      green      = { "#6B8E23", "#50A14F" },
      yellow     = { "#D7AF5F", "#C18401" },
      blue       = { "#61AFEF", "#0184BC" },
      purple     = { "#c792ea", "#A626A4" },
      accent     = { "#61AFEF", "#0184BC" },

      highlights = {
        FoldColumn = {fg = "none"},
      },
    },

    ["plastic"] = {
      background = {"#13171C", "#ffffff"},
    },

    ["everforest"] = {
      background = {"#212121", "#ffffff"},
      foreground = {"#d8d1c3", "#000000"},
      accent = {"#83C092", "#ffffff"}
    },

    ["vscode"] = {
      background = {"#1E1E1E", "#ffffff"},
      foreground = {"#bbbbbb", "#000000"},
    },

    ["onedark"] = {
      background = {"#202226", "#ffffff"},
      foreground = {"#c9cfdb", "#000000"}
    },

    ["dark-pines"] = {
      lightness = -0.2,
    },

    ["gruvbox"] = {
      background = {"#282828", "#ffffff"},
      foreground = {"#f4dbc1", "#606571"},
    },

    ["solarized8"] = {
      background   = { "#002B36", "#FDF6E3" },
      foreground   = { "#ced2da", "#383A42" },
      red          = { "#E86671", "#E45649" },
      green        = { "#7F9F7F", "#50A14F" },
      yellow       = { "#EFDCBC", "#C18401" },
      blue         = { "#61AFEF", "#61AFEF" },
      purple       = { "#c792ea", "#A626A4" },
      accent       = { "#61AFEF", "#61AFEF" },

      lightness    = -0.4,
    },

    ["nord"] = {
      background = { "#181a1e", "#ffffff" },
      foreground = { "#ced2da", "#383A42" },
      red        = { "#E86671", "#E45649" },
      green      = { "#7F9F7F", "#50A14F" },
      yellow     = { "#EFDCBC", "#C18401" },
      blue       = { "#61AFEF", "#0184BC" },
      purple     = { "#c792ea", "#A626A4" },
      accent     = { "#88C0D0", "#61AFEF" },
    },

    ["zenburn"] = {
      background = { "#1C1C1C", "#ffffff" },
      foreground = { "#ced2da", "#383A42" },
      red        = { "#E86671", "#E45649" },
      green      = { "#7F9F7F", "#50A14F" },
      yellow     = { "#EFDCBC", "#C18401" },
      blue       = { "#61AFEF", "#0184BC" },
      purple     = { "#c792ea", "#A626A4" },
      accent     = { "#7F9F7F", "#61AFEF" },

      highlights = {
        TSConstructor = { gui = "none", fg = "#EFDCBC" },
        TSTag = { gui = "none", fg = "#EFDCBC" },
      }
    },
  },
})

vim.cmd([[colorscheme zenburn]])
vim.cmd([[ hi! clear Normal ]])
