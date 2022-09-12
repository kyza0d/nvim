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
  end,

  colors = {
    ["*"] = {
      background = { "#0B0D0F", "#efefef" },
      foreground = { "#ced2da", "#383A42" },

      highlights = {
        -- TSComment = { fg = "#555555", gui = "italic" },
      },
    },

    ["doom-one"] = {
      background = {"#1a1c21", "#ffffff"},
      green      = { "#98BE65", "#ffffff" },
      yellow     = { "#ECBE7B", "#ffffff" },
      blue       = { "#53AFEB", "#383A42" },
      purple     = { "#A9A1E1", "#383A42" },

      highlights = {
        -- IndentBlankLineContextChar = { fg = "@blue" },
      },
    },

    ["hybrid"] = {
      background = { "#1D1F21", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },

    ["vscode"] = {
      background = { "#1E1E1E", "#efefef" },
      foreground = { "#ced2da", "#383A42" },

      highlights = {
        -- IndentBlankLineContextChar = { links = "@foreground_3" },
      },
    },

    -- ["zenburn"] = {
    ["zenburn"] =  {
      background = { "#1E1E1E", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },
  },
})

-- vim.cmd([[colorscheme summer-time]])
vim.cmd([[colorscheme doom-one]])

vim.cmd([[hi! clear Normal]])
