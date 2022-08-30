local status_ok, palette = pcall(require, "palette")

if not status_ok then
	return
end

palette.setup({
  on_change = function()
    vim.cmd([[source ~/.config/nvim/lua/plugin/lualine.lua]])
    vim.cmd([[source ~/.config/nvim/lua/plugin/bufferline.lua]])
  end,
})

vim.cmd([[colorscheme zenburn]])
