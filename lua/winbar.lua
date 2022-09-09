local get_buf_info = require("utils.get_buf_info")

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if get_buf_info("%").listed == 1 then
      vim.opt_local.winbar = " "

      vim.opt_local.winbar:append('   %{expand("%:p:h:t")}  %{expand("%:p:t")}')
      vim.opt_local.winbar:append(" %{%v:lua.require'nvim-navic'.get_location()%}")

      vim.opt_local.winbar:append("%=")

      local icon, color_name = require("nvim-web-devicons").get_icon(vim.fn.expand("%:e"))

      if icon and color_name ~= nil then
        vim.opt_local.winbar:append(vim.bo.filetype)
        vim.opt_local.winbar:append("%#" .. color_name .. "# " .. icon .. "  ")
        return
      end

      vim.opt_local.winbar:append(vim.fn.expand("%:t:r") .. "    ")
    end
  end,
})
