local harmony = require("harmony")

local colors = require("harmony").colors

local lightness = require("harmony.factory").change_hex_lightness

vim.opt.background = "dark"

harmony.setup({
  ["*"] = {
    background = { "#222222", "#ffffff" },
    foreground = { "#ffffff", "#222222" },

    highlights = require("plugin.harmony.groups"),
  },

  ["embark"] = {
    background = "#1e1c31",
    foreground = "#dcdae5",
  },

  ["everforest"] = {
    background = "#000A0E",
    accent = "#A7C080",
  },

  ["tokyonight"] = {
    background = "#161820",
  },

  ["iceberg"] = {
    background = "#161820",
  },

  ["desert"] = {
    background = "#111111",
    foreground = "#ffffff",
    test = "#ffffff",
    red = "#E86671",

    highlights = {
      Normal = {
        bg = colors.background,
        fg = colors.foreground,
      },
    },
  },
})

vim.api.nvim_cmd({ cmd = "colorscheme", args = { "embark" } }, {})
