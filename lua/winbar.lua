local get_buf_info = require("utils.get_buf_info")

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if get_buf_info("%").listed == 1 then
      vim.opt_local.winbar = ""
      vim.opt_local.winbar:append('   %{expand("%:p:h:t")}  %{expand("%:p:t")}')
      vim.opt_local.winbar:append(" %{%v:lua.require'nvim-navic'.get_location()%}")
    end
  end,
})
