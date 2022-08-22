local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
  return
end

local hide_ui = function()
  vim.cmd("setlocal showtabline=0")
  vim.cmd("setlocal laststatus=0")
end

local restore_ui = function()
  vim.cmd("setlocal showtabline=2")
  vim.cmd("setlocal laststatus=2")
end

toggleterm.setup({
  open_mapping = "<F1>",
  direction = "horizontal",
  shade_terminals = false,
  shell = "zsh",
  -- on_close = restore_ui,
  on_open = function()
    vim.cmd("set laststatus=0")
    vim.cmd("startinsert!")
  end,
  on_close = function()
    vim.cmd("set laststatus=3")
    vim.cmd("startinsert!")
  end,
})

local Terminal = require("toggleterm.terminal").Terminal

_lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "tab", on_open = hide_ui, on_close = restore_ui })
_spotify = Terminal:new({ cmd = "spt", hidden = true, direction = "tab", on_open = hide_ui, on_close = restore_ui })
