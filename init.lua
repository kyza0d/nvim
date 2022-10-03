-- require("plugin.palette") -- Must be loaded before impatient

require("impatient")
require("impatient").enable_profile()

require("globals")
require("options")
require("keymaps")
require("autocmds")

require("plugin.packer")

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  command = "set statusline=%{%v:lua.require('statusline').active()%}",
})

require("winbar")

vim.cmd([[
 hi FoldColumn guifg=#24283B
]])

vim.opt.shadafile = "NONE"
vim.opt.shadafile = ""
