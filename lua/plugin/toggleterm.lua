local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
  return
end

toggleterm.setup({
  open_mapping = "<C-\\>",
  direction = "horizontal",
  shade_terminals = false,
  shell = "zsh",
  on_open = function()
    vim.cmd("set laststatus=0 | startinsert!")
  end,
  on_close = function()
    vim.cmd("set laststatus=3")
  end,
})
