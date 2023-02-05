local harmony = require("harmony")

local colors = require("harmony").colors

vim.opt.bg = "dark"

harmony.setup({
  ["*"] = {
    bg = { "#202124", "#ffffff" },
    fg = { "#dddddd", "#222222" },

    plugins = {
      "hrsh7th/nvim-cmp",
      "folke/todo-comments.nvim",
      "nvim-telescope/telescope.nvim",
      "lukas-reineke/indent-blankline.nvim",
      "nvim-neo-tree/neo-tree.nvim",
      "lewis6991/gitsigns.nvim",
    },

    highlights = {
      ProjectRoot = { bg = colors.bg_negative_1, fg = colors.accent },

      CursorLine = { bg = colors.bg_negative_1 },
      CursorLineSign = { bg = colors.bg_negative_1 },
      CursorLineNr = { bg = colors.bg_negative_1, fg = colors.fg_3 },
      CursorLineFold = { fg = colors.bg_negative_1, bg = colors.bg_negative_1 },

      FoldColumn = { fg = colors.fg_4 },

      Mode = { fg = colors.accent, bg = colors.bg_negative_2 },

      Dash = { fg = colors.bg_2 },

      StatusLine = { fg = colors.fg_2, bg = colors.bg_negative_1 },

      normal_mode = { fg = colors.bg_negative_1, bg = colors.green },
      insert_mode = { fg = colors.bg_negative_1, bg = colors.blue },
      visual_mode = { fg = colors.bg_negative_1, bg = colors.purple },
      line_mode = { fg = colors.bg_negative_1, bg = colors.purple },
      block_mode = { fg = colors.bg_negative_1, bg = colors.purple },
      replace_mode = { fg = colors.bg_negative_1, bg = colors.purple },
      select_mode = { fg = colors.bg_negative_1, bg = colors.yellow },
      command_mode = { fg = colors.bg_negative_1, bg = colors.yellow },
      terminal_mode = { fg = colors.bg_negative_1, bg = colors.green },

      ["@comment"] = { italic = true, fg = colors.fg_4 },
    },
  },

  ["default"] = {
    highlights = {
      ["@tag"] = { fg = "#EB9801" },
    },
  },

  ["solarized"] = {
    bg = "#202124",
    fg = "#b9cccc",
  },

  ["palenightfall"] = {
    bg = "#252836",
    fg = "#c8d0f7",
  },

  ["embark"] = {
    bg = "#1e1c31",
    fg = "#cdc7f9",
    red = "#F48FB1",
    accent = "#a37acc",
  },

  ["nord"] = {
    bg = "#24292d",
    fg = "#e1e3e8",
  },

  ["doom-one"] = {
    bg = "#17181E",
    fg = "#c7d6f9",
  },

  ["zenburn"] = {
    bg = "#1c1b1b",
    fg = "#cccccc",
    highlights = {
      ["@keyword"] = { fg = "#DDCEA2", bold = true },
    },
  },

  ["tokyonight"] = {
    bg = "#161820",
    fg = "#c9cee0",
  },

  ["onedark"] = {
    bg = { "#262A31", "#ffffff" },
    fg = { "#cdd1d8", "#888888" },
  },

  ["nocolor"] = {
    bg = { "#0B0D0F", "#ffffff" },
    fg = { "#818898", "#888888" },
  },

  ["everforest"] = {
    bg = "#1b2223",
    accent = "#A7C080",
  },

  ["iceberg"] = {
    bg = "#191b21",
    fg = "#C6C8D1",
    highlights = {
      ["@constructor.tsx"] = { fg = "#81ADB7" },
      ["@tag"] = { fg = "#7E9ABE" },
      ["@tag.delimiter"] = { fg = "#7F9ABF" },
      ["@variable"] = { clear = true },
    },
  },

  ["sonokai"] = {
    bg = "#1a1b1e",
  },

  ["vscode"] = {
    bg = "#1E1F1F",
  },
})

vim.api.nvim_cmd({ cmd = "colorscheme", args = { "summer-time" } }, {})
