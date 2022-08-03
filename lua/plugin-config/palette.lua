vim.opt.background = "dark"

local status_ok, palette = pcall(require, "palette")

if not status_ok then
  return
end

local colors = palette.colors

-- stylua: ignore
palette.setup({
  on_change = function()
    vim.cmd([[source ~/.config/nvim/lua/plugin-config/statusline.lua]])
    vim.cmd([[source ~/.config/nvim/lua/plugin-config/bufferline.lua]])
  end,

  prefer = "dark",

  colors = {
    ["*"] = {
      background = { "#181A1B", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      red        = { "#E86671", "#E45649" },
      green      = { "#6B8E23", "#50A14F" },
      yellow     = { "#D7AF5F", "#C18401" },
      blue       = { "#61AFEF", "#0184BC" },
      purple     = { "#c792ea", "#A626A4" },
      accent     = { "#61AFEF", "#0184BC" },

      highlights = {
        MacroEnter = {fg = "#6B8E23"},
        CursorLine = { bg = "none" },
        CursorLineNr = { bg = "none" },
        FoldColumn = {fg = "none"},
      },

    },

    ["plastic"] = {
      background = {"#13171C", "#ffffff"},
    },

    ["dark-pines"] = {
      lightness = -0.2,
    },

    ["iceberg"] = {
      background = {"#161820", "#eeeeee"},
      foreground = {"#ABB2BF", "#606571"},
      lightness = -0.2,
    },


    ["onedark"] =  {
      background = {"#24272d", "#eeeeee"},
      foreground = {"#ABB2BF", "#606571"},
      lightness = -0.4,
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
        TSTag = { gui = "none", fg = "#EFDCBC" }
      }
    },
  },
})

-- vim.cmd([[colorscheme dark-pines]])
-- vim.cmd([[colorscheme summer-night]])
