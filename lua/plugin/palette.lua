local status_ok, palette = pcall(require, "palette")

if not status_ok then
  return
end

-- stylua: ignore
palette.setup({
  on_change = function()
    vim.cmd([[source ~/.config/nvim/lua/plugin/bufferline.lua]])
  end,


  colors = {
    ["*"] = {
      background = { "#181a1c", "#efefef" },
      foreground = { "#ced2da", "#383A42" },

      highlights = {
        IndentBlankLineContextChar = { fg = "@foreground_4" },
      },
    },

    ["doom-one"] = {
      background = { "#161B1E", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
      green      = {"#98BE65", "#ffffff"},
      yellow     = {"#ECBE7B", "#ffffff"},
      blue       = { "#56B6C2", "#383A42" },
      purple     = { "#A9A1E1", "#383A42" },

      highlights = {
        -- IndentBlankLineContextChar = { fg = "@blue" },
      },
    },

    ["vscode"] = {
      background = { "#1E1E1E", "#efefef" },
      foreground = { "#ced2da", "#383A42" },

      highlights = {
        IndentBlankLineContextChar = { links = "@foreground_3" },
      },
    },

    ["zenburn"] = {
      background = { "#1E1E1E", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },
  },
})

-- vim.cmd([[colorscheme summer-time]])
-- vim.cmd([[colorscheme doom-one]])
