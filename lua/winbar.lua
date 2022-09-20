local get_buf_info = require("utils.get_buf_info")
local empty = require("utils.empty")

local icons = require("options").icons

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "ColorScheme" }, {
  callback = function()
    if get_buf_info("%").listed == 1 then
      local colors = require("palette").colors

      vim.opt_local.winbar = ""

      local icon, color = require("nvim-web-devicons").get_icon_color(vim.fn.expand("%:e"), vim.bo.filetype)

      color = color or ""
      icon = icon or ""

      vim.api.nvim_command(string.format("hi Icon guifg=%s guibg=%s", color, colors.background_0))
      icon = "%#Icon#" .. icon .. " %#WinBar#"

      vim.opt_local.winbar:append("  ")
      vim.opt_local.winbar:append(icon)

      vim.opt_local.winbar:append('%{expand("%:p:h:t")}' .. icons.chevron .. '%{expand("%:p:t:r")}')
      -- vim.opt_local.winbar:append(" %{%v:lua.require'nvim-navic'.get_location()%}")

      vim.opt_local.winbar:append("%=")

      vim.opt_local.winbar:append("[" .. vim.bo.filetype .. "] ")
    end
  end,
})
