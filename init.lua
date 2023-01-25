require("impatient")
require("impatient").enable_profile()

require("globals")
require("aliases")
require("options")
require("keymaps")
require("autocmds")
require("plugin.packer")

vim.opt.shadafile = "NONE"
vim.opt.shadafile = ""

-- To disable bufferline without uninstalling it
-- vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
--   command = "set showtabline=0",
-- })

require("winbar")

vim.keymap.set("n", "<F1>", function()
  require("stylish").ui_menu(vim.fn.menu_get(""), { kind = "menu", prompt = "Main menu", experimental_mouse = true }, function(res)
    print("### " .. res)
  end)
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  command = "set statusline=%{%v:lua.require('statusline').active()%}",
})

vim.cmd([[
 hi FoldColumn guifg=#24283B
]])
