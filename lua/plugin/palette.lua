local status_ok, palette = pcall(require, "palette")

if not status_ok then
  return
end

palette.setup({
  on_change = function()
    vim.cmd([[source ~/.config/nvim/lua/plugin/lualine.lua]])
    vim.cmd([[source ~/.config/nvim/lua/plugin/bufferline.lua]])
  end,

  colors = {
    ["*"] = {
      background = { "#161616", "#efefef" },
      foreground = { "#ced2da", "#383A42" },
    },

    highlights = {
      IndentBlankLineContextChar = { fg = "#ff0000" },
    },

    ["doom-one"] = {
      background = { "#191C1F", "#3B224C" },
      foreground = { "#b7c2cc", "#3B224C" },
    },
  },
})

-- vim.cmd([[colorscheme summer-time]])
vim.cmd([[colorscheme doom-one]])
