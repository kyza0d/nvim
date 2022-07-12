vim.opt.background = "dark"

local status_ok, palette = pcall(require, "palette")

if not status_ok then
  return
end

local colors = palette.colors

local modules = {
  transparency = {
    Normal = { bg = "none" },
    NormalNC = { bg = "none" },
    EndOfBuffer = { bg = "none" },
    CursorLine = { bg = "none" },
    CursorLineNr = { bg = "none" },
    SignColumn = { bg = "none" },
    FoldColumn = { bg = "none" },
    Folded = { bg = "none" },

    LspReferenceRead = { bg = "none", gui = "underline" },
    LspReferenceText = { bg = "none", gui = "underline" },
    LspReferenceWrite = { bg = "none", gui = "underline" },
  },

  sign_column = {
    -- LineNr = { bg = colors.background_3, fg = colors.foreground_3 },
    VertSplit = { bg = colors.background_3, fg = colors.background_3 },
    SignColumn = { bg = colors.background_3 },
    FoldColumn = { bg = colors.background_3 },

    GitSignsAdd = { bg = colors.background_3, fg = colors.green },
    GitSignsDelete = { bg = colors.background_3, fg = colors.red },
    GitSignsChange = { bg = colors.background_3, fg = colors.blue },
    GitSignsAddNr = { bg = colors.background_3, fg = colors.green },
    GitSignsDeleteNr = { bg = colors.background_3, fg = colors.red },
    GitSignsChangeNr = { bg = colors.background_3, fg = colors.blue },

    DiagnosticSignError = { bg = colors.background_3, fg = colors.red },
    DiagnosticSignWarn = { bg = colors.background_3, fg = colors.yellow },
    DiagnosticSignInfo = { bg = colors.background_3, fg = colors.purple },
    DiagnosticSignHint = { bg = colors.background_3, fg = colors.blue },
  },

  menu = {
    -- NvimTree: Background
    Visual = { bg = "#22394c" },
    PmenuSel = { bg = "#22394c" },
  },
}

-- stylua: ignore
palette.setup({
  on_change = function()
    vim.cmd([[source ~/.config/nvim/lua/core/plugins/lualine.lua]])
    vim.cmd([[source ~/.config/nvim/lua/core/plugins/bufferline.lua]])
  end,

  prefer = "dark",

  colors = {
    ["*"] = { --      Dark       Light
      background = { "#16191B", "#ffffff" },
      foreground = { "#ced2da", "#000000" },
      red        = { "#E86671", "#000000" },
      green      = { "#6B8E23", "#000000" },
      yellow     = { "#D7AF5F", "#000000" },
      blue       = { "#61AFEF", "#000000" },
      purple     = { "#c792ea", "#000000" },
      accent     = { "#61AFEF", "#000000" },

      lightness = 0,

      highlights = {
        -- Not applying updated highlight on colorscheme change
        modules.menu,

        TelescopePromptBorder = { bg = "none" },
        TelescopePromptNormal = { bg = "none" },
        TelescopeResultsBorder = { bg = "none" },
        TelescopeResultsNormal = { bg = "none" },
        TelescopePreviewBorder = { bg = "none" },
        TelescopePreviewNormal = { bg = "none" },
        luaTSConstructor = {fg = "#546068"},
        -- modules.transparency,
        -- modules.inverse_ui,
        -- modules.sign_column
      },
    },

    ["catppuccin"] = {
      background = { "#25272d", "#ffffff" },
      foreground = { "#ced2da", "#000000" },
      red        = { "#E86671", "#000000" },
      green      = { "#6B8E23", "#000000" },
      yellow     = { "#D7AF5F", "#000000" },
      blue       = { "#61AFEF", "#000000" },
      purple     = { "#c792ea", "#000000" },
      accent     = { "#61AFEF", "#000000" },

      lightness = -20,
    },
  }
})

--   settings = {
--     lightness = -20,
--     saturation = -5,
--     contrast = 10,
--   },
