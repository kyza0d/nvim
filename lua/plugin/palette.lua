local status_ok, palette = pcall(require, "palette")

if not status_ok then
  return
end

local color = require("palette").colors

-- stylua: ignore
palette.setup({
  on_change = function()
    vim.cmd([[source ~/.config/nvim/lua/plugin/bufferline.lua]])
    vim.cmd([[source ~/.config/nvim/lua/plugin/trouble.lua]])
    vim.cmd("hi FoldColumn guifg=" .. color.background_0)
    -- vim.cmd("hi TelescopePromptNormal guibg=" .. color.background_shaded_0)
  end,

  colors = {
    ["*"] = {
      background = { "#1D1F21", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      enable = false
    },

    ["blue"] = {
      background = {"#000087", "#ffffff"},
      foreground = { "#ced2da", "#383A42" },
    },

    ["solarized8_low"] = {
      background = { "#05252d", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },

    ["everforest"] = {
      background = { "#121412", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      accent = {"#E67E80", "#E67E80"},
      purple = {"#D699B6", "#D699B6"},
      blue = {"#7FBBB3", "#7FBBB3"},
      yellow = {"#DBBC7F", "#DBBC7F"},
      green = {"#A7C080", "#A7C080"}
    },

    ["iceberg"] = {
      background = { "#202228", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },

    ["oceanic-eightes"] = {
      background = { "#1a2b35", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },

    ["space_vim_theme"] = {
      background = {"#1B202A", "#ffffff"},
      foreground = {"#acbfe5", "#ffffff"}
    },

    ["doom-one"] = {
      background = {"#1a1c21", "#ffffff"},
      green      = { "#98BE65", "#ffffff" },
      yellow     = { "#ECBE7B", "#ffffff" },
      blue       = { "#53AFEB", "#383A42" },
      purple     = { "#A9A1E1", "#383A42" },
      accent     = { "#53AFEB", "#383A42" },
    },

    ["hybrid"] = {
      background = { "#1D1F21", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      accent = { "#7896B0", "#000000" }
    },

    ["spacegray"] = {
      background = { "#111314", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      accent = { "#99CC99", "#000000" }
    },

    ["nord"] = {
      background = { "#21252d", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      accent = {"#88C0D0", "#88C0D0"}
    },

    ["vscode"] = {
      background = { "#1E1E1E", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },

    ["gruvbox"] =  {
      background = { "#1C1C1C", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      accent = { "#D3869B", "#383A42" },
    },

    ["zenburn"] =  {
      background = { "#1E1E1E", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      accent = { "#7F9F7F", "#383A42" },
    },
  },
})

vim.cmd([[colorscheme summer-time]])
