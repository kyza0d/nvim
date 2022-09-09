require("globals")
require("options")
require("keymaps")
require("autocmds")
require("winbar")

require("plugin.packer")

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  command = "set statusline=%{%v:lua.require'statusline'.statusline()%}",
})
