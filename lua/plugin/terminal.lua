local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
  return
end

toggleterm.setup({
  size = vim.o.lines * 0.4,
  open_mapping = "<F2>",
  direction = "horizontal",
  shell = "zsh",
  on_open = function()
    vim.cmd("startinsert!")
  end,
  float_opts = {
    winblend = 0,
  },
})
