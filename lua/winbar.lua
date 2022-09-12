local get_buf_info = require("utils.get_buf_info")
local empty = require("utils.empty")

local colors = require("palette").colors

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if get_buf_info("%").listed == 1 then
      vim.opt_local.winbar = ""

      vim.cmd(string.format("hi SignColumnWinbar guibg=%s guifg=%s gui=strikethrough", colors.background_3, colors.foreground_1))
      -- vim.opt_local.winbar:append('%#SignColumnWinbar#       %#Winbar#   %{expand("%:p:h:t")}/%{expand("%:p:t:r")}')
      vim.opt_local.winbar:append('    %{expand("%:p:h:t")}/%{expand("%:p:t:r")}')
      -- vim.opt_local.winbar:append(" %{%v:lua.require'nvim-navic'.get_location()%}")

      vim.opt_local.winbar:append("%=")

      vim.opt_local.winbar:append("[" .. vim.bo.filetype .. "] ")
    end
  end,
})
