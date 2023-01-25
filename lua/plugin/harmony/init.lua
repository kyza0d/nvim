local harmony = require("harmony")

local colors = require("harmony").colors

vim.opt.background = "dark"

harmony.setup({
  ["*"] = {
    background = { "#202124", "#ffffff" },
    foreground = { "#dddddd", "#222222" },

    plugins = {
      "akinsho/bufferline.nvim",
      "hrsh7th/nvim-cmp",
      "SmiteshP/nvim-navic",
      "folke/todo-comments.nvim",
      "nvim-telescope/telescope.nvim",
      "lukas-reineke/indent-blankline.nvim",
      "nvim-neo-tree/neo-tree.nvim",
      "lewis6991/gitsigns.nvim",
    },

    highlights = {
      ProjectRoot = { background = colors.background_negative_1, foreground = colors.blue },
      -- Visual = { reverse = true },

      CursorLine = { background = colors.background_negative_1 },
      CursorLineSign = { background = colors.background_negative_1 },
      CursorLineNr = { background = colors.background_negative_1, foreground = colors.foreground_3 },
      CursorLineFold = { foreground = colors.background_negative_1, background = colors.background_negative_1 },

      FoldColumn = { foreground = colors.background_0 },

      ScrollbarSearch = { foreground = colors.yellow },
      ScrollbarSearchHandle = { foreground = colors.yellow, background = colors.background_4 },
      ScrollbarHandle = { background = colors.background_4 },
      ScrollbarCursorHandle = { background = colors.background_4, foreground = colors.foreground_4 },
      ScrollbarErrorHandle = { background = colors.background_4, foreground = colors.red },
      ScrollbarHintHandle = { background = colors.background_4, foreground = colors.blue },
      ScrollbarInfoHandle = { background = colors.background_4, foreground = colors.blue },
      ScrollbarWarningHandle = { background = colors.background_4, foreground = colors.yellow },

      VertSplit = { foreground = colors.foreground_2, background = colors.background_4 },

      Mode = { foreground = colors.accent, background = colors.background_negative_2 },
      MsgArea = { background = colors.background_0 },

      Dash = { foreground = colors.background_2 },

      StatusLine = { foreground = colors.foreground_2, background = colors.background_negative_2 },

      normal_mode = { foreground = colors.background_negative_2, background = colors.green },
      insert_mode = { foreground = colors.background_negative_2, background = colors.blue },
      visual_mode = { foreground = colors.background_negative_2, background = colors.purple },
      line_mode = { foreground = colors.background_negative_2, background = colors.purple },
      block_mode = { foreground = colors.background_negative_2, background = colors.purple },
      replace_mode = { foreground = colors.background_negative_2, background = colors.purple },
      select_mode = { foreground = colors.background_negative_2, background = colors.yellow },
      command_mode = { foreground = colors.background_negative_2, background = colors.yellow },
      terminal_mode = { foreground = colors.background_negative_2, background = colors.green },

      ["@comment"] = { italic = true, foreground = colors.foreground_4 },
    },
  },

  ["default"] = {
    -- background = "#010101",
    highlights = {
      ["@tag"] = { foreground = "#EB9801" },
    },
  },

  ["solarized"] = {
    background = "#202124",
    -- background = "#002B36",
    foreground = "#b9cccc",
  },

  -- ["oh-lucy-evening"] = {
  --   background = "#1e1c31",
  -- },

  ["palenightfall"] = {
    background = "#252836",
    foreground = "#c8d0f7",
  },

  ["embark"] = {
    background = "#1e1c31",
    -- background = "#202124",
    foreground = "#cdc7f9",
    -- foreground = "#CBE3E7",
    red = "#F48FB1",
  },

  ["nord"] = {
    background = "#24292d",
    foreground = "#e1e3e8",
  },

  ["doom-one"] = {
    -- background = "#24262b",
    -- background = "#242634",
    background = "#17181E",
    foreground = "#c7d6f9",
    -- highlights = {
    --   ["@comment"] = { italic = true, foreground = colors.foreground_4 },
    --   Visual = { background = "#215397" },
    --   Pmenu = { background = colors.background_negative_2, foreground = colors.foreground_2 },
    --   PmenuSel = { background = "#4DA5E1", foreground = colors.background_negative_2 },
    --   TelescopePrefix = { background = "#4DA5E1", foreground = "#4DA5E1" },
    --   TelescopeSelection = { background = "#4DA5E1", foreground = colors.background_negative_2 },
    --   TelescopeSelectionCaret = { background = "#4DA5E1", foreground = "#4DA5E1" },
    --   -- TelescopeMatching = { clear = true },
    -- },
  },

  ["zenburn"] = {
    -- background = "#24262b",
    background = "#1c1b1b",
    foreground = "#cccccc",
    highlights = {
      ["@keyword"] = { foreground = "#DDCEA2", bold = true },
    },
  },

  ["tokyonight"] = {
    background = "#161820",
    foreground = "#c9cee0",
  },

  ["onedark"] = {
    background = { "#262A31", "#ffffff" },
    foreground = { "#cdd1d8", "#888888" },
  },

  ["everforest"] = {
    background = "#1b2223",
    accent = "#A7C080",
  },

  ["iceberg"] = {
    -- background = "#0B0D0F",
    background = "#191b21",
    -- background = "#000000",
    foreground = "#C6C8D1",
    highlights = {
      ["@constructor.tsx"] = { foreground = "#81ADB7" },
      ["@tag"] = { foreground = "#7E9ABE" },
      ["@tag.delimiter"] = { foreground = "#7F9ABF" },
      ["@variable"] = { clear = true },
    },
  },

  ["sonokai"] = {
    background = "#1a1b1e",
  },

  ["vscode"] = {
    background = "#1E1F1F",
  },
})

vim.api.nvim_cmd({ cmd = "colorscheme", args = { "iceberg" } }, {})
-- vim.api.nvim_cmd({ cmd = "colorscheme", args = { "doom-one" } }, {})
vim.api.nvim_cmd({ cmd = "highlight", args = { "clear", "TelescopeMatching" } }, {})
